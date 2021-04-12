//
//  RadioButtonsController.swift
//  Sampling app
//
//  Created by Назарова on 22.02.2021.
//

import Foundation
import UIKit

/// RadioButtonControllerDelegate. Delegate optionally implements didSelectButton that receives selected button.
@objc protocol RadioButtonControllerDelegate {
    /**
        This function is called when a button is selected. If 'shouldLetDeSelect' is true, and a button is deselected, this function
    is called with a nil.
    
    */
    @objc func didSelectButton(selectedButton: RadioButton?, index: Int)
}

class RadioButtonsController : NSObject
{
    fileprivate var buttonsArray = [RadioButton]()
    weak var delegate : RadioButtonControllerDelegate? = nil
    /**
        Set whether a selected radio button can be deselected or not. Default value is false.
    */
    var shouldLetDeSelect = false
    /**
        Variadic parameter init that accepts UIButtons.
        - parameter buttons: Buttons that should behave as Radio Buttons
    */
    init(buttons: [RadioButton]) {
        super.init()
        for aButton in buttons {
            aButton.addTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)
        }
        self.buttonsArray = buttons
    }
    
    /**
        Add a UIButton to Controller
        - parameter button: Add the button to controller.
    */
    func addButton(_ aButton: RadioButton) {
        buttonsArray.append(aButton)
        aButton.addTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)
    }
    /**
        Remove a UIButton from controller.
        - parameter button: Button to be removed from controller.
    */
    func removeButton(_ aButton: RadioButton) {
        var iteratingButton: RadioButton? = nil
        if(buttonsArray.contains(aButton))
        {
            iteratingButton = aButton
        }
        if(iteratingButton != nil) {
            buttonsArray.remove(at: buttonsArray.firstIndex(of: iteratingButton!)!)
            iteratingButton!.removeTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)
            iteratingButton!.isSelected = false
        }
    }
    /**
        Set an array of UIButons to behave as controller.
        
        - parameter buttonArray: Array of buttons
    */
    func setButtonsArray(_ aButtonsArray: [RadioButton]) {
        for aButton in aButtonsArray {
            aButton.addTarget(self, action: #selector(RadioButtonsController.pressed(_:)), for: UIControl.Event.touchUpInside)
        }
        buttonsArray = aButtonsArray
    }

    @objc func pressed(_ sender: RadioButton) {
        var currentSelectedButton: RadioButton? = nil
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
        let index = buttonsArray.firstIndex(where: { button in button.isSelected }) ?? -1
        delegate?.didSelectButton(selectedButton: currentSelectedButton, index: index)
    }
    /**
        Get the currently selected button.
    
        - returns: Currenlty selected button.
    */
    func selectedButton() -> RadioButton? {
        guard let index = buttonsArray.firstIndex(where: { button in button.isSelected }) else { return nil }
        
        return buttonsArray[index]
    }
}
