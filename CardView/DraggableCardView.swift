//
//  DraggableCardView.swift
//  CardView
//

import UIKit

let ACTION_MARGIN  = 120 //画面中央からどれだけ離れたらカードが自動的に画面から消えるかを決める。
let SCALE_STRENGTH  = 4 //カードがシュリンクするスピードを決める。
let SCALE_MAX = 0.93 //カードがどれだけ縮小するかを決める。
let ROTATION_MAX = 1 //カードの回転する大きさを決める。
let ROTATION_STRENGTH = 320
let ROTATION_ANGLE  = M_PI/8

protocol DraggableCardViewDelegate {
    func cardSwipedLeft(card: UIView)
    func cardSwipedRight(card: UIView)
}

class DraggableCardView: UIView {

    var delegate: DraggableCardViewDelegate?
    var information: UILabel = UILabel()
    var overlayView: OverlayView?
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPoint: CGPoint = CGPoint()
    
    var xFromCenter: CGFloat = CGFloat()
    var yFromCenter: CGFloat = CGFloat()
    
    
    @IBOutlet var draggableCardView: DraggableCardView!
    
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

        draggableCardView.frame = self.bounds
        
        information = UILabel(frame: CGRectMake(0, 50, self.frame.size.width, 100))
        information.text = "no info given"
        information.textAlignment = NSTextAlignment.Center
        information.textColor = UIColor.blackColor()
        
        //self.backgroundColor = UIColor.blackColor()
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("beingDragged:"))
        draggableCardView.addGestureRecognizer(panGestureRecognizer!)
        draggableCardView.addSubview(information)
      
        overlayView = OverlayView(frame: CGRectMake(self.frame.size.width/2-100, 0, 100, 100))
        overlayView!.alpha = 0
        draggableCardView.addSubview(overlayView!)
        
        self.setupView()
        addSubview(draggableCardView)
    }
    
    func setupView() {
        // setup code
        draggableCardView.layer.cornerRadius = 4
        draggableCardView.layer.shadowRadius = 3
        draggableCardView.layer.shadowOpacity = 0.2
        draggableCardView.layer.shadowOffset = CGSizeMake(1, 1)
    }
    
    func beingDragged(gestureRecognizer: UIPanGestureRecognizer) {
        let xFromCenter = gestureRecognizer.translationInView(self).x
        let yFromCenter = gestureRecognizer.translationInView(self).y
    
        switch (gestureRecognizer.state) {
        case UIGestureRecognizerState.Began:
            self.originalPoint = self.center
            break
        case UIGestureRecognizerState.Changed:
            let rotationStrength: CGFloat = min(xFromCenter / CGFloat(ROTATION_STRENGTH), CGFloat(ROTATION_MAX))
            let rotationAngle: CGFloat = CGFloat(ROTATION_ANGLE) * rotationStrength
            let scale: CGFloat = max(1 - CGFloat(fabsf(Float(rotationStrength))) / CGFloat(SCALE_STRENGTH), CGFloat(SCALE_MAX))
            self.center = CGPointMake(self.originalPoint.x + xFromCenter, self.originalPoint.y + yFromCenter)
            let transform: CGAffineTransform = CGAffineTransformMakeRotation(rotationAngle)
            let scaleTransform: CGAffineTransform = CGAffineTransformScale(transform, scale, scale)
            self.transform = scaleTransform
            self.updateOverlay(xFromCenter)
            break
        case UIGestureRecognizerState.Ended:
            self.afterSwipeAction(xFromCenter)
            break
        case UIGestureRecognizerState.Possible:
            break
        case UIGestureRecognizerState.Cancelled:
            break
        case UIGestureRecognizerState.Failed:
            break
        }
    }
    
    func updateOverlay(distance: CGFloat) {
        if distance > 0 {
            overlayView!.setMode(GGOverlayMode.Right)
        } else {
            overlayView!.setMode(GGOverlayMode.Left)
        }
        
        overlayView!.alpha = min(CGFloat(fabsf(Float(distance)) / 100), 0.4)
    }
    
    func afterSwipeAction(xFromCenter: CGFloat) {
        if xFromCenter > CGFloat(ACTION_MARGIN) {
            self.rightAction()
        } else if xFromCenter < CGFloat(-ACTION_MARGIN) {
            self.leftAction()
        } else {
            // TODO:後程修正
            UIView.animateWithDuration(0.3, animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransformMakeRotation(0)
                self.overlayView!.alpha = 0
            })
        }
    }
    
    func rightAction() {
        // TODO:後程修正
        let finishPoint: CGPoint = CGPointMake(500, 2 * yFromCenter + self.originalPoint.y)
        UIView.animateWithDuration(0.3, animations: {
            self.center = finishPoint
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedRight(self)
        NSLog("Yes")
        
        

        // TOFO:後で見る
//        xDistanceFromCenter = gestureRecognizer.translationInView(self).x
//        yDistanceFromCenter = gestureRecognizer.translationInView(self).y
//
//        
//        
//        let rotationStrength = min(xFromCenter! / self.frame.size.width, rotationMax)
//        let rotationAngle = animationDirection! * defaultRotationAngle * rotationStrength
//        let scaleStrength = 1 - ((1 - scaleMin) * fabs(rotationStrength))
//        let scale = max(scaleStrength, scaleMin)
//        
//        layer.rasterizationScale = scale * UIScreen.mainScreen().scale
//        
//        let transform = CGAffineTransformMakeRotation(rotationAngle)
//        let scaleTransform = CGAffineTransformScale(transform, scale, scale)
//        
//        self.transform = scaleTransform
//        center = CGPoint(x: originalLocation!.x + xDistanceFromCenter!, y: originalLocation!.y + yFromCenter!)
//        
//        updateOverlayWithFinishPercent(xFromCenter! / frame.size.width)
//        //100% - for proportion
//        delegate?.cardDraggedWithFinishPercent(self, percent: min(fabs(xFromCenter * 100 / frame.size.width), 100))
    }
    
    func leftAction() {
        // TODO:後程修正
        let finishPoint: CGPoint = CGPointMake(-500, 2 * yFromCenter + self.originalPoint.y)
        UIView.animateWithDuration(0.3, animations: {
            self.center = finishPoint
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedLeft(self)
        NSLog("No")
    }
    
    func rightClickAction() {
        // TODO:後程修正
        let finishPoint: CGPoint = CGPointMake(600, self.center.y)
        UIView.animateWithDuration(0.3, animations: {
            self.center = finishPoint
            self.transform = CGAffineTransformMakeRotation(1)
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedRight(self)
        NSLog("YES")
    }
    
    func leftClickAction() {
        // TODO:後程修正
        let finishPoint: CGPoint = CGPointMake(-600, self.center.y)
        UIView.animateWithDuration(0.3, animations: {
            self.center = finishPoint
            self.transform = CGAffineTransformMakeRotation(1)
            }, completion: { (value: Bool) in
                self.removeFromSuperview()
        })
        delegate?.cardSwipedLeft(self)
        NSLog("No")
    }
}
