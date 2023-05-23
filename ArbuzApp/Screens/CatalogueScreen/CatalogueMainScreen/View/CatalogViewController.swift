//
//  CatalogVC.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 19.05.2023.
//

import UIKit


protocol CatalogueViewProtocol: UIViewController {
    func showProductDetails(product: Product)
}

class CatalogueViewController: UIViewController, CatalogueViewProtocol {
    
    // MARK: - UI Components
    
    var presenter: CataloguePresenterProtocol
    var products: [String : [Product]]?
    lazy private var images = ["poster1", "poster2", "poster3.jpeg"]
    
    lazy private var searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        searchBar.backgroundColor = .clear
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Искать на Арбузе"
       return searchBar
    }()
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: - Lifecycle
    
    init(presenter: CataloguePresenterProtocol) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        
        presenter.loadView()
        setupUI()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    //MARK: - Methods
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func configureNavBar() {
        var image = UIImage(named: "arbuzLogo")?.resizeTo(size: CGSize(width: 130, height: 95))
        let imageview = UIImageView(image: UIImage(named: "arbuzLogo")?.resizeTo(size: CGSize(width: 100, height: 25)))
        imageview.frame = CGRect(x: 0, y: 0, width: 100, height: 25)
        image = image?.withRenderingMode(.alwaysOriginal)

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: imageview)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .done, target: self, action: nil)
        ]

        navigationController?.navigationBar.tintColor = .black
    }

    func update(products: [String : [Product]]?) {
        self.products = products
    }
    
    func showProductDetails(product: Product) {
        let vc = MainTabBarVC.createProductDetails(product: product)
        self.present(UINavigationController(rootViewController: vc), animated: true)
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource

extension CatalogueViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = PosterCollectionView()
//            cell.backgroundColor = .green
            cell.startTimer()
            return cell
        case 1:
            let cell = SectionsCatalogueCollectionViewCell()
            cell.presenter = presenter
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 750
        }
        return 150
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
