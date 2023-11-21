//
//  CustomButton.swift
//  Neobis_iOS_Calculating
//
//  Created by Alisher on 16.11.2023.
//

import Foundation
import UIKit


class CustomButton: UIButton {
    let width = UIScreen.main.bounds.width * 0.2
    var buttonModel = ButtonModel.numberMode
    
    let numberButtonElements = "0123456789."
    let operationButtonElements = "/x-+="
    let displayButtonElements = "AC+/-%"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    @IBInspectable var titleText: String? {
        didSet {
            let titleTextUnwrapped = titleText ?? ""
            let attributedTitle = NSAttributedString(string: titleTextUnwrapped,
                                                     attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)])
            
            self.setAttributedTitle(attributedTitle, for: .normal)
            
            
            if numberButtonElements.contains(titleTextUnwrapped) {
                buttonModel = .numberMode
            } else if operationButtonElements.contains(titleTextUnwrapped) {
                buttonModel = .operationMode
            } else {
                buttonModel = .displayMode
            }
            setupWithStyle(buttonModel)
        }
    }
    
    @IBInspectable var isClicked: Bool = false {
        didSet {
            setupWithStyle(buttonModel, isClicked)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        if self.titleText == "0" {
            return CGSize(width: self.width * 2 + 16, height: 1)
        }
        return CGSize(width: self.width, height: 1)
    }
    
    func setup() {
        self.layer.cornerRadius = width / 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupWithStyle(_ model: ButtonModel, _ isSelected: Bool = false){
        setTitleColor(isSelected ? model.selectedTintColor : model.tintColor, for  : .normal)
        backgroundColor = isSelected ? model.selectedBackgroundColor : model.backgroundColor
    }
}
