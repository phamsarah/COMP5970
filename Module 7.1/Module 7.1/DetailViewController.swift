//
//  Sarah Pham
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionTextField: UITextView!
    @IBOutlet weak var detailTitleTextField: UITextField!
    
    var masterController: MasterViewController!
    var cancel = false
    
    var textFieldStuffFromDetail: String!


    func configureView() {

            if let title = detailTitleTextField {
                title.text = masterController?.toDoItemTitle[masterController.selectedItem]
            }

        detailDescriptionTextField.text = masterController?.toDoItemDescription[masterController.selectedItem]
        
    }

    override func viewWillAppear(_ animated: Bool) {
        configureView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        // If we click save when the detail view disappears, then update the title/description arrays in the masterTableViewController
        if(!cancel){
            masterController?.toDoItemTitle[masterController.selectedItem] = detailTitleTextField!.text ?? "New Item"
            masterController?.toDoItemDescription[masterController.selectedItem] = detailDescriptionTextField!.text ?? ""
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

