//
//  ButtonModel.swift
//  Neobis_iOS_Calculating
//
//  Created by Alisher on 21.11.2023.
//

import Foundation
import UIKit

enum ButtonModel: String {
    case numberMode = "number"
    case operationMode = "operation"
    case displayMode = "display"
}

extension ButtonModel {
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
    
    var selectedBackgroundColor: UIColor? {
        switch self {
        case .numberMode, .displayMode:
            return nil
        case .operationMode:
            return .white
        }
    }
    
    var selectedTintColor: UIColor? {
        switch self {
        case .numberMode, .displayMode:
            return nil
        case .operationMode:
            return UIColor(rgb: 0xFF9500)
        }
    }
}
