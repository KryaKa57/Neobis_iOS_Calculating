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
        ["0", ",", "="]
    ]
    
    private lazy var keypadStackView: UIStackView = {
        let stack = UIStackView()
        for i in 0...4 {
            let subView = UIStackView()
            for title in buttonTitles[i] {
                let button = CustomButton()
                button.titleText = title
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
            make.height.equalTo(UIScreen.main.bounds.height * 0.3)
        }
        self.keypadStackView.snp.makeConstraints { (make) in
            make.top.equalTo(displayLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.width + 48)
        }
    }
    
}

