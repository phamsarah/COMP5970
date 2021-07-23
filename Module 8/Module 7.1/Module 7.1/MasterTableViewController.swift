//
// Sarah Pham
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var toDoItems: [[String:String]] = []
    var selectedItem = 0
    
    // Fetching url of file 
    func dataFileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:URL?
        url = URL(fileURLWithPath: "")
        url = urls.first!.appendingPathComponent("data.plist")
        return url!
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("_\(NSHomeDirectory())")
        
        let fileURL = self.dataFileURL()
        if(FileManager.default.fileExists(atPath: fileURL.path)){
            
            // initialize from the data file in the directory if there is one, load items from file into toDoItems array
            print("found file")
            toDoItems = (NSArray(contentsOf: fileURL as URL) as? [[String:String]])!
            
        } else {
            
            // Getting contents from Plist to populate toDoItems Array
            if let URL = Bundle.main.url(forResource: "Property List", withExtension: "plist"){
                if let arrayFromPlist = NSArray(contentsOf: URL) as? [Dictionary<String,String>] {
                    toDoItems = arrayFromPlist
                }
            }
        }
        
        // Rename the back button to Save that is on DetailViewController, we do this here because
        //  masterViewController has access to the navigationItem
        navigationItem.backButtonTitle = "Save"

        // Setting add button to call insertNewObject whenever selected
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
    
        // Initiallizing splitViewController
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }

        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification: )), name: UIApplication.willResignActiveNotification, object: nil)
    }

    // Whenever the view shows, reload the tableView data
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    @objc
    func insertNewObject(_ sender: Any) {
        toDoItems.insert(["Title": "New Item", "Description": ""], at: 0)
        
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    // When app is suspended, grab file url, cast toDoItems to be a next step array, then store data, saves to URL (save data)
    @objc func applicationWillResignActive(notification:NSNotification){
        print("Saved data")
        let fileURL = self.dataFileURL()
        let array = (self.toDoItems as NSArray)
        array.write(to: fileURL as URL, atomically: true)
    }

    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            // If table cell was tapped, take selectedItem to the detailView
            if let indexPath = tableView.indexPathForSelectedRow{
                selectedItem = indexPath.row
            }
            //else { selectedItem = toDoItems.count - 1 }
            else { selectedItem = 0 }
            
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            detailViewController = controller
            detailViewController!.masterController = self
                
        }
    }
    
    // Route from Detail View back to root MasterTableViewController
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("UNWIND SEGUE CALLED")
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }

    // Fill the table cell text with only the to do item title
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel!.text = toDoItems[indexPath.row]["Title"]
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


}

