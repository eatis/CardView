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
    var overlayView: OverlayView?
    var panGestureRecognizer: UIPanGestureRecognizer?
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("CardView", owner: self, options: nil)

        self.setupView()
        information = UILabel(frame: CGRectMake(0, 50, self.frame.size.width, 100))
        information.text = "no info given"
        information.textAlignment = NSTextAlignment.Center
        information.textColor = UIColor.blackColor()
        
        self.backgroundColor = UIColor.blackColor()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("beginDragged"))
        self.addGestureRecognizer(panGestureRecognizer!)
        self.addSubview(information)
        
        overlayView = OverlayView(frame: CGRectMake(self.frame.size.width/2-100, 0, 100, 100))
        overlayView!.alpha = 0
        self.addSubview(overlayView!)
    }
    
    func setupView() {
        // setup code
        self.layer.cornerRadius = 4
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSizeMake(1, 1)
    }
    
    func beginDragged(gestureRecognizer: UIPanGestureRecognizer) {
        
    }
    
    func updateOverlay(distance: CGFloat) {
        
    }
    
    func afterSwipeAction(xFromCenter: CGFloat) {
        
    }
    
    func rightAction() {
        
    }
    
    func leftAction() {
        
    }
    
    func rightClickAction() {
        
    }
    
    func leftClickAction() {
        
    }
}
