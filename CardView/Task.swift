//
//  Task.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/04/13.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import Foundation

class Task : NSObject {
    var taskName:NSString
    var date:NSString
    
    init(taskName: String, date: String){
        self.taskName = taskName
        self.date = date
    }
}