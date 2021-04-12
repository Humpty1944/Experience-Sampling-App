//
//  ViewController.swift
//  Sampling app
//
//  Created by Назарова on 16.02.2021.
//

import UIKit

class ViewController: UIViewController{
   
    enum CardState {
        case expanded
        case collapsed
    }
    
    @IBOutlet weak var failToEnterButton: UIButton!
    
    @IBOutlet weak var textFieldCode: UITextField!
    
    
    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    var cardViewController:CardViewController!
    var visualEffectView:UIVisualEffectView!
    
    let cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 0
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        var location:CGPoint = CGPoint(x:-1000, y:-1000)
        print( NSCoder.string(for: location))
        setupCard()
    }
    
    @IBAction func failToEnter(_ sender: Any) {
        self.view.addSubview(visualEffectView)

        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        animateTransitionIfNeeded(state: nextState, duration: 0.9)
    }
    func setupCard() {
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        
        cardViewController = CardViewController(nibName:"CardViewController", bundle:nil)
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
    }

    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
        if nextState==CardState.collapsed{
            cardViewController.removeFromParent()
            cardViewController.view.removeFromSuperview()
            visualEffectView.removeFromSuperview()
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
            if nextState==CardState.collapsed{
                cardViewController.removeFromParent()
                cardViewController.view.removeFromSuperview()
                visualEffectView.removeFromSuperview()
            }
        default:
            break
        }
       
        
    }
    
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.visualEffectView.effect = UIBlurEffect(style: .dark)
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }
            
            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
    
    
    
    
    @IBAction func signIn(_ sender: Any) {
        let text = textFieldCode.text
        
        if text==""{
            // create the alert
                               let alert = UIAlertController(title: "Неправильный код", message: "Вы  не вели код участника.", preferredStyle: UIAlertController.Style.alert)

                               // add an action (button)
                               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                               // show the alert
                               self.present(alert, animated: true, completion: nil)
                       return

        }
        if text!.count != 6{
                  // create the alert
                          let alert = UIAlertController(title: "Неправильный код", message: "В коде недостаточно знаков.", preferredStyle: UIAlertController.Style.alert)

                          // add an action (button)
                          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                          // show the alert
                          self.present(alert, animated: true, completion: nil)
                  return
              }
sendToServer(code: text!)
        
    }
    
    func sendToServer(code: String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
        //navigationController?.setViewControllers([viewController], animated:true)
        self.navigationController?.pushViewController(viewController, animated: false)
        //performSegue(withIdentifier: "ShowMain", sender: nil)
       }
}


