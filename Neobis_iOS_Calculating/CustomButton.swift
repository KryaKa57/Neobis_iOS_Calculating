//
//  CustomButton.swift
//  Neobis_iOS_Calculating
//
//  Created by Alisher on 16.11.2023.
//

import Foundation
import UIKit

enum ButtonStyle: String {
    case numberMode = "number"
    case operationMode = "operation"
    case displayMode = "display"
    
    var tintColor: UIColor {
        return (self == .displayMode) ? .black : .white
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .displayMode:
            return UIColor(rgb: 0xD4D4D2)
        case .numberMode:
            return UIColor(rgb: 0x505050)
        case .operationMode:
            return UIColor(rgb: 0xFF9500)
        }
    }
}

class CustomButton: UIButton {
    var width = UIScreen.main.bounds.width * 0.2
    var buttonStyle = ButtonStyle.numberMode
    
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
                setupWithStyle(.numberMode)
            } else if operationButtonElements.contains(titleTextUnwrapped) {
                setupWithStyle(.operationMode)
            } else {
                setupWithStyle(.displayMode)
            }
        }
    }
    
    @IBInspectable var isClicked: Bool = false {
        didSet {
            if isClicked {
                self.backgroundColor = .white
                self.setTitleColor(UIColor(rgb: 0xFF9500), for  : .normal)
            } else {
                setupWithStyle(.operationMode)
            }
        }
    }
    
    func setup() {
        self.layer.cornerRadius = UIScreen.main.bounds.width * 0.2 / 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var intrinsicContentSize: CGSize {
        if self.titleText == "0" {
            return CGSize(width: self.width * 2 + 16, height: 1)
        }
        return CGSize(width: self.width, height: 1)
    }
    
    func setupWithStyle(_ style: ButtonStyle){
        buttonStyle = style.self
        setTitleColor(style.tintColor, for  : .normal)
        backgroundColor = style.backgroundColor
    }
}
