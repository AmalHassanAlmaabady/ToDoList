
import UIKit
import CoreData

protocol ToDoList : AnyObject{
    func saveAdd(title: String, info: String, date: Date)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoList {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var listItem = [Item]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fechAllItems()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func saveAdd(title: String, info: String, date: Date) {
        if title != "" && info != ""{
            let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedObjectContext) as! Item
            item.itemTitle = title
            item.itemInfo = info
//            item.itemInfo = info
            print(info)
            item.itemDate = date
            listItem.append(item)
            do{
                try managedObjectContext.save()
            }catch{ print("\(error)")
            }
            tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segue = segue.destination as! AddItemToDoListViewController
        segue.toDoListItem = self
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listItem.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath) as! CellItemTableViewCell
        let listItems = listItem[indexPath.row]
        cell.descriptionTask.text = listItems.itemInfo
        cell.titleTask.text = listItems.itemTitle
        let formatterDate = DateFormatter()
        formatterDate.dateFormat = "dd/MM/yyyy"
        cell.dateTask.text = formatterDate.string(from: listItems.itemDate!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 113
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        managedObjectContext.delete(listItem[indexPath.row])
        do{
            try self.managedObjectContext.save()
        }catch {
            print("\(error)")
        }
        listItem.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let checkMark = tableView.cellForRow(at: indexPath as IndexPath) {
            if checkMark.accessoryType == .checkmark {
                checkMark.accessoryType = .none
            } else {
                checkMark.accessoryType = .checkmark
            }
        }
         
    }
    
    func fechAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        do{
            let result = try managedObjectContext.fetch(request)
            listItem = result as! [Item]
        }catch{
            print("\(error)")
        }
    }
}
