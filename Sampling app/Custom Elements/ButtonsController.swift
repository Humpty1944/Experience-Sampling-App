//
//  ButtonsController.swift
//  Sampling app
//
//  Created by Назарова on 01.03.2021.
//

import Foundation
import UIKit

/// RadioButtonControllerDelegate. Delegate optionally implements didSelectButton that receives selected button.
@objc protocol ButtonControllerDelegate {
    /**
        This function is called when a button is selected. If 'shouldLetDeSelect' is true, and a button is deselected, this function
    is called with a nil.
    
    */
    @objc func didSelectButton(selectedButton: CustomButton?)
}

class ButtonsController : NSObject
{
    fileprivate var buttonsArray = [CustomButton]()
    weak var delegate : ButtonControllerDelegate? = nil
    /**
        Set whether a selected radio button can be deselected or not. Default value is false.
    */
    var shouldLetDeSelect = false
    /**
        Variadic parameter init that accepts UIButtons.
        - parameter buttons: Buttons that should behave as Radio Buttons
    */
    init(buttons: CustomButton...) {
        super.init()
        for aButton in buttons {
            aButton.addTarget(self, action: #selector(ButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)
        }
        self.buttonsArray = buttons
    }
    
    /**
        Add a UIButton to Controller
        - parameter button: Add the button to controller.
    */
    func addButton(_ aButton: CustomButton) {
        buttonsArray.append(aButton)
        aButton.addTarget(self, action: #selector(ButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)
    }
    /**
        Remove a UIButton from controller.
        - parameter button: Button to be removed from controller.
    */
    func removeButton(_ aButton: CustomButton) {
        var iteratingButton: CustomButton? = nil
        if(buttonsArray.contains(aButton))
        {
            iteratingButton = aButton
        }
        if(iteratingButton != nil) {
            buttonsArray.remove(at: buttonsArray.firstIndex(of: iteratingButton!)!)
            iteratingButton!.removeTarget(self, action: #selector(ButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)
            iteratingButton!.isSelected = false
        }
    }
    /**
        Set an array of UIButons to behave as controller.
        
        - parameter buttonArray: Array of buttons
    */
    func setButtonsArray(_ aButtonsArray: [CustomButton]) {
      
        for aButton in aButtonsArray {
            aButton.addTarget(self, action: #selector(ButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)

          
        }
        buttonsArray = aButtonsArray
    }

    @objc func pressed(_ sender: CustomButton) {
        var currentSelectedButton: CustomButton? = nil
        if(sender.isSelected) {
            if shouldLetDeSelect {
                sender.isSelected = false
                currentSelectedButton = nil
            }
        } else {
            for aButton in buttonsArray {
                aButton.isSelected = false
            }
            sender.isSelected = true
            currentSelectedButton = sender
        }
        delegate?.didSelectButton(selectedButton: currentSelectedButton)
    }
    /**
        Get the currently selected button.
    
        - returns: Currenlty selected button.
    */
    func selectedButton() -> CustomButton? {
        guard let index = buttonsArray.firstIndex(where: { button in button.isSelected }) else { return nil }

        return buttonsArray[index]
    }
}
