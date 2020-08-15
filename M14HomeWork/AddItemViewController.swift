//
//  AddItemViewController.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 01.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import UIKit
import RealmSwift



class AddItemViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var AffairTextField: UITextField!
    
    @IBOutlet weak var CommentTextField: UITextField!
    
    private let realm = try! Realm()
   
    
    
    @IBOutlet weak var DatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AffairTextField.becomeFirstResponder()
        AffairTextField.delegate = self
        DatePicker.setDate(Date(), animated: true)
        // Do any additional setup after loading the view.
    }
//    Функция, чтобы убрать клавиатуру после редактирования
    func textFieldShouldReturn(_ AffairTextField: UITextField) -> Bool {
        AffairTextField.resignFirstResponder()
        return true
    }
    
  
    
        
    
    
    @IBAction func saveButton(_ sender: Any) {

        let item = Item()
        item.name = self.AffairTextField.text!
        item.date = DatePicker.date
        
        try! self.realm.write {
            self.realm.add(item)
           self.performSegue(withIdentifier: "Seg1", sender: self)
           
            
            
        }
        
        
}
}
