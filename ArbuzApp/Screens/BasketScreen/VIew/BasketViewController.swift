//
//  BasketViewController.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 20.05.2023.
//

import UIKit

class BasketViewController: UIViewController {
    
    // MARK: Variables

    private var products: [ProductElement] = [ProductElement]()
    
    // MARK: - UI Components

    private let savedTable: UITableView = {
        let table = UITableView()
        table.register(BasketTableViewCell.self, forCellReuseIdentifier: BasketTableViewCell.identifier)
        return table
    } ()
    
    private lazy var makePurchaseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оформить покупку", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#2cbc34")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont(name: "SF Pro Text", size: 17)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        button.addTarget(self, action: #selector(makePurchaseButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        navigationItem.title = "Корзина"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        savedTable.delegate = self
        savedTable.dataSource = self
        
        fetchLocalStorage()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorage()
        }
    }
    
    // MARK: - UI Setup

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savedTable.frame = view.bounds
    }
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(savedTable)
        view.addSubview(makePurchaseButton)
        
        NSLayoutConstraint.activate([
            savedTable.topAnchor.constraint(equalTo: view.topAnchor),
            savedTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            makePurchaseButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            makePurchaseButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            makePurchaseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            makePurchaseButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    
    //MARK: - Methods
    
    func fetchLocalStorage(){
        DataPersistanceManager.shared.fetchingProductsFromDB { [weak self] result in
            switch result {
            case .success(let products):
                self?.products = products
                self?.savedTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func makePurchaseButtonTapped() {
        navigationController?.pushViewController(PurchaseDetailViewController(), animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BasketTableViewCell.identifier, for: indexPath) as? BasketTableViewCell else {
            return UITableViewCell()
        }
        let product = products[indexPath.row]
        cell.configure(name: product.name ?? "",
                       price: product.price ?? "",
                       imageName: product.image ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistanceManager.shared.deleteTitleWith(model: products[indexPath.row]) { [weak self] result in
                switch result {
                case .success(): print("Deleted")
                case .failure(let error): print(error.localizedDescription)
                }
                
                self?.products.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default: break;
        }
    }
}


//MARK: - Extension UIColor

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
