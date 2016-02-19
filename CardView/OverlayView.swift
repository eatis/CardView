//
//  OverlayView.swift
//  CardView
//
//  Created by 谷田　裕樹 on 2016/02/19.
//  Copyright © 2016年 谷田　裕樹. All rights reserved.
//

import UIKit

enum GGOverlayMode: Int {
    case Left
    case Right
}

class OverlayView: UIView {
    var mode: GGOverlayMode?
    var imageView: UIImageView = UIImageView()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        imageView = UIImageView(image: UIImage(named: "noButton"))
        self.addSubview(imageView)
    }
    
    func setMode(mode: GGOverlayMode) {
        print("load setMode")
        
        print(mode)
        if mode == GGOverlayMode.Left {
            // ここをLabelにする
            imageView.image = UIImage(named: "noButton")
        } else {
            // ここをLabelにする
            imageView.image = UIImage(named: "yesButton")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectMake(50, 50, 100, 100)
    }
}
