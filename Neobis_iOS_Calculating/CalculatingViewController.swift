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
    
    // First line of buttons
    private lazy var clearAllButton: UIButton = {
        let button = CustomButton()
        button.titleText = "AC"
        button.style = "display"
        return button
    }()
    private lazy var negativeDisplayButton: UIButton = {
        let button = CustomButton()
        button.titleText = "+/-"
        button.style = "display"
        return button
    }()
    private lazy var percentDisplayButton: UIButton = {
        let button = CustomButton()
        button.titleText = "%"
        button.style = "display"
        return button
    }()
    private lazy var divideButton: UIButton = {
        let button = CustomButton()
        button.titleText = "/"
        button.style = "operation"
        return button
    }()
    
    private lazy var firstLineStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(clearAllButton)
        stack.addArrangedSubview(negativeDisplayButton)
        stack.addArrangedSubview(percentDisplayButton)
        stack.addArrangedSubview(divideButton)
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = (UIScreen.main.bounds.width * 0.2 - CGFloat(defaultInsetValue * 2)) / 3
        stack.axis = .horizontal
        return stack
    }()
    
    // Second line of buttons
    private lazy var sevenButton: UIButton = {
        let button = CustomButton()
        button.titleText = "7"
        button.style = "number"
        return button
    }()
    private lazy var eightButton: UIButton = {
        let button = CustomButton()
        button.titleText = "8"
        button.style = "number"
        return button
    }()
    private lazy var nineButton: UIButton = {
        let button = CustomButton()
        button.titleText = "9"
        button.style = "number"
        return button
    }()
    private lazy var multipleButton: UIButton = {
        let button = CustomButton()
        button.titleText = "x"
        button.style = "operation"
        return button
    }()
    
    private lazy var secondLineStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(sevenButton)
        stack.addArrangedSubview(eightButton)
        stack.addArrangedSubview(nineButton)
        stack.addArrangedSubview(multipleButton)
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = (UIScreen.main.bounds.width * 0.2 - CGFloat(defaultInsetValue * 2)) / 3
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var fourButton: UIButton = {
        let button = CustomButton()
        button.titleText = "4"
        button.style = "number"
        return button
    }()
    private lazy var fiveButton: UIButton = {
        let button = CustomButton()
        button.titleText = "5"
        button.style = "number"
        return button
    }()
    private lazy var sixButton: UIButton = {
        let button = CustomButton()
        button.titleText = "6"
        button.style = "number"
        return button
    }()
    private lazy var subtractButton: UIButton = {
        let button = CustomButton()
        button.titleText = "-"
        button.style = "operation"
        return button
    }()
    private lazy var thirdLineStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(fourButton)
        stack.addArrangedSubview(fiveButton)
        stack.addArrangedSubview(sixButton)
        stack.addArrangedSubview(subtractButton)
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = (UIScreen.main.bounds.width * 0.2 - CGFloat(defaultInsetValue * 2)) / 3
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var oneButton: UIButton = {
        let button = CustomButton()
        button.titleText = "1"
        button.style = "number"
        return button
    }()
    private lazy var twoButton: UIButton = {
        let button = CustomButton()
        button.titleText = "2"
        button.style = "number"
        return button
    }()
    private lazy var threeButton: UIButton = {
        let button = CustomButton()
        button.titleText = "3"
        button.style = "number"
        return button
    }()
    private lazy var addButton: UIButton = {
        let button = CustomButton()
        button.titleText = "+"
        button.style = "operation"
        return button
    }()
    private lazy var fourthLineStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(oneButton)
        stack.addArrangedSubview(twoButton)
        stack.addArrangedSubview(threeButton)
        stack.addArrangedSubview(addButton)
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = (UIScreen.main.bounds.width * 0.2 - CGFloat(defaultInsetValue * 2)) / 3
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var zeroButton: UIButton = {
        let button = CustomButton()
        button.titleText = "0"
        button.style = "number"
        return button
    }()
    private lazy var zeroButton2: UIButton = {
        let button = CustomButton()
        button.titleText = "0"
        button.style = "number"
        return button
    }()
    private lazy var commaButton: UIButton = {
        let button = CustomButton()
        button.titleText = ","
        button.style = "number"
        return button
    }()
    private lazy var equalButton: UIButton = {
        let button = CustomButton()
        button.titleText = "="
        button.style = "operation"
        return button
    }()
    private lazy var fifthLineStackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(zeroButton)
        stack.addArrangedSubview(zeroButton2)
        stack.addArrangedSubview(commaButton)
        stack.addArrangedSubview(equalButton)
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = (UIScreen.main.bounds.width * 0.2 - CGFloat(defaultInsetValue * 2)) / 3
        stack.axis = .horizontal
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
        
        view.addSubview(clearAllButton)
        view.addSubview(negativeDisplayButton)
        view.addSubview(percentDisplayButton)
        view.addSubview(divideButton)
        view.addSubview(firstLineStackView)
        
        view.addSubview(sevenButton)
        view.addSubview(eightButton)
        view.addSubview(nineButton)
        view.addSubview(multipleButton)
        view.addSubview(secondLineStackView)
        
        view.addSubview(fourButton)
        view.addSubview(fiveButton)
        view.addSubview(sixButton)
        view.addSubview(subtractButton)
        view.addSubview(thirdLineStackView)
        
        view.addSubview(oneButton)
        view.addSubview(twoButton)
        view.addSubview(threeButton)
        view.addSubview(addButton)
        view.addSubview(fourthLineStackView)
        
        view.addSubview(zeroButton)
        view.addSubview(zeroButton2)
        view.addSubview(commaButton)
        view.addSubview(equalButton)
        view.addSubview(fifthLineStackView)
        
    }
    
    private func setConstraints() {
        self.displayLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(64)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.height * 0.3)
        }
        self.firstLineStackView.snp.makeConstraints { (make) in
            make.top.equalTo(displayLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.width * 0.2)
        }
        self.secondLineStackView.snp.makeConstraints { (make) in
            make.top.equalTo(firstLineStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.width * 0.2)
        }
        self.thirdLineStackView.snp.makeConstraints { (make) in
            make.top.equalTo(secondLineStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.width * 0.2)
        }
        self.fourthLineStackView.snp.makeConstraints { (make) in
            make.top.equalTo(thirdLineStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.width * 0.2)
        }
        self.fifthLineStackView.snp.makeConstraints { (make) in
            make.top.equalTo(fourthLineStackView.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(UIScreen.main.bounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(UIScreen.main.bounds.width * 0.2)
        }
    }
    
}

