//
//  ViewController.swift
//  Neobis_iOS_Calculating
//
//  Created by Alisher on 16.11.2023.
//

import Foundation
import SnapKit
import UIKit

class CalculatingViewController: UIViewController {

    private let defaultInsetValue: Int = 16
    
    private var displayValue = "0" {
        didSet {
            displayLabel.text = displayValue
        }
    }
    
    private var operation = ""
    private var leftValue = 0.0
    private var rightValue = 0.0
    private var previousAction = ""
    
    private lazy var displayLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .purple
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()
    
    let buttonTitles = [
        ["AC", "+/-", "%", "/"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    private lazy var keypadStackView: UIStackView = {
        let stack = UIStackView()
        for i in 0...4 {
            let subView = UIStackView()
            for title in buttonTitles[i] {
                let button = CustomButton()
                button.titleText = title
                button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
                subView.addArrangedSubview(button)
            }
            subView.distribution = .fillProportionally
            subView.alignment = .fill
            subView.spacing = (UIScreen.main.bounds.width * 0.2 - CGFloat(defaultInsetValue * 2)) / 3
            subView.axis = .horizontal
            stack.addArrangedSubview(subView)
        }
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 12
        stack.axis = .vertical
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setConstraints()
    }

    private func initialize() {
        view.backgroundColor = .black
        
        view.addSubview(displayLabel)
        view.addSubview(keypadStackView)
    }
    
    private func setConstraints() {
        self.displayLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(64)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.height - (UIScreen.main.bounds.width + 48) - 16 - 64 - 64)
                                // height - keypadHeight - top.offset of keyPad - top.offset of display - bottom offset from keyPad
        }
        self.keypadStackView.snp.makeConstraints { (make) in
            make.top.equalTo(displayLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.width + 48)
        }
    }
    
    @objc func didTap(_ sender: CustomButton!) {
        let text = sender.titleText ?? ""
        let displayDoubleValue = Double(displayValue) ?? 0.0
        
        switch sender.buttonStyle {
        case .numberMode :
            if text != "." || !displayValue.contains(".") { // чтобы не создать больше одной точки
                if (displayDoubleValue == 0 || previousAction == "=")
                        && text != "."
                        && !displayValue.hasSuffix(".") {
                    self.displayValue = "\(text)"
                } else {
                    self.displayValue = "\(displayValue)\(text)"
                }
                
                if previousAction == "=" {
                    operation = ""
                    leftValue = 0
                    rightValue = 0
                }
            }
            
            
        case .operationMode:
            if text == "=" {
                if previousAction != "=" {
                    rightValue = displayDoubleValue
                }
                if operation == "+" {
                    displayValue = toFormatResult(leftValue + rightValue)
                } else if operation == "-" {
                    displayValue = toFormatResult(leftValue - rightValue)
                } else if operation == "/" {
                    displayValue = toFormatResult(leftValue / rightValue)
                } else if operation == "x" {
                    displayValue = toFormatResult(leftValue * rightValue)
                } else {
                    break
                }
                leftValue = Double(displayValue) ?? 0.0
            } else {
                operation = text
                if displayDoubleValue != 0 || leftValue == 0 {
                    leftValue = displayDoubleValue
                    displayValue = "0"
                }
            }
        case .displayMode:
            if text == "AC" {
                displayValue = "0"
                leftValue = 0
                rightValue = 0
                operation = ""
            } else if text == "+/-" {
                if displayValue.hasPrefix("-") {
                    displayValue = String(displayValue.dropFirst())
                } else {
                    displayValue = "-\(displayValue)"
                }
            } else {
                displayValue = toFormatResult(displayDoubleValue / 100)
            }
        }
        previousAction = text
    }
    
    func toFormatResult(_ double: Double) -> String {
        let result = double.rounded(toPlaces: 6)
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(double))"
        } else {
            return String(result)
        }
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
