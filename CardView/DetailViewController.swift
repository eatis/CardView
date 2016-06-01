//
//  DetailViewController.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/06/01.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var testVar:Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(testVar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
