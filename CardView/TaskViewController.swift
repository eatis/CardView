//
//  TaskViewController.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/04/13.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import UIKit

class TaskViewController: UITableViewController {

    
    var tasks:[Task] = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupTasks()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTasks() {
        let now = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let string = formatter.stringFromDate(now)
        
        let task1 = Task(taskName: "掃除", date: string)
        let task2 = Task(taskName: "皿洗い", date: string)
        let task3 = Task(taskName: "昼寝", date: string)
        
        tasks.append(task1)
        tasks.append(task2)
        tasks.append(task3)
    }
    
    
    // functions needed to be implemented
    // for table view
    
    // セクション数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションの行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        print(cell)
        
        cell.setCell(tasks[indexPath.row])
        
        return cell
    }
}
