//
//  SectionHeader.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 21.05.2023.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
     static let identifier = "SectionHeader"
    
    // MARK: - UI Component
    
     var label: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .secondaryLabel
         label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
         label.sizeToFit()
         return label
     }()
    
    // MARK: - Lifecycle

     override init(frame: CGRect) {
         super.init(frame: frame)

         setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
