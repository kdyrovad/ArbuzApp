//
//  ProductCollectionViewCell.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 21.05.2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    // MARK: - UI Components
    
    private var productImageView: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "template")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private let productNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Apple"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let productWeightLabel: UILabel = {
        let label = UILabel()
        label.text = "kg"
        label.textColor = .gray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "289 тг"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "customWhite")
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(productImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productWeightLabel)
        contentView.addSubview(priceLabel)
        
        productImageView.layer.cornerRadius = 10
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        productWeightLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            productImageView.heightAnchor.constraint(equalToConstant: 88),
            productImageView.widthAnchor.constraint(equalToConstant: 200),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            productWeightLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 4),
            productWeightLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productWeightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            priceLabel.topAnchor.constraint(equalTo: productWeightLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with product: Product){
        productImageView.image = UIImage(named: product.image)
        productNameLabel.text = product.name
        productWeightLabel.text = product.char
        priceLabel.text = product.price
    }
}
