//
//  ViewController.swift
//  CardView
//

import UIKit

class ViewController: UIViewController, DraggableCardViewDelegate {
    var cardsLoadedIndex:Int = Int()
    var loadedCards: NSMutableArray = NSMutableArray()
    
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    
    let MAX_BUFFER_SIZE: Int = 2
    let CARD_HEIGHT: CGFloat = 440
    let CARD_WIDTH: CGFloat = 300
    
    var exampleCardLabels: NSArray = NSArray()
    var allCards: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        // ここでCardViewの生成...
        exampleCardLabels = ["hoge1", "hoge2", "hoge3", "hoge4", "hoge5"]
        loadedCards = []
        cardsLoadedIndex = 0
        self.loadCards()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func layoutCardView(cardView: DraggableCardView) {
        cardView.center.x = self.view.center.x
        cardView.center.y = self.view.center.y
    }

    @IBAction func addCardView(sender: AnyObject) {
        self.loadCards()
    }
    //==========================================================================
    

    
    func setupView() {
        self.view.backgroundColor = UIColor(red: 0.92, green: 0.93, blue: 0.95, alpha: 1.0);
        xButton.addTarget(self, action: "swipeLeft", forControlEvents: .TouchUpInside)
        checkButton.addTarget(self, action: "swipeRight", forControlEvents: .TouchUpInside)
        self.view.addSubview(menuButton)
        self.view.addSubview(messageButton)
        self.view.addSubview(xButton)
        self.view.addSubview(checkButton)
    }
    
    func createDraggableViewWithDataAtIndex(index: Int) -> DraggableCardView {
        let draggableView: DraggableCardView = DraggableCardView(frame:CGRectMake(30, 100, CARD_WIDTH, CARD_HEIGHT))
        layoutCardView(draggableView)
        draggableView.information.text = exampleCardLabels.objectAtIndex(index) as? String
        //draggableView.backgroundColor = UIColor.whiteColor()
        draggableView.delegate = self
        return draggableView
    }
    
    func loadCards() {
        if (exampleCardLabels.count > 0) {
            let numLoadedCardsCap = ((exampleCardLabels.count > MAX_BUFFER_SIZE) ? MAX_BUFFER_SIZE : exampleCardLabels.count )
            
            for i in 0..<exampleCardLabels.count {
                let newCard: DraggableCardView = self.createDraggableViewWithDataAtIndex(i)
                allCards.addObject(newCard)
                if (i < numLoadedCardsCap) {
                    loadedCards.addObject(newCard)
                }
            }
            
            for i in 0..<loadedCards.count {
                if (i > 0) {
                    self.view.insertSubview(loadedCards.objectAtIndex(i) as! UIView, belowSubview: loadedCards.objectAtIndex(i-1) as! UIView)
                } else {
                    self.view.addSubview(loadedCards.objectAtIndex(i) as! UIView)
                }
                cardsLoadedIndex++
            }
        }
    }
    
    func cardSwipedLeft(card: UIView) {
        loadedCards.removeObjectAtIndex(0)
        if ( cardsLoadedIndex < allCards.count ) {
            loadedCards.addObject(allCards.objectAtIndex(cardsLoadedIndex))
            cardsLoadedIndex++
            self.view.insertSubview(loadedCards.objectAtIndex(MAX_BUFFER_SIZE-1) as! UIView, belowSubview: loadedCards.objectAtIndex(MAX_BUFFER_SIZE-2) as! UIView)
        }
    }
    
    func cardSwipedRight(card: UIView) {
        loadedCards.removeObjectAtIndex(0)
        if ( cardsLoadedIndex < allCards.count ) {
            loadedCards.addObject(allCards.objectAtIndex(cardsLoadedIndex))
            cardsLoadedIndex++
            self.view.insertSubview(loadedCards.objectAtIndex(MAX_BUFFER_SIZE-1) as! UIView, belowSubview: loadedCards.objectAtIndex(MAX_BUFFER_SIZE-2) as! UIView)
        }
    }
    
    func swipeRight() {
        let dragView: DraggableCardView = loadedCards.firstObject as! DraggableCardView
        dragView.overlayView!.mode = GGOverlayMode.Right
        UIView.animateWithDuration(0.2, animations: {
            dragView.overlayView!.alpha = 1
        })
        dragView.rightClickAction()
    }
    
    func swipeLeft() {
        let dragView: DraggableCardView = loadedCards.firstObject as! DraggableCardView
        dragView.overlayView!.mode = GGOverlayMode.Left
        UIView.animateWithDuration(0.2, animations: {
            dragView.overlayView!.alpha = 1
        })
        dragView.leftClickAction()
    }
    
    
}

