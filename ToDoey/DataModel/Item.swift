//
//  Item.swift
//  ToDoey
//
//  Created by Dersana on 08/01/19.
//  Copyright © 2019 Dersana. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated : Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
