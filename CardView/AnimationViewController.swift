//
//  AnimationViewController.swift
//  CardView
//

import UIKit

class AnimationViewController: UIViewController, UIGestureRecognizerDelegate {

    // Controller全体で操作する用
    var testView:UIView!
    var alphaValue:CGFloat = 0.0
    
    @IBOutlet weak var squeare: UIButton!
    
    
    var replicatorLayer:CAReplicatorLayer!
    var circle:CALayer!
    
    var verticalLine:CAShapeLayer!
    
    // Buttonを押した時用のアクション
    @IBAction func showAnimationView(sender: AnyObject) {
        
        // CAKeyframeAnimationを使えばkeyframe間を補完してアニメーションしてくれます（3つ以上の値を補完するアニメーション）
//        let transformAnim = CAKeyframeAnimation(keyPath:"transform")
//        // 配列で...
//        transformAnim.values = [NSValue(CATransform3D: CATransform3DMakeRotation(3 * CGFloat(M_PI/180), 0, 0, -1)),
//            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(3 * CGFloat(M_PI/180), 0, 0, 1))),
//            NSValue(CATransform3D: CATransform3DMakeScale(1.5, 1.5, 1)),
//            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(-8 * CGFloat(M_PI/180), 0, 0, 1)))]
//        // 通過タイミング
//        transformAnim.keyTimes       = [0, 0.349, 0.618, 1]
//        // アニメーション時間
//        transformAnim.duration       = 1
//        
//        // アニメーションの追加
//        self.testView.layer.addAnimation(transformAnim, forKey: "transform")
//        
//        UIView.animateWithDuration(1, animations: {
//            self.testView.alpha = self.alphaValue
//            }, completion: { finished in
//                //self.testView.removeFromSuperview()
//                self.alphaValue = self.alphaValue == 0.0 ? 1.0 : 0.0
//        })
//        print(self.alphaValue)
        
        
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = self.view.center.y - 230
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.circle.addAnimation(animation, forKey: "animetion")
        
        self.replicatorLayer.instanceDelay = 0.1
        
        
        
        addCircleIndicatorAnimation(circleView.layer.sublayers![1] as! CAShapeLayer)
        
        //アニメーションを削除するときとかにKeyを使います
        circleView.layer.removeAnimationForKey("addCircleIndicatorAnimation")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let testView = UIView(frame: CGRectMake(200, 200, 100, 100))
//        testView.backgroundColor = UIColor.redColor()
//
//        testView.layer.shadowColor = UIColor.blackColor().CGColor
//        testView.layer.shadowOpacity = 0.75
//        testView.layer.shadowOffset = CGSizeMake(5, 10)
//        //testView.layer.shadowRadius = 10
//        // IMPORTANT FOR PERFORMANCE let myShadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10) myLayer.shadowPath = myShadowPath.CGPath
//        
//        self.view.addSubview(testView)
//        self.testView = testView
//        
//        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.view.bounds
        self.view.layer.addSublayer(replicatorLayer)
        self.replicatorLayer = replicatorLayer
        
        let circle = CALayer()
        circle.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        circle.position = self.view.center
        circle.position.x -= 30
        circle.position.y -= 250
        circle.backgroundColor = UIColor.blackColor().CGColor
        circle.cornerRadius = 5
        replicatorLayer.addSublayer(circle)
        self.circle = circle
        
        replicatorLayer.instanceCount = 4
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 0.0, 0.0)
//
//        
//        drawCircleIndicator(self.view)
        
        
        
        
        // カウントダウン数値ラベル設定
        countLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height - 100))
        countLabel.font = UIFont(name: "HelveticaNeue", size: 54)
        // 中心揃え
        countLabel.textAlignment = NSTextAlignment.Center
        countLabel.baselineAdjustment = UIBaselineAdjustment.AlignCenters
        self.view.addSubview(countLabel)
        
        circleView = UIView(frame : CGRectMake((self.view.frame.width/2)-100, (self.view.frame.height/2)-150, 200, 200))
        circleView.layer.addSublayer(drawCircleIndicator(circleView.frame.width, strokeColor: UIColor(red:0.0,green:0.0,blue:0.0,alpha:0.2)))
        circleView.layer.addSublayer(drawCircleIndicator(circleView.frame.width, strokeColor: UIColor(red:0.0,green:0.0,blue:0.0,alpha:1.0)))
        self.view.addSubview(circleView)
        
        
        
        addPanGesture()
        
        verticalLine = CAShapeLayer(layer: self.view.layer)
        verticalLine.lineWidth = 3.0
        verticalLine.path = getLinePathWithAmount(100.0, amountY: 0.0)
        verticalLine.strokeColor = UIColor.blackColor().CGColor
        verticalLine.fillColor = UIColor.clearColor().CGColor
        
        self.view.layer.addSublayer(verticalLine!)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        // アニメーションする画像のCALayerを作成する
//        let imageLayer = CALayer()
//        imageLayer.contents = UIImage(named: "checkButton")!.CGImage  // CGImageにするのを忘れないで
//        imageLayer.frame = CGRect(x: -100.0, y: 0.0, width: 100.0, height: 100.0)
//        view.layer.insertSublayer(imageLayer, above: view.layer)  // 画面のViewの上に画像を表示
//        
//        // アニメーションを作成する
//        let anim = CAKeyframeAnimation(keyPath: "position")
//        anim.duration = 5.0
//        anim.values = [CGPoint(x: -100.0, y: 0.0),
//                       CGPoint(x: view.frame.width + 100.0, y: 160.0),
//                       CGPoint(x: -100.0, y: view.frame.size.height)].map{NSValue(CGPoint: $0)}
//        anim.keyTimes = [0.0, 0.5, 1.0]
//        
//        // 画像のLayerにアニメーションをセットする
//        imageLayer.addAnimation(anim, forKey: nil)
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
    
    
    
    var countLabel:UILabel!
    let countMaxNum:Int = 3
    var countNum:Int = 3
    var circleView:UIView!
    
    // 遷移毎に実行
    override func viewWillAppear(animated: Bool) {
        // 数値をリセット
        countNum = countMaxNum
        countLabel.text = String(countNum)
        // アニメーション開始
    }
    
    /**
     サークルインジケータの作成
     - parameter viewWidth: ビューの幅
     - parameter strokeColor: インジケータの色
     
     - returns: CAShapeLayer()
     */
    func drawCircleIndicator(viewWidth:CGFloat, strokeColor:UIColor) -> CAShapeLayer {
        
        let countCircleShapeLayer:CAShapeLayer = CAShapeLayer()

        let indicatorLineWidth: CGFloat = 10
        let drawViewScale: CGFloat = viewWidth
        // 中の円のサイズ
        let radius: CGFloat = drawViewScale - indicatorLineWidth
        // 円の描画path設定
        countCircleShapeLayer.path = UIBezierPath(roundedRect: CGRectMake(0, 0, radius, radius), cornerRadius: radius / 2).CGPath
        // 円のポジション設定
        countCircleShapeLayer.position = CGPointMake(indicatorLineWidth / 2, indicatorLineWidth / 2)
        // 中の円の塗りの色を設定
        countCircleShapeLayer.fillColor = UIColor.clearColor().CGColor
        // 線の色を設定
        countCircleShapeLayer.strokeColor = strokeColor.CGColor
        // 線の幅を設定
        countCircleShapeLayer.lineWidth = indicatorLineWidth
        return countCircleShapeLayer
    }
    
    /**
     サークルインジケータのアニメーションを作成
     - parameter layer: レイヤー
     */
    func addCircleIndicatorAnimation(layer:CAShapeLayer) {
        let drawAnimation = CABasicAnimation(keyPath: "strokeEnd")
        // callbackで使用
        drawAnimation.setValue(layer, forKey:"animationLayer")
        // callbackを使用する場合
        drawAnimation.delegate = self
        drawAnimation.duration = 1.0
        drawAnimation.repeatCount = 1.0
        // 起点と目標点の変化比率を設定 (0.0 〜 1.0)
        drawAnimation.fromValue = 0.0
        drawAnimation.toValue = 1.0
        // イージング設定
        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        layer.addAnimation(drawAnimation, forKey: "addCircleIndicatorAnimation")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
//        let layer:CAShapeLayer = anim.valueForKey("animationLayer") as! CAShapeLayer
//        countNum--
//        // 表示ラベルの更新
//        countLabel.text = String(countNum)
//        
//        if countNum <= 0 {
//            //次の画面へ遷移(navigationControllerの場合)
//            //let nextViewController:ViewController = ViewController()
//            //self.navigationController?.pushViewController(nextViewController, animated: false)
//            
//        } else {
//            addCircleIndicatorAnimation(layer)
//        }
    }
    
    
    
    
    func getLinePathWithAmount(amountX:CGFloat, amountY:CGFloat) -> CGPathRef {
        let w = UIScreen.mainScreen().bounds.width
        let h = UIScreen.mainScreen().bounds.height
        let centerY = 2 * h / 3
        
        let bezierPath = UIBezierPath()
        
        let topLeftPoint = CGPointMake(0, centerY)
        let topMidPoint = CGPointMake(/*amountX*/w/2, centerY + amountY)
        let topRightPoint = CGPointMake(w, centerY)
        
        bezierPath.moveToPoint(topLeftPoint)
        bezierPath.addQuadCurveToPoint(topRightPoint, controlPoint: topMidPoint)
        
        return bezierPath.CGPath
    }
    
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: "dragg:")
        panGesture.delegate = self
        self.view.addGestureRecognizer(panGesture)
    }
    
    func dragg(gestureRec:UIPanGestureRecognizer) {
        let amountX = gestureRec.translationInView(self.view).x
        let amountY = gestureRec.translationInView(self.view).y
        self.verticalLine.path = self.getLinePathWithAmount(amountX, amountY: amountY)
        
        if gestureRec.state == UIGestureRecognizerState.Ended {
            self.animateLineReturnFrom(amountX, positionY: amountY)
        }
    }
    
    func animateLineReturnFrom(positionX: CGFloat,positionY: CGFloat) {
        // KeyframeAnimation
        let bounce = CAKeyframeAnimation(keyPath: "path")
        // kCAMediaTimingFunctionEaseIn（初めは遅く、後から速くなる）
        bounce.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
        // KeyPathの追加
        let values = [
            self.getLinePathWithAmount(positionX, amountY: positionY),
            self.getLinePathWithAmount(-(positionX * 0.7), amountY: -(positionY * 0.7)),
            self.getLinePathWithAmount(positionX * 0.4, amountY: positionY * 0.4),
            self.getLinePathWithAmount(-(positionX * 0.3), amountY: -(positionY * 0.3)),
            self.getLinePathWithAmount(positionX * 0.15, amountY: positionY * 0.15),
            self.getLinePathWithAmount(0.0, amountY: 0.0)
        ]
        
        bounce.values = values
        bounce.duration = 0.9
        // removedOnCompletionプロパティをfalseにし元の位置に！！
        bounce.removedOnCompletion = false
        // アニメーション終了後、アニメーション終了地点にフレームが残る
        bounce.fillMode = kCAFillModeForwards
        bounce.delegate = self
        self.verticalLine.addAnimation(bounce, forKey: "return")
        
        print("gesture end")
    }
}