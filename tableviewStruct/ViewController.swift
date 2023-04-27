//
//  ViewController.swift
//  tableviewStruct
//
//  Created by Mohan K on 17/02/23.
//

import UIKit


struct Task {
    var id : Int
    var taskName: String
    var colour: UIColor
    var status: Int
    var priority: Int
}

class mycollectionCell: UITableViewCell {
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    
}
class ViewController: UIViewController {

  
    var allTasks = [Task(id: 1, taskName: "time", colour: .red, status: 1, priority: 1)
                    ,Task(id: 2, taskName: "Intreval", colour: .brown , status: 2, priority: 2),
                    Task(id: 3, taskName: "break", colour: .darkGray, status: 3, priority: 3)]
  
    
    
    @IBOutlet weak var mytableView: UITableView!
   
    @IBOutlet weak var entryTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
   
@objc private func keyboardWillHide(notification: NSNotification) {
    mytableView.contentInset = .zero
   }

@objc private func keyboardWillShow(notification: NSNotification) {
       if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
           mytableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + mytableView.rowHeight, right: 0)
       }
    
}
    
    @IBAction func updateBtn(_ sender: Any) {
       print("updateBtn")
        if let index = allTasks.firstIndex(where: { $0.id == 1 }) {
            allTasks[index].colour = .systemCyan
            allTasks[index].taskName = "Mohan"
        }
        DispatchQueue.main.async {
            self.mytableView.reloadData()
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        if let data = UserDefaults.standard.object(forKey: "todo list") as? Data
//        {
//            allTasks = try!
//            PropertyListDecoder().decode(Array<Task>.self, from: data)
//        }
//        else{
//
//        }
//    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mytableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! mycollectionCell
        cell.text1.text = allTasks[indexPath.row].taskName
        cell.backgroundColor = allTasks[indexPath.row].colour
        cell.text2.text = "\(allTasks[indexPath.row].status)"
        cell.text3.text = "\(allTasks[indexPath.row].priority)"
        return cell
        
    }
    
    
    }
    
 
