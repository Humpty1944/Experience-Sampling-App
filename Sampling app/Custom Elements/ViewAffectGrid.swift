//
//  CustomViewAffectGrid.swift
//  help
//
//  Created by Назарова on 23.02.2021.
//

import Foundation
import UIKit

protocol AffectGridDelegate: AnyObject {
    func affectGridLocation(_ affectGrid: CustomViewAffectGrid, location: CGPoint)
}
@IBDesignable
final class CustomViewAffectGrid: UIView {
    internal init( currLocation: CGPoint, frame: CGRect, isLine: Bool){
        self.currLocation=currLocation
        self.isLine = isLine
        super.init(frame: frame)
        
    }
    
   // var isDrawCall:Bool?
    var currLocation:CGPoint=CGPoint(x: -1000, y: -1000)
    weak var delegate : AffectGridDelegate?
    @IBInspectable
    var isLine: Bool = true
    
    @IBInspectable
    var segments: [String] = ["Стресс", "Тревога", "Возбуждение", "Негативный", "Позитивный", "Депрессия", "Сонный", "Расслабленность"]
    var mainAffectView:UIView = UIView()
    
    // MARK: - Private properties
    
//    private lazy var paragraphStyle: NSParagraphStyle = {
//        let paragraph = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
//        paragraph.alignment = .center
//        return paragraph.copy() as! NSParagraphStyle
//    }()
//    private var segmentSize: CGFloat {
//        return frame.width / CGFloat(segments.count)
//    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        // configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // configure()
    }
    
    //    private func configure() {
    //        addGestureRecognizer(
    //            UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
    //        )
    //    }
    
    // MARK: - Actions
    
    @objc
    private func didTap(recognizer: UITapGestureRecognizer) {//change
        
        let location = recognizer.location(in: self)
        if let viewWithTag = self.viewWithTag(9999) {
            viewWithTag.removeFromSuperview()
        }
        var tapPlace: UIView
        let rectFrame: CGRect = CGRect(x:location.x-10, y:location.y-10, width:20, height:20)
        tapPlace=UIView(frame: rectFrame)
        tapPlace.tag=9999
        tapPlace.backgroundColor = color.UIColorFromRGB(rgbValue: 0x4198FF)
        tapPlace.layer.cornerRadius=tapPlace.bounds.width/2
        self.addSubview(tapPlace)
        currLocation = location
        self.delegate?.affectGridLocation(self, location: currLocation)
        
    }
    
    public func drawLocation(location: CGPoint, view:UIView){
        // isDrawCall=true
        if let viewWithTag = self.viewWithTag(9999) {
            viewWithTag.removeFromSuperview()
        }
        var tapPlace: UIView
        
        let rectFrame: CGRect = CGRect(x:location.x-30, y:location.y-30, width:20, height:20)
        tapPlace=UIView(frame: rectFrame)
        tapPlace.tag=9999
        tapPlace.backgroundColor = color.UIColorFromRGB(rgbValue: 0x4198FF)
        tapPlace.layer.cornerRadius=tapPlace.bounds.width/2
        view.addSubview(tapPlace)
        currLocation = location
        
    }
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let screenSize: CGRect = self.bounds
        
        let screenWidth = screenSize.width
        
        let screenHeight = screenSize.height
        
        let xPos:CGFloat = 20
        let yPos:CGFloat = 20
        
        let rectWidth = Int(screenWidth) - 40
        
        let rectHeight = Int(screenHeight) - 40
        
        let rectFrame: CGRect = CGRect(x:CGFloat(xPos), y:CGFloat(yPos), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
        mainAffectView = UIView(frame: rectFrame)
        mainAffectView.backgroundColor = UIColor.white
        mainAffectView.layer.cornerRadius=24
        mainAffectView.layer.borderWidth=1
        mainAffectView.layer.borderColor=UIColor.darkGray.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(recognizer:)))
        mainAffectView.addGestureRecognizer(tap)
        if isLine == true{
            drawAllLines(basicView: mainAffectView, width: rectWidth, height: rectHeight,isHorizontal:true )
            drawAllLines(basicView: mainAffectView, width: rectWidth, height: rectHeight,isHorizontal:false )
        }
        addLabels(rectFrame: rectFrame)
        if currLocation.x != -1000 && currLocation.y != -1000{
            
            drawLocation(location: currLocation, view: mainAffectView)
        }
        self.addSubview(mainAffectView)
        
    }
    
    func addLabels(rectFrame:CGRect){
        var lables: [UILabel] = [UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel(),UILabel()]
        lables[0].text=segments[0]
        lables[0].textColor=UIColor.lightGray
        lables[0].font = UIFont.systemFont(ofSize: 12)
        lables[0].frame = CGRect(x: 5, y: 5, width: 125, height: 12)
        self.addSubview(lables[0])
        lables[0].translatesAutoresizingMaskIntoConstraints = false
        lables[0].bottomAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive=true
        lables[0].leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive=true
        ///________________________________________________________
        lables[1].text=segments[1]
        lables[1].textColor=UIColor.darkGray
        lables[1].font = UIFont.systemFont(ofSize: 12)
        lables[1].frame = CGRect(x: (rectFrame.width/2)-lables[1].font.pointSize/2, y: 5, width: 125, height: 12)
        self.addSubview(lables[1])
        lables[1].translatesAutoresizingMaskIntoConstraints = false
        lables[1].centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        ///____________________________________________________________
        lables[2].text=segments[2]
        lables[2].textColor=UIColor.lightGray
        lables[2].font = UIFont.systemFont(ofSize: 12)
        lables[2].frame = CGRect(x: rectFrame.width-lables[2].font.pointSize-10, y: 5, width: 120, height: 12)
        self.addSubview(lables[2])
        lables[2].translatesAutoresizingMaskIntoConstraints = false
        lables[2].bottomAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive=true
        lables[2].rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive=true
        ///____________________________________________________________
        lables[3].text=segments[3]
        lables[3].textColor=UIColor.darkGray
        lables[3].font = UIFont.systemFont(ofSize: 12)
        lables[3].frame = CGRect(x: -50, y: (rectFrame.height/2)-lables[3].font.pointSize, width: 120, height: 10)
        lables[3].transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
        self.addSubview(lables[3])
        lables[3].translatesAutoresizingMaskIntoConstraints = false
        lables[3].centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
        lables[3].rightAnchor.constraint(equalTo: self.leftAnchor, constant: 45).isActive=true
        ///____________________________________________________________
        lables[4].text=segments[4]
        lables[4].textColor=UIColor.darkGray
        lables[4].font = UIFont.systemFont(ofSize: 12)
        lables[4].frame = CGRect(x: rectFrame.width-30, y: (rectFrame.height/2)+lables[4].font.pointSize*3/*CGFloat(segments[4].count/2)-30*/, width: 120, height: 12)
        lables[4].transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        self.addSubview(lables[4])
        lables[4].translatesAutoresizingMaskIntoConstraints = false
        lables[4].centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
        lables[4].leftAnchor.constraint(equalTo: self.rightAnchor, constant: -45).isActive=true
        ///____________________________________________________________
        lables[5].text=segments[5]
        lables[5].textColor=UIColor.lightGray
        lables[5].font = UIFont.systemFont(ofSize: 12)
        lables[5].frame = CGRect(x: 5, y: rectFrame.height+lables[5].font.pointSize+10, width: 120, height: 12)
        self.addSubview(lables[5])
        lables[5].translatesAutoresizingMaskIntoConstraints = false
        lables[5].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive=true
        lables[5].leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive=true
        ///__________________________________________________________________________________________
        lables[6].text=segments[6]
        lables[6].textColor=UIColor.darkGray
        lables[6].font = UIFont.systemFont(ofSize: 12)
        lables[6].frame = CGRect(x: (rectFrame.width/2)-lables[6].font.pointSize/2, y: rectFrame.height+lables[6].font.pointSize+10, width: 120, height: 12)
        self.addSubview(lables[6])
        lables[6].translatesAutoresizingMaskIntoConstraints = false
        lables[6].centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        lables[6].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive=true
        ///__________________________________________________________________________________________
        lables[7].text=segments[7]
        lables[7].textColor=UIColor.lightGray
        lables[7].font = UIFont.systemFont(ofSize: 12)
        lables[7].frame = CGRect(x: rectFrame.width-lables[7].font.pointSize, y: rectFrame.height+lables[7].font.pointSize+10, width: 120, height: 12)
        //lables[7].frame=CGRect(x: 0, y: rectFrame.height+lables[7].font.pointSize, width: 120, height: 12)
        self.addSubview(lables[7])
        lables[7].translatesAutoresizingMaskIntoConstraints = false
        lables[7].bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive=true
        lables[7].rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive=true
    }
    func drawAllLines(basicView:UIView, width: Int, height:Int, isHorizontal:Bool){
        var widthNew:CGFloat
        var heightNew:CGFloat
        var step:Int
        var xPos:Int
        var yPos:Int
        if (isHorizontal){
            widthNew=self.bounds.width-40
            heightNew=1
            step = (height/8)
            xPos=0
            yPos=step
        }
        else{
            widthNew=1
            heightNew=self.bounds.height-40
            step = (width/8)
            xPos=step
            yPos=0
        }
        
        for i in 0..<7{
            var color:CGColor
            if i==3{
                color=UIColor.black.cgColor
            }
            else{
                color=UIColor.lightGray.cgColor
            }
            var lineView = drawLine(x_new: xPos, y_new: yPos, width_new: widthNew, height_new: heightNew,color:color)
            basicView.addSubview(lineView)
            if(isHorizontal){
                yPos+=Int(step)
            }
            else{
                xPos+=Int(step)
            }
            
        }
        
    }
    
    func drawLine(x_new: Int, y_new: Int, width_new: CGFloat, height_new: CGFloat, color:CGColor)->UIView{
        var lineView = UIView(frame: CGRect(x: CGFloat(x_new), y: CGFloat(y_new), width: width_new, height: height_new))
        lineView.layer.borderWidth = 1.0
        lineView.layer.borderColor = color
        return lineView
        
    }
    func drawBlueCircle(in context: CGContext) {
        context.saveGState()
        context.setFillColor(UIColor.blue.cgColor)
        context.addEllipse(in: bounds)
        context.drawPath(using: .fill)
        context.restoreGState()
    }
    //    private func draw(text: String/*, in rect: CGRect*/, with color: UIColor, and font: UIFont) {
    //
    //        let attributes: [NSAttributedString.Key: Any] = [.font: font,
    //                                                         .foregroundColor: color,
    //                                                         .paragraphStyle: paragraphStyle]
    //        let string = NSAttributedString(string: text, attributes: attributes)
    //        let size = string.size()
    //        let yPos = self.bounds.width //+ size.height
    //        string.draw(at: CGPoint(x: 100, y: 100))
    //
    //    }
    
}
