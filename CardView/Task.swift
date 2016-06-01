//
//  Task.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/04/13.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object {
    // dynamic var id = 0
    dynamic var taskName = ""
    dynamic var yomi = ""
    dynamic var emoji = ""
    dynamic var date = NSDate()
    
//    override static func primaryKey() -> String? {
//        return "id"
//    }
}