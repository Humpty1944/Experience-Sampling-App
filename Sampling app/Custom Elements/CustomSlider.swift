//
//  CustomSlider.swift
//  Sampling app
//
//  Created by Назарова on 22.02.2021.
//
import  UIKit
@IBDesignable
class CustomSliderLabels:UISlider{
   
    @IBInspectable
    var segments: String = "Стресс"
    var number:UILabel = UILabel()
    var type:UILabel = UILabel()
override init(frame: CGRect) {
    super.init(frame: frame)
    
     configure()
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
     configure()
}

    private func configure() {
        self.addTarget(self, action: #selector(valueChangedOfSlider(slider:)), for: .valueChanged)
        self.value=5

    }
    override func draw(_ rect: CGRect) {

        number.text=""
        number.layer.masksToBounds = true
        number.textColor=UIColor.darkGray
        number.font = UIFont.systemFont(ofSize: 14)
        number.frame = CGRect(x: -70, y: 0, width: 25, height: 25)
        number.backgroundColor = color.UIColorFromRGB(rgbValue: 0xF6F6F6)
        number.textAlignment = .center;
        //number.layer.borderWidth = 1.0
       // number.layer.borderColor = color.UIColorFromRGB(rgbValue: 0xF6F6F6).cgColor
        number.layer.cornerRadius=number.frame.width/2
        self.addSubview(number)
        number.translatesAutoresizingMaskIntoConstraints = false
        number.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
        number.rightAnchor.constraint(equalTo: self.leftAnchor, constant: -35).isActive=true
        number.widthAnchor.constraint(equalToConstant: 24).isActive=true
        number.heightAnchor.constraint(equalToConstant: 24).isActive=true
        
        ///____________________________________________________________________
        type.text=segments
        type.textColor=color.UIColorFromRGB(rgbValue: 0x6C6C6C)
        type.font = UIFont.boldSystemFont(ofSize: 14)
        type.frame = CGRect(x: self.bounds.width/2+CGFloat(14*segments.count), y: -20, width: 100, height: 15)
        self.addSubview(type)
        type.translatesAutoresizingMaskIntoConstraints = false
        type.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        type.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -12).isActive=true
        

}
    @objc func valueChangedOfSlider(slider: UISlider)
    {
        number.text=String(Int(self.value))
    }
     
}

@IBDesignable
    class CustomSlider: UISlider {
        @IBInspectable
        var segments: [String] = ["Стресс", "Тревога"]
        var firstWord:UILabel = UILabel()
        var secondWord:UILabel = UILabel()
       @IBInspectable var ticksNumber: Int = 10
        @IBInspectable
           var segmentColor: UIColor = .darkGray
        @IBInspectable
           var isTick: Bool = false
         override func draw(_ rect: CGRect) {
            if isTick{
            var xPos:CGFloat=3.0
      
            for i in 0..<ticksNumber{
                let tick = UIView(frame: CGRect(x: xPos, y:  (self.frame.size.height-15) / 2, width: 1, height: 15))
                tick.backgroundColor = segmentColor// color.UIColorFromRGB(rgbValue: 0xDDDDDD)
                tick.tag = i
                self.insertSubview(tick, at: 0)
                //rect.width
                xPos+=(( rect.width/CGFloat(ticksNumber)))
            }
            let tick = UIView(frame: CGRect(x: xPos-7, y:  (self.frame.size.height-15) / 2, width: 1, height: 15))
            tick.backgroundColor = segmentColor// color.UIColorFromRGB(rgbValue: 0xDDDDDD)
            tick.tag = ticksNumber
            self.insertSubview(tick, at: 0)
            }
            
              createLabels()
        }
        
        func createLabels(){
            firstWord.text=segments[1]
            firstWord.textColor=color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            firstWord.font = UIFont.boldSystemFont(ofSize: 14)
            firstWord.frame = CGRect(x: -10, y: -20, width: 100, height: 15)
            secondWord.text=segments[0]
            secondWord.textColor=color.UIColorFromRGB(rgbValue: 0x6C6C6C)
            secondWord.font = UIFont.boldSystemFont(ofSize: 14)
            secondWord.frame = CGRect(x: self.bounds.width-CGFloat(segments[1].count*7), y: -20, width: 100, height: 15)

            self.addSubview(firstWord)
            self.addSubview(secondWord)
            firstWord.translatesAutoresizingMaskIntoConstraints = false
            firstWord.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -10).isActive=true
            firstWord.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive=true
            secondWord.translatesAutoresizingMaskIntoConstraints = false
            secondWord.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive=true
            secondWord.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive=true


        }
        
}