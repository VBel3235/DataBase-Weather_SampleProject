//
//  CoreDataTaskViewController.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 04.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import UIKit
import CoreData

class CoreDataTaskViewController: UIViewController {
    
    
    @IBOutlet weak var CoreDataTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    var tasksArray: [ToDo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        

        // Do any additional setup after loading the view.
    }
    func fetchData(){
        do{
            self.tasksArray =  try context.fetch(ToDo.fetchRequest())
            
            DispatchQueue.main.async {
                self.CoreDataTableView.reloadData()
            }
           
        } catch{
            
        }
    }

    @IBAction func AddTask(_ sender: Any) {
        let alert = UIAlertController(title: "Добавить задачу", message: "Что Вы хотите сделать", preferredStyle: .alert)
        alert.addTextField()
        let saveButton = UIAlertAction(title: "Сохранить", style: .default) { (action) in
            let textField = alert.textFields![0]
            let newTask = ToDo(context: self.context)
            newTask.task = textField.text
            
            do{
                try self.context.save()
            } catch{
                
            }
            
            self.fetchData()
            
            
        }
        
        
        alert.addAction(saveButton)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    

}
extension CoreDataTaskViewController: UITableViewDelegate, UITableViewDataSource{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.tasksArray.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: "CoreCell", for: indexPath) as! CoreCell
    let currentTask = self.tasksArray[indexPath.row]
    cell.CoreLabel.text = currentTask.task
    cell.CoreLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    
   cell.CoreBackgroundView.layer.cornerRadius = 9
   cell.CoreBackgroundView.backgroundColor = #colorLiteral(red: 0.8142130971, green: 0, blue: 0.08599405736, alpha: 1)
   cell.CoreBackgroundView.layer.shadowColor = UIColor.black.cgColor
   cell.CoreBackgroundView.layer.shadowRadius = 3
   cell.CoreBackgroundView.layer.shadowOpacity = 0.8
   cell.CoreBackgroundView.layer.shadowOffset = .zero
    
  
    
 
    

    return cell
}
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completionHandler) in
            let tasktoDelete = self.tasksArray[indexPath.row]
            
            
            self.context.delete(tasktoDelete)

            do{
                try self.context.save()
            } catch{}
            
            self.fetchData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}
