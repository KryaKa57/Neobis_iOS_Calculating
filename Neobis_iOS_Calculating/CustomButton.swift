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
    
    @IBInspectable var titleText: String? {
        didSet {
            let attributedTitle = NSAttributedString(string: titleText ?? "",
                                                     attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24)])
            self.setAttributedTitle(attributedTitle, for: .normal)
        }
    }
    
    @IBInspectable var style: String? {
        set { setupWithStyleNamed(newValue) }
        get { return nil }
    }
    
    private func setupWithStyleNamed(_ named: String?){
        if let styleName = named, let style = ButtonStyle(rawValue: styleName) {
            setupWithStyle(style)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        self.layer.cornerRadius = UIScreen.main.bounds.width * 0.2 / 2
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupWithStyle(_ style: ButtonStyle){
        setTitleColor(style.tintColor, for: .normal)
        backgroundColor = style.backgroundColor
    }
    
}
