//
// Sarah Pham
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    // Yes, creating two arrays is less efficient than having a key:value array, but that was
    //  too complicated for this assignment
    var toDoItemTitle = [String]()
    var toDoItemDescription = [String]()
    var selectedItem = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }

    // Whenever the view shows, reload the tableView data
    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    

    @objc
    func insertNewObject(_ sender: Any) {
        
        toDoItemTitle.insert("New Item", at: 0)
        toDoItemDescription.insert("", at: 0)
        
        print("ran insert" + toDoItemTitle[0])
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        performSegue(withIdentifier: "showDetail", sender: self)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            
            // If table cell was tapped, take selectedItem to the detailView
            if let indexPath = tableView.indexPathForSelectedRow{
                selectedItem = indexPath.row
            }
            else { selectedItem = 0 }
            
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
            detailViewController = controller
            detailViewController!.masterController = self
                
        }
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        print("UNWIND SEGUE CALLED")
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItemTitle.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let toDoItemTitle = toDoItemTitle[indexPath.row]
        cell.textLabel!.text = toDoItemTitle
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


}

