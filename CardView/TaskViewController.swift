//
//  TaskViewController.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/04/13.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UITableViewController, UITextFieldDelegate {
    // var todos = try! Realm().objects(Task)
    
    let uiRealm = try! Realm()
    var selectedTask:Task?
//    var todos: Results<Task> {
//        get {
//            let config = Realm.Configuration(
//                schemaVersion: 3,
//                
//                migrationBlock: { migration, oldSchemaVersion in
//                    if (oldSchemaVersion < 1) {
//                    }
//            })
//            
//            Realm.Configuration.defaultConfiguration = config
//            
//            return uiRealm.objects(Task)
//        }
//    }
    var todos: Results<Task>!
    var isEditingMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // self.deleteTasks()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        readTasksAndUpdateUI()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteTasks() {
        let realm = try! Realm()
        try! realm.write() {
            realm.deleteAll()
        }
        
    }
    
    
    // functions needed to be implemented
    // for table view
    
    // セクション数
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // セクションの行数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        
        print(todos[indexPath.row].taskName as NSString)
        
        cell.setCell(todos[indexPath.row] as Task)
        
        return cell
    }
    
    // Cell が選択された場合
    override func tableView(table: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        // selectedImage = UIImage(named:"\(imgArray[indexPath.row])")
        selectedTask = todos[indexPath.row] as Task
            // SubViewController へ遷移するために Segue を呼び出す
        performSegueWithIdentifier("toDetailViewController",sender: nil)
        
    }
    
    // Segue 準備
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toDetailViewController") {
            let detailVC: DetailViewController = (segue.destinationViewController as? DetailViewController)!
            // SubViewController のselectedImgに選択された画像を設定する
            detailVC.testVar = selectedTask
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (deleteAction, indexPath) -> Void in
            let todoToBeDeleted = self.todos[indexPath.row]
            
            try! self.uiRealm.write({ () -> Void in
                self.uiRealm.delete(todoToBeDeleted)
                self.readTasksAndUpdateUI()
            })

        }
        let editAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Edit") { (editAction, indexPath) -> Void in
            
            self.selectedTask = self.todos[indexPath.row] as Task
            self.performSegueWithIdentifier("toDetailViewController", sender: nil)
        }
        return [deleteAction, editAction]
    }
    
    func readTasksAndUpdateUI() {
        todos = uiRealm.objects(Task)
        self.tableView.setEditing(false, animated: true)
        self.tableView.reloadData()
    }
    
}
