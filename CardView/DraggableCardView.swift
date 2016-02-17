//
//  DraggableCardView.swift
//  CardView
//

import UIKit

class DraggableCardView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    class func instance() -> DraggableCardView {
        return UINib(nibName: "CardView", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! DraggableCardView
    }
    
    
}
