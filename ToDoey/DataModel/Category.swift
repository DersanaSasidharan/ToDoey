//
//  Category.swift
//  ToDoey
//
//  Created by Dersana on 08/01/19.
//  Copyright © 2019 Dersana. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
