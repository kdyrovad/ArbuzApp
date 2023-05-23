//
//  BasicTextField.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 23.05.2023.
//

import Foundation
import UIKit

class BasicTextField: UITextField {

    init(placeholder: String) {
        super.init(frame: .zero)
        self.layer.cornerRadius = 10
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 0.3
        self.font = .boldSystemFont(ofSize: 14)
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.placeholder = placeholder
        self.leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
