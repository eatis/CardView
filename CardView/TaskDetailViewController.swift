//
//  TaskDetailViewController.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/05/11.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import UIKit
import RealmSwift

class TaskDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    
    
//    @IBAction func closeModalDialog(sender: UIBarButtonItem) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    @IBAction func addTask(sender: UIBarButtonItem) {

        if textField?.text?.utf16.count > 0 {
            createTask()
            dismissViewControllerAnimated(true) { () -> Void in
                // 何か...
            }
        }
    }
    
    func createTask() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        // let stringDate = formatter.stringFromDate(now)
        
        let task = Task()
        task.taskName = textField.text!
        task.date = NSDate()
        let realm = try! Realm()
        try! realm.write {
            realm.add(task)
        }
    }
    
    override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
        navigationController?.popViewControllerAnimated(true)
    }
}

