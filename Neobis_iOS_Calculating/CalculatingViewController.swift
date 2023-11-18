//
//  ViewController.swift
//  Neobis_iOS_Calculating
//
//  Created by Alisher on 16.11.2023.
//


// TODO: "Clear" if number exist

import Foundation
import SnapKit
import UIKit

class CalculatingViewController: UIViewController {

    private let defaultInsetValue: Int = 16
    
    private var operation = ""
    private var leftValue = 0.0
    private var rightValue = 0.0
    private var previousAction = ""
    
    let buttonTitles = [
        ["AC", "+/-", "%", "/"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    
    var btnArray: [CustomButton] = []
    
    private var displayValue = "0" {
        didSet {
            let formatter = NumberFormatter()
            
            if String(Double(displayValue)?.rounded(toPlaces: 5) ?? 0).count > 13 {
                formatter.numberStyle = .scientific
                formatter.positiveFormat = "0.###E+0"
                formatter.exponentSymbol = "e"
            } else {
                formatter.usesGroupingSeparator = true
                formatter.numberStyle = .decimal
                formatter.maximumFractionDigits = 8 - "\(Int(displayValue) ?? 0)".count
            }
            
            var result = formatter.string(from: NSNumber(floatLiteral: Double(displayValue) ?? 0))
            if displayValue.hasSuffix(".") {result?.append(".")}
            displayLabel.text = result
        }
    }
    
    private lazy var displayLabel: VerticalAlignedLabel = {
        let label = VerticalAlignedLabel()
        // label.backgroundColor = .purple
        label.contentMode = .bottom
        label.text = "0"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 64)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        
        label.isUserInteractionEnabled = true
        let myRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLabelFunc(_:)))
        myRecognizer.direction = [.left, .right]

        label.addGestureRecognizer(myRecognizer)
        return label
    }()
    
    
    private lazy var keypadStackView: UIStackView = {
        let stack = UIStackView()
        for i in 0...4 {
            let subView = UIStackView()
            for title in buttonTitles[i] {
                let button = CustomButton()
                button.titleText = title
                if button.buttonStyle == .operationMode {
                    btnArray.append(button)
                }
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
            if text == "." {
                self.displayValue.append(displayValue.contains(".") ? "" : ".")
            }
            else {
                if (displayValue.count - (displayValue.contains(".") ? 1 : 0) < 13
                        || ["/", "x", "-", "+", "="].contains(previousAction))
                {
                    self.displayValue = ((displayDoubleValue == 0 || ["/", "x", "-", "+", "="].contains(previousAction))
                                         && !displayValue.hasSuffix(".")) ? "\(text)" : "\(displayValue)\(text)"
                }
                
                if previousAction == "=" {
                    operation = ""
                    leftValue = 0
                    rightValue = 0
                }
            }
        case .operationMode:
            if text == "=" {
                equalButtonTappedAction()
                for btn in btnArray { btn.isClicked = false }
            } else {
                if operation != ""  && displayValue != "0" && !["/", "x", "-", "+", "="].contains(previousAction){
                    equalButtonTappedAction()
                }
                operation = text
                if displayDoubleValue != 0 && leftValue == 0 { leftValue = displayDoubleValue }
                for btn in btnArray { btn.isClicked = (btn == sender) }
            }
            
        case .displayMode:
            if text == "AC" {
                displayValue = "0"
                leftValue = 0
                rightValue = 0
                operation = ""
                for btn in btnArray { btn.isClicked = false }
            } else if text == "+/-" {
                if displayValue.hasPrefix("-") {
                    displayValue = String(displayValue.dropFirst())
                } else {
                    displayValue = "-\(displayValue)"
                }
            } else {
                displayValue = "\(displayDoubleValue / 100)"
            }
        }
        
        previousAction = text
    }
    
    @objc func swipeLabelFunc (_ sender: VerticalAlignedLabel!) {
        if displayValue != "0" {
            displayValue = String(displayValue.dropLast())
            if displayValue == "" {
                displayValue = "0"
            }
        }
    }

    func equalButtonTappedAction() {
        if previousAction != "=" {
            rightValue = Double(displayValue) ?? 0.0
        }
        
        print(leftValue)
        print(operation)
        print(rightValue)
        if operation == "+" {
            displayValue = "\(leftValue + rightValue)"
        } else if operation == "-" {
            displayValue = "\(leftValue - rightValue)"
        } else if operation == "/" {
            displayValue = "\(leftValue / rightValue)"
        } else if operation == "x" {
            displayValue = "\(leftValue * rightValue)"
        }
        
        leftValue = Double(displayValue) ?? 0.0
        print(leftValue)
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
