//
//  RealmToDoViewController.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 01.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import RealmSwift
import UIKit


class RealmToDoViewController: UIViewController {
 
    

    @IBOutlet weak var ToDoTableView: UITableView!
    
    var realm: Realm!
    
    var affairsArray: Results<Item> {
        get {
            return realm.objects(Item.self)
        }
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
      
        
        realm = try! Realm()
        
        ToDoTableView.reloadData()
        print(affairsArray)

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.ToDoTableView.reloadData()
            }
        }
    }
 
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()

}
    extension RealmToDoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        affairsArray.count
    }
        
        
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath) as! ToDoCell
        let SortedArray = affairsArray.sorted(by: {
            $0.date.compare($1.date) == .orderedAscending
        })
        let item = SortedArray[indexPath.row]
        cell.AffairsLabel.text = item.name
        cell.DateLabel.text = Self.dateFormatter.string(from: item.date)
       

        
        cell.DesignBV.layer.cornerRadius = 9
        cell.DesignBV.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        cell.DesignBV.layer.shadowColor = UIColor.black.cgColor
        cell.DesignBV.layer.shadowRadius = 3
        cell.DesignBV.layer.shadowOpacity = 0.8
        cell.DesignBV.layer.shadowOffset = .zero
        cell.AffairsLabel.textColor = UIColor.white
        cell.DateLabel.textColor = UIColor.white
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.DesignBV.bounds
        gradientLayer.cornerRadius = 9
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.colors = [UIColor.purple.cgColor, UIColor.systemIndigo.cgColor]
        cell.DesignBV.layer.addSublayer(gradientLayer)
       
        return cell
        
        
    }
        



        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let action = UIContextualAction(style: .destructive, title: "Удалить") { (action, view, completionHandler) in
                let item = self.affairsArray[indexPath.row]
                try! self.realm.write{
                    self.realm.delete(item)
                    self.ToDoTableView.reloadData()
            }
        }
    return UISwipeActionsConfiguration(actions: [action])
}


    
}
    
    
    

