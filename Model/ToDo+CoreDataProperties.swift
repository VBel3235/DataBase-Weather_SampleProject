//
//  ToDo+CoreDataProperties.swift
//  
//
//  Created by Владислав Белов on 05.08.2020.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var task: String?
    @NSManaged public var date: String?

}
