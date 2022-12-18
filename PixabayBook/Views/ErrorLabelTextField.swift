//
//  ErrorLabelTextField.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 17/12/2022.
//

import UIKit

class ErrorLabelTextField: UITextField {
    
    private(set) lazy var errorLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .red
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addErrorLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addErrorLabel()
    }
    
    private func addErrorLabel() {
        addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: bottomAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
