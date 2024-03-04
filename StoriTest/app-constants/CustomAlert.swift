//
//  CustomAlert.swift
//  StoriTest
//
//  Created by Cristian Hernandez Garcia on 02/03/24.
//

import UIKit

class CustomAlertView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.montserratMedium, size: .twenty)
        label.textColor = UIColor(hex: Colors.green900)
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: Fonts.montserratRegular, size: .fifteen)
        label.textColor = UIColor(hex: Colors.green700)
        label.numberOfLines = 0
        return label
    }()
    
    private let okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continuar", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.montserratBold, size: .twenty)
        button.setTitleColor(UIColor(hex: Colors.green900), for: .normal)
        return button
    }()
    
    init(title: String, message: String) {
        super.init(frame: .zero)
        
        setupViews()
        configure(with: title, message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = UIColor(hex: Colors.green200)
        layer.cornerRadius = 10.0
        layer.borderColor = UIColor(hex: Colors.green400).cgColor
        layer.borderWidth = 1.0
        
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(okButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            okButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            okButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    private func configure(with title: String, message: String) {
        titleLabel.text = title
        messageLabel.text = message
        okButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
    }
    
    @objc private func dismissAlert() {
        removeFromSuperview()
    }
}

extension UIViewController {
    
    func showCustomAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let customAlert = CustomAlertView(title: title, message: message)
            customAlert.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(customAlert)
            
            NSLayoutConstraint.activate([
                customAlert.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                customAlert.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                customAlert.widthAnchor.constraint(lessThanOrEqualToConstant: .threeHundred)
            ])
        }
    }
}
