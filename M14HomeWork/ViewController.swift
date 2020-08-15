//
//  ViewController.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 29.07.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    
    
    @IBOutlet weak var SurnameTextField: UITextField!
//    Allow data to work with UserDefailts
    let defaults  = UserDefaults.standard
//    Setting values
    struct keys {
        static let name = "name"
        static let surname = "surname"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkInformation()
    }
   
    
    @IBAction func SaveButton(_ sender: Any) {
        saveName()
    }
    
    
    
    func saveName(){
        defaults.set(NameTextField.text, forKey: "name")
        defaults.set(SurnameTextField.text, forKey: "surname")
    }
    
    
    func checkInformation(){
        let name = defaults.value(forKey: keys.name) as? String ?? ""
        let surname = defaults.value(forKey: keys.surname) as? String ?? ""
        NameTextField.text = name
        SurnameTextField.text = surname
    }

}

