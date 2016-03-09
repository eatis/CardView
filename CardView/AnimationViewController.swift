//
//  AnimationViewController.swift
//  CardView
//

import UIKit

class AnimationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let testView = UIView(frame: CGRectMake(200, 200, 100, 100))
        testView.backgroundColor = UIColor.greenColor()
        self.view.addSubview(testView)
        
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
        testView.layer.addAnimation(transformAnim, forKey: "transform")
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
