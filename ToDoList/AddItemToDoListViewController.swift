
import UIKit

class AddItemToDoListViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var infoTask: UITextField!
    @IBOutlet weak var titleTask: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    var toDoListItem : ToDoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        toDoListItem?.saveAdd(title: titleTask.text!, info: infoTask.text!,  date: datePicker.date)
        navigationController?.popToRootViewController(animated: true)
    }
}
