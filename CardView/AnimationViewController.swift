//
//  AnimationViewController.swift
//  CardView
//

import UIKit

class AnimationViewController: UIViewController {

    // Controller全体で操作する用
    var testView:UIView!
    var alphaValue:CGFloat = 0.0
    
    @IBOutlet weak var squeare: UIButton!
    
    
    var replicatorLayer:CAReplicatorLayer!
    var circle:CALayer!
    
    // Buttonを押した時用のアクション
    @IBAction func showAnimationView(sender: AnyObject) {
        
        // CAKeyframeAnimationを使えばkeyframe間を補完してアニメーションしてくれます（3つ以上の値を補完するアニメーション）
        let transformAnim = CAKeyframeAnimation(keyPath:"transform")
        // 配列で...
        transformAnim.values = [NSValue(CATransform3D: CATransform3DMakeRotation(3 * CGFloat(M_PI/180), 0, 0, -1)),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(3 * CGFloat(M_PI/180), 0, 0, 1))),
            NSValue(CATransform3D: CATransform3DMakeScale(1.5, 1.5, 1)),
            NSValue(CATransform3D: CATransform3DConcat(CATransform3DMakeScale(1.5, 1.5, 1), CATransform3DMakeRotation(-8 * CGFloat(M_PI/180), 0, 0, 1)))]
        // 通過タイミング
        transformAnim.keyTimes       = [0, 0.349, 0.618, 1]
        // アニメーション時間
        transformAnim.duration       = 1
        
        // アニメーションの追加
        self.testView.layer.addAnimation(transformAnim, forKey: "transform")
        
        UIView.animateWithDuration(1, animations: {
            self.testView.alpha = self.alphaValue
            }, completion: { finished in
                //self.testView.removeFromSuperview()
                self.alphaValue = self.alphaValue == 0.0 ? 1.0 : 0.0
        })
        print(self.alphaValue)
        
        
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.toValue = self.view.center.y + 20
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.circle.addAnimation(animation, forKey: "animetion")
        
        self.replicatorLayer.instanceDelay = 0.1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let testView = UIView(frame: CGRectMake(200, 200, 100, 100))
        testView.backgroundColor = UIColor.redColor()

        testView.layer.shadowColor = UIColor.blackColor().CGColor
        testView.layer.shadowOpacity = 0.75
        testView.layer.shadowOffset = CGSizeMake(5, 10)
        //testView.layer.shadowRadius = 10
        // IMPORTANT FOR PERFORMANCE let myShadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: 10) myLayer.shadowPath = myShadowPath.CGPath
        
        self.view.addSubview(testView)
        self.testView = testView
        
        
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.view.bounds
        self.view.layer.addSublayer(replicatorLayer)
        self.replicatorLayer = replicatorLayer
        
        let circle = CALayer()
        circle.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        circle.position = self.view.center
        circle.position.x -= 30
        circle.backgroundColor = UIColor.blackColor().CGColor
        circle.cornerRadius = 5
        replicatorLayer.addSublayer(circle)
        self.circle = circle
        
        replicatorLayer.instanceCount = 4
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(20, 0.0, 0.0)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // アニメーションする画像のCALayerを作成する
        let imageLayer = CALayer()
        imageLayer.contents = UIImage(named: "checkButton")!.CGImage  // CGImageにするのを忘れないで
        imageLayer.frame = CGRect(x: -100.0, y: 0.0, width: 100.0, height: 100.0)
        view.layer.insertSublayer(imageLayer, above: view.layer)  // 画面のViewの上に画像を表示
        
        // アニメーションを作成する
        let anim = CAKeyframeAnimation(keyPath: "position")
        anim.duration = 5.0
        anim.values = [CGPoint(x: -100.0, y: 0.0),
                       CGPoint(x: view.frame.width + 100.0, y: 160.0),
                       CGPoint(x: -100.0, y: view.frame.size.height)].map{NSValue(CGPoint: $0)}
        anim.keyTimes = [0.0, 0.5, 1.0]
        
        // 画像のLayerにアニメーションをセットする
        imageLayer.addAnimation(anim, forKey: nil)
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