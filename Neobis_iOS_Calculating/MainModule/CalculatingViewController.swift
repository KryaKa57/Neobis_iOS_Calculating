//
//  ViewController.swift
//  Neobis_iOS_Calculating
//
//  Created by Alisher on 16.11.2023.
//


// TODO: ЧИСЛО НА НОЛЬ И 0.00


import Foundation
import SnapKit
import UIKit

class CalculatingViewController: UIViewController {
    // MARK: Variables
    
    let screenBounds = UIScreen.main.bounds
    private let defaultInsetValue: Int = 16
    private let buttonTitles = [
        ["AC", "+/-", "%", "/"],
        ["7", "8", "9", "x"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="]
    ]
    private var btnArray: [CustomButton] = []
    private var btnAC: CustomButton?
    
    var viewModel: CalculatingViewModel = CalculatingViewModel()
    
    // MARK: - UI Components
    private lazy var displayLabel: VerticalAlignedLabel = {
        let label = VerticalAlignedLabel()
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
                if button.buttonModel == .operationMode {
                    btnArray.append(button)
                } else if title == "AC" {
                    btnAC = button
                }
                button.addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
                subView.addArrangedSubview(button)
            }
            subView.distribution = .fillProportionally
            subView.alignment = .fill
            subView.spacing = (screenBounds.width * 0.2 - CGFloat(defaultInsetValue * 2)) / 3
            subView.axis = .horizontal
            stack.addArrangedSubview(subView)
        }
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 12
        stack.axis = .vertical
        return stack
    }()
    
    // MARK: - Initialize
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        setConstraints()
        
        self.viewModel.updateViews = {
            self.displayLabel.text = self.viewModel.result
        }
        
        self.viewModel.showError = {
            self.displayLabel.text = "Ошибка"
        }
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
            make.width.equalTo(screenBounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(screenBounds.height - (screenBounds.width + 48) - 16 - 64 - 64)
                                // height - keypadHeight - top.offset of keyPad - top.offset of display - bottom offset from keyPad
        }
        self.keypadStackView.snp.makeConstraints { (make) in
            make.top.equalTo(displayLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(defaultInsetValue)
            make.width.equalTo(screenBounds.width - CGFloat(defaultInsetValue * 2))
            make.height.equalTo(screenBounds.width + 48)
        }
    }
    
    // MARK: - Actions
    @objc func didTap(_ sender: CustomButton!) {
        let buttonTitleText = sender.titleText ?? ""
        let buttonModel = sender.buttonModel
        
        if ["=", "AC"].contains(buttonTitleText) {for btn in btnArray { btn.isClicked = false }}
        else if buttonModel == .operationMode {for btn in btnArray { btn.isClicked = (btn == sender) }}
        
        self.viewModel.didTapAction(buttonTitleText, buttonModel)
        
        btnAC?.titleText = (self.viewModel.displayValue == "0") ? "AC" : "C"
    }
    
    @objc func swipeLabelFunc (_ sender: VerticalAlignedLabel!) {
        self.viewModel.swipeAction()
    }
}

