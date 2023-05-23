//
//  BasketTableViewCell.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 21.05.2023.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    static let identifier = "BasketTableViewCell"
    
    // MARK: - UI Components
    
    private var productImageView: UIImageView = {
         let image = UIImageView()
         image.contentMode = .scaleAspectFit
         image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
         return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "main")
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - UI Setup

    private func setupUI() {
        contentView.addSubview(productImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(priceLabel)
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            productImageView.widthAnchor.constraint(equalToConstant: 120),
            productImageView.heightAnchor.constraint(lessThanOrEqualTo: productImageView.widthAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            priceLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(name: String, price: String, imageName: String) {
        productImageView.image = UIImage(named: imageName)
        nameLabel.text = name
        priceLabel.text = price
    }
}
