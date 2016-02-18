//
//  DraggableCardView.swift
//  CardView
//

import UIKit

protocol DraggableCardViewDelegate {
    func cardSwipedLeft(card: UIView)
    func cardSwipedRight(card: UIView)
}

class DraggableCardView: UIView {

    var delegate: DraggableCardViewDelegate?
    var infomation: UILabel = UILabel()
    
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        infomation = UILabel(frame: CGRectMake(0, 50, self.frame.size.width, 100))
        infomation.text = "no info given"
        infomation.textAlignment = NSTextAlignment.Center
        infomation.textColor = UIColor.blackColor()
    }
    
    func setupView() {
        // setup code
    }
}
