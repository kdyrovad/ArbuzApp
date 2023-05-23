//
//  ProductDetailViewController.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 21.05.2023.
//

import UIKit

protocol ProductDetailsViewProtocol {
}

class ProductDetailsViewController: UIViewController, ProductDetailsViewProtocol{

    // MARK: - Variables

    private var product: Product
    var presenter: ProductDetailsPresenterProtocol!
    
    // MARK: - UI Components

    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "template")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let productNameLabel: UILabel = {
       let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.text = "Some text: Apple"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .regular)
        return label
    }()
    
    private let priceLabel: UILabel = {
       let label = UILabel()
        label.text = "800tg"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("В корзину", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#2cbc34")
        button.layer.cornerRadius = 10
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(product: Product){
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        configure()
        
        view.addSubview(imageView)
        view.addSubview(productNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(addButton)
        
        configureConstraints()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        addButton.addTarget(self, action: #selector(AddToCart), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        productNameLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            productNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            productNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productNameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            
            priceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            priceLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor),
            
            addButton.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            addButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07),
            addButton.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 40),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func configure() {
        imageView.image = UIImage(named: product.image)
        productNameLabel.text = product.name
        priceLabel.text = product.price
        
        if product.isInStock {
            addButton.backgroundColor = UIColor(hexString: "#2cbc34")
        } else {
            addButton.backgroundColor = UIColor.gray
        }
    }
    
    // MARK: - Selectors
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
    }
    
    @objc private func AddToCart() {
        if product.isInStock {
            DataPersistanceManager.shared.downloadProduct(model: self.product) { result in
                switch result{
                case .success():
                    NotificationCenter.default.post(name: NSNotification.Name("Downloaded"), object: nil)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            dismiss(animated: true, completion: nil)
        } else {
            showAlert(with: "К сожалению \(product.name) на данный момент нет в наличии:(")
        }
    }
}
