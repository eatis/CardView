//
//  CustomCell.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/04/13.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(task: Task) {
        self.taskName.text = task.taskName as String
        // let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        self.date.text = formatter.stringFromDate(task.date)
    }
}
