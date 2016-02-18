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
    var information: UILabel = UILabel()
    
    var panGestureRecognizer: UIPanGestureRecognizer?
    
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
        information = UILabel(frame: CGRectMake(0, 50, self.frame.size.width, 100))
        information.text = "no info given"
        information.textAlignment = NSTextAlignment.Center
        information.textColor = UIColor.blackColor()
        
        self.backgroundColor = UIColor.blackColor()
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("beginDragged"))
        
        self.addGestureRecognizer(panGestureRecognizer!)
        self.addSubview(information)
    }
    
    func setupView() {
        // setup code
    }
}
