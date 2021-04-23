//
//  ViewController.swift
//  Sampling app
//
//  Created by Назарова on 16.02.2021.
//

import UIKit
import Siesta

class ViewController: UIViewController, ResourceObserver, URLSessionDelegate{
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        let data: Participant? = resource.typedContent()
        print(data)
        //userInfo = resource.jsonDict[]
    }
    
    var userInfo =  [[String: Any]] ()
    enum CardState {
        case expanded
        case collapsed
    }
    
    var loginUserDataResource: Resource? {
      didSet {
        // 1
        oldValue?.removeObservers(ownedBy: self)

        // 2
        loginUserDataResource?
          .addObserver(self)
          // 3
          .loadIfNeeded()
      }
    }
    
    
    @IBOutlet weak var failToEnterButton: UIButton!
    
    @IBOutlet weak var textFieldCode: UITextField!
    
    
    @IBOutlet weak var buttonSignIn: UIButton!
    
    
    var cardViewController:CardViewController!
    var visualEffectView:UIVisualEffectView!
    
    let cardHeight:CGFloat = 600
//    let cardHandleAreaHeight:CGFloat = 0
    
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    weak var requestTask: URLSessionDataTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        print(UserDefaults.standard.string(forKey: "code"))
//        if UserDefaults.standard.string(forKey: "code") != nil{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
//            self.navigationController?.pushViewController(viewController, animated: false)
//        }
//       else{
        checkIfEnded()
        setupCard()
        deleteDefaults()
        //}
       
        //loginUserDataResource = RestApi.sharedInstance.participantAuthLogin()
        
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
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height /*- cardHandleAreaHeight*/, width: self.view.bounds.width, height: cardHeight)
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handleCardPan(recognizer:)))
        
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    func deleteDefaults(){
        UserDefaults.standard.setValue(true, forKey: "IsFirst")
        UserDefaults.standard.setValue("", forKey: "entries")
        UserDefaults.standard.setValue(10, forKey: "countQuestion")
      //  defaults.setValue(valDay, forKey: "dayCurr")
        UserDefaults.standard.setValue(Date(), forKey: "beginDay")
       
        var dateComponent = DateComponents()
        dateComponent.day = 20
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())
       // print(currentDate)
        UserDefaults.standard.setValue(futureDate , forKey: "endDay")
       // UserDefaults.standard.setValue(1, forKey: <#T##String#>)(forKey: "All")
       // UserDefaults.standard.setValue(false, forKey: "notif")
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
                    self.cardViewController.view.frame.origin.y = self.view.frame.height /*- self.cardHandleAreaHeight*/
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
                               let alert = UIAlertController(title: "Неправильный код", message: "Вы не вели код участника.", preferredStyle: UIAlertController.Style.alert)

                               // add an action (button)
                               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                               // show the alert
                               self.present(alert, animated: true, completion: nil)
                       return

        }
       
sendToServer(code: text!)
        
    }
    
    func sendToServer(code: String){
        let location = "https://psycho.sudox.ru/api/ParticipantAuth/Login?id="+code
        let requestURL = URL(string: location)
        var isOk = true
        
              var request = URLRequest(url: requestURL!)

              request.httpMethod = "POST"
              //request.httpBody = qMes.data(using: .utf8)

               var requestTask =  URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil).dataTask(with: request) {
                  (data: Data?, response: URLResponse?, error: Error?) in

                  if(error != nil) {
                    isOk=false
                      print("Error: \(error)")
                  }else
                  {
                    do{
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
                        //print(data as! String)
                        let todoItemModel = try decoder.decode(Participant.self, from: data!)
                        self.saveAllInUserDefault(participant: todoItemModel)
                        print("Response data:\n \(todoItemModel)")
                        isOk=true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            print("aaaa")
                           // self.requestTask!.cancel()
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
                            self.navigationController?.pushViewController(viewController, animated: false)
                        }
                        //print("todoItemModel Title: \(todoItemModel.title)")
                       // print("todoItemModel id: \(todoItemModel.id ?? 0)")
                    }catch let jsonErr{
                        isOk=false
                        print(jsonErr)
                    }
                    let outputStr  = String(data: data!, encoding: String.Encoding.utf8) as String?
                    print(outputStr)
                    
//                    dispatch_async(dispatch_get_main_queue()) {
//                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//                        let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
//                        self.navigationController?.pushViewController(viewController, animated: false)
                           // }
                      //compoutputStrletionBlock(outputStr!);
                  }
              }
              requestTask.resume()
        
        
//        if isOk == true{
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let viewController = storyboard.instantiateViewController(identifier: "MainScreenViewController") as! MainScreenViewController
//            self.navigationController?.pushViewController(viewController, animated: false)
//        }
        
 
       }
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
           //Trust the certificate even if not valid
           let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)

           completionHandler(.useCredential, urlCredential)
        }
    
    public func saveAllInUserDefault(participant: Participant){
        let userDefault = UserDefaults.standard
        userDefault.setValue(participant.nickname, forKey: "nickname")
        userDefault.setValue(participant.email, forKey: "email")
        userDefault.setValue(participant.notificationCountPerDay, forKey: "notificationCountPerDay")
        userDefault.setValue(participant.notificationMinValueVariation, forKey: "notificationMinValueVariation")
        userDefault.setValue(participant.phoneNumber, forKey: "phoneNumber")
        userDefault.setValue(participant.timeNotificationEnd.hours, forKey: "timeNotificationEnd.hours")
        userDefault.setValue(participant.timeNotificationEnd.minutes, forKey: "timeNotificationEnd.minutes")
        userDefault.setValue(participant.timeNotificationStart.minutes, forKey: "timeNotificationStart.minutes")
        userDefault.setValue(participant.timeNotificationStart.hours, forKey: "timeNotificationStart.hours")
        userDefault.setValue(participant.token, forKey: "code")
        userDefault.setValue(participant.projectID, forKey: "projectID")
        userDefault.setValue(participant.dateStart, forKey: "dateStart")
        userDefault.setValue(participant.dateEnd, forKey: "dateEnd")
        userDefault.setValue(participant.id, forKey: "idPart")
    }
    
    func checkIfEnded(){
//        let ended_date = UserDefaults.standard.object(forKey: "endDate") as! Date
//        if ended_date < Date(){
//            
//        }
    }
}

class RequestDelegate: NSObject, URLSessionDelegate {

        public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void) {
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
    }
