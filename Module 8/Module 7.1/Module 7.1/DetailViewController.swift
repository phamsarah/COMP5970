//
//  Sarah Pham
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailTitleTextField: UITextField!
    @IBOutlet weak var detailDescriptionTextField: UITextView!
    
    var masterController: MasterViewController!
    var cancel = false


    // Filling up textfields with content from masterTableViewController, if nil then fill with default content
    func configureView() {
        let toDoItemsRow = masterController?.toDoItems[masterController.selectedItem]
            if let title = detailTitleTextField {
                title.text = toDoItemsRow?["Title"]
            }

        detailDescriptionTextField.text = toDoItemsRow?["Description"]
    }

    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // If we click save when the detail view disappears, then update the title/description arrays in the masterTableViewController, if content of textfields are nil then fill with default data
        if(!cancel){
            masterController?.toDoItems[masterController.selectedItem]["Title"] = detailTitleTextField!.text ?? "New Item"
            masterController?.toDoItems[masterController.selectedItem]["Description"] = detailDescriptionTextField!.text ?? ""
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Creating a Cancel button on the navigation bar, calling function cancelButton if selected
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton(_:)))
        navigationItem.rightBarButtonItem = cancelButton
        
        configureView()
        
    }
    
    @objc
    func cancelButton(_ sender: Any){
        cancel = true
        performSegue(withIdentifier: "unWindSegue", sender: self)
    }
    
}

