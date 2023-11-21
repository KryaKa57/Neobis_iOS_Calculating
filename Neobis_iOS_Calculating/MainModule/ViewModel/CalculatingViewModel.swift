//
//  CalculatingViewModel.swift
//  Neobis_iOS_Calculating
//
//  Created by Alisher on 20.11.2023.
//

import Foundation

class CalculatingViewModel {
    var updateViews: (()->Void)?
    var showError: (()->Void)?
    
    var operation = ""
    var leftValue = 0.0
    var rightValue = 0.0
    var previousAction = ""
    var result = ""
    
    var isError = false
    
    var displayValue = "0" {
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
            
            result = formatter.string(from: NSNumber(floatLiteral: Double(displayValue) ?? 0)) ?? ""
            if displayValue.hasSuffix(".") {result.append(".")}
            
            self.updateViews?()
        }
    }
    
    func didTapAction(_ text: String, _ buttonModel: ButtonModel) {
        let displayDoubleValue = Double(displayValue) ?? 0.0
        switch buttonModel {
        case .numberMode :
            if text == "." {
                if !displayValue.contains(".") { displayValue.append(text) }
            }
            else {
                numberButtonTappedAction(text: text, displayDoubleValue: displayDoubleValue)
                
                if previousAction == "=" {
                    previousAction = ""
                    operation = ""
                    leftValue = 0
                    rightValue = 0
                }
            }
        case .operationMode:
            if text == "=" {
                equalButtonTappedAction()
            } else {
                if operation != ""  && displayValue != "0" && !["/", "x", "-", "+", "="].contains(previousAction) {
                    equalButtonTappedAction()
                }
                operation = text
                if displayDoubleValue != 0 && leftValue == 0 {leftValue = displayDoubleValue }
            }
            
        case .displayMode:
            if text == "AC" {
                isError = false
                displayValue = "0"
                leftValue = 0
                rightValue = 0
                operation = ""
            } else if text == "+/-" {
                displayValue = displayValue.hasPrefix("-") ? "\(displayValue.dropFirst())" : "-\(displayValue)"
            } else if text == "C" {
                isError = false
                displayValue = "0"
            } else {
                displayValue = "\(displayDoubleValue / 100)"
            }
        }
        
        previousAction = text
    }
    
    func equalButtonTappedAction() {
        if previousAction != "=" {
            rightValue = Double(displayValue) ?? 0.0
        }
        
        switch operation {
        case "+":
            displayValue = "\(leftValue + rightValue)"
        case "-":
            displayValue = "\(leftValue - rightValue)"
        case "/":
            displayValue = "\(leftValue / rightValue)"
            if rightValue == 0 {
                self.showError?()
            }
        default:
            displayValue = "\(leftValue * rightValue)"
        }
        
        leftValue = Double(displayValue) ?? 0.0
    }
    
    func numberButtonTappedAction(text: String, displayDoubleValue: Double) {
        if (["/", "x", "-", "+", "="].contains(previousAction)) {
            self.displayValue = text
        }
        else if (displayValue.count - (displayValue.contains(".") ? 1 : 0) < 13) {
            self.displayValue = (displayDoubleValue == 0 && !displayValue.hasSuffix(".")) ? text : "\(displayValue)\(text)"
        }
    }
    
    func swipeAction() {
        if displayValue != "0" {
            displayValue = displayValue.count > 1 ? String(displayValue.dropLast()) : "0"
        }
    }
}


