//
//  Item.swift
//  M14HomeWork
//
//  Created by Владислав Белов on 02.08.2020.
//  Copyright © 2020 Владислав Белов. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
   
    
}
