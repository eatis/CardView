//
//  OverlayView.swift
//  CardView
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
        self.addSubview(imageView)
    }
    
    func setMode(mode: GGOverlayMode) {
        print("load setMode")
        
        print(mode)
        if mode == GGOverlayMode.Left {
            imageView.image = UIImage(named: "noButton")
        } else {
            imageView.image = UIImage(named: "yesButton")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRectMake(50, 50, 100, 100)
    }
}
