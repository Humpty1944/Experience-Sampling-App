//
//  ViewWelcome.swift
//  Sampling app
//
//  Created by Назарова on 12.04.2021.
//

import UIKit

class ViewWelcome: UIViewController, URLSessionDelegate {
    @IBOutlet weak var buttonBegin: CustomButtonBase!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var labelWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.hidesBackButton = false
        HelpFunction.setReturn(val: false)
       // setUserDefualts()
        setLabelText()
        getQuestions()
//        RestApi.questionResource.addObserver(self)
//        RestApi.questionResource.loadIfNeeded()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backToMain(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func buttonPress(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "QuestionViewController") as! QuestionViewController
       
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
           //Trust the certificate even if not valid
           let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)

           completionHandler(.useCredential, urlCredential)
        }
    func getQuestions(){
       
        var code = UserDefaults.standard.string(forKey:"code")!
        let encoded = code.stringByAddingPercentEncodingForRFC3986()
        print("firs ", encoded)
        //code = code.addingPercentEncoding(withAllowedCharacters: .)!
        print("secind" ,code)
        var location = "https://psycho.sudox.ru/api/Participant/GetQuestions?token="+encoded!
        print("dfsdfdf", location)
        var url : NSString = (location) as NSString
       // let str = String(describing: url.cString(using: String.Encoding.utf8))
        var urlStr : NSString = url.addingPercentEscapes(using: String.Encoding.utf8.rawValue)! as NSString
        var searchURL : NSURL = NSURL(string: urlStr as String)!
        //let headers: HTTPHeaders = [.authorization(bearerToken: code)]
        var request = URLRequest(url: searchURL as URL)//URLRequest(url: requestURL!)
       // let tokenString = "Bearer " + code
       // request.setValue(tokenString, forHTTPHeaderField: "Authorization")
           
        request.httpMethod = "GET"
              //request.httpBody = qMes.data(using: .utf8)
        let requestTask = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil).dataTask(with: request) {
                  (data: Data?, response: URLResponse?, error: Error?) in

                  if(error != nil) {
                      print("Error: \(error)")
                  }else
                  {
                    do{print(data)
                        //let decoder = JSONDecoder()
                       // decoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
                        let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        let jsonArray = json as? [[String:Any]] ?? []
                        HelpFunction.setQuestionArr(arr:jsonArray)
                        print(jsonArray)
                        var arr: [AnyObject] = [AnyObject]()
                        for json in jsonArray{
                            guard let questionType = json["questionType"] as? String else { continue }
                            print("a ",json)
                            if questionType == "Slider"{
                               
                                var slider = SliderQuestion(id: json["id"] as! Int, sliderMinValue: json["sliderMinValue"] as! Int, sliderMaxValue: json["sliderMaxValue"] as! Int, isDiscrete: json["isDiscrete"] as! Int, leftText: json["leftText"] as? String ?? "", rightString:  json["rightText"] as? String ?? "", questionType: json["questionType"]as! String, questionText: json["questionText"]as! String, questionSubtext: json["questionSubtext"] as? String ?? "", instructionText:  json["instructionText"] as? String ?? "", questionNumber: json["questionNumber"]  as! Int)
                               
                                arr.append(slider)
                            }else if questionType == "DiscreteSlider"{
                                var discreteSlider = DsicreteSliderQuestion(id: json["id"] as! Int, discreteSliderMinValue: json["discreteSliderMinValue"] as! Int, discreteSliderMaxValue: json["discreteSliderMaxValue"] as! Int, scaleText: json["scaleText"] as? [String] ?? [], questionType: json["questionType"] as! String, questionText: json["questionText"] as! String, questionSubtext: json["questionSubtext"] as! String, instructionText: json["instructionText"] as! String, questionNumber: json["questionNumber"] as! Int)
                                arr.append(discreteSlider)
                            }else if questionType == "AffectGrid"{
                                var affectGrid = AffectGridQuestion(id: json["id"] as! Int, minX: json["minX"] as! Int, maxX: json["maxX"] as! Int, minY: json["minY"] as! Int, maxY: json["maxY"] as! Int, delimiterCount: json["delimiterCount"] as! Int, isGridVisible: json["isGridVisible"] as! Bool, upperXText: json["upperXText"] as? String ?? "", lowerXText: json["lowerXText"] as? String ?? "", upperYText: json["upperYText"] as? String ?? "", lowerYText: json["lowerYText"] as? String ?? "", leftUpperSquareText: json["leftUpperSquareText"]as? String ?? "", rightUpperSquareText: json["rightUpperSquareText"]as? String ?? "", leftLowerSquareText: json["leftLowerSquareText"] as? String ?? "", rightLowerSquareText: json["rightLowerSquareText"] as? String ?? "", questionType: json["questionType"] as! String, questionText: json["questionText"] as! String, questionSubtext: json["questionSubtext"] as! String, instructionText: json["instructionText"] as! String, questionNumber: json["questionNumber"] as! Int)
                                arr.append(affectGrid)
                            } else if questionType == "Choose"{
                                var choose = ChoiceQuestion(id: json["id"] as! Int, isSingleChoice: json["isSingleChoice"] as! Bool, answers: json["answers"] as! [String], questionType: json["questionType"] as! String, questionText: json["questionText"] as! String, questionSubtext: json["questionSubtext"] as! String, instructionText: json["instructionText"] as! String, questionNumber: json["questionNumber"] as! Int)
                               arr.append(choose)
                            }
                            HelpFunction.setQuestionsLook(arr: arr)
                            //print(HelpFunction.questionsLook)
                            
                        }
                         
                    
                        
                    }catch let jsonErr{
                        print(jsonErr)
                    }
                      //completionBlock(outputStr!);
                  }
              
              
          }
        requestTask.resume()
    }
    
    
    func setLabelText(){
        if HelpFunction.isTest == true{
            labelWelcome.text = "Это тестовая проба"
            returnButton.isHidden=false
            returnButton.isEnabled=true
        }
        else{
            returnButton.isHidden=true
            returnButton.isEnabled=false
            UserDefaults.standard.setValue(Date(), forKey: "CurrTimeForNotif")
            //UserDefaults.standard.setValue(true, forKey: "IsFirst")
        }
    }
//    func setUserDefualts(){
//        let count: [Int] = [3,3,8,1,3, 3]
//        var j=0
//        for i in 0..<5{
//            for num in 0..<count[i]{
//                if i==0 || i==3{
//                                       UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_")
//                                   }
//                                   else{
//                                       UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_"+String(num))
//
//                                   }
//            }
//            j+=1
//        }
//
//    }
//            for c in count{
//                for num in 0..<c{
//                    print(i, c)
//                    if i==0 || i==3{
//                        UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_")
//                    }
//                    else{
//                        UserDefaults.standard.setValue("-9999", forKey: String(i+1)+"_"+String(num))
//
//                    }
//                    }
//                }

       // print( UserDefaults.standard.dictionaryRepresentation())
        
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
}
