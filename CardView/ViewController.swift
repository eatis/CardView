//
//  ViewController.swift
//  CardView
//

import UIKit

class ViewController: UIViewController, DraggableCardViewDelegate {
    let CARD_HEIGHT: CGFloat = 260
    let CARD_WIDTH: CGFloat = 260
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let draggableCardView: DraggableCardView = DraggableCardView(frame: CGRectMake(30, 100, CARD_WIDTH, CARD_HEIGHT))
        draggableCardView.information.text = "Example Card"
        draggableCardView.backgroundColor = UIColor.brownColor()
        draggableCardView.delegate = self
        self.view.addSubview(draggableCardView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func cardSwipedRight(card: UIView) {
        <#code#>
    }
    
    func cardSwipedLeft(card: UIView) {
        <#code#>
    }

}

