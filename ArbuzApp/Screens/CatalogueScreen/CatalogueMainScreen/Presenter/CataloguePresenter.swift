//
//  CataloguePresenter.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 21.05.2023.
//

import Foundation

protocol CataloguePresenterProtocol {
    var itemsCount: Int { get }
    
    var groupedElements: [String: [Product]] { get }
    
    func loadView()
    func model(for indexPath: IndexPath) -> Product
    func cellTappedAt(_ indexPath: IndexPath)
}

final class CataloguePresenter: CataloguePresenterProtocol {
    
    var groupedElementss: [String: [Product]] = [:]
    
    weak var view: CatalogueViewProtocol?
    
    private var products: [Product] = ProductList.products

    var itemsCount: Int {
        products.count
    }
    
    var groupedElements: [String: [Product]] {
        return groupedElementss
    }
    
    func model(for indexPath: IndexPath) -> Product {
        let continent = groupedElements.keys.sorted()[indexPath.section]
        let countriesForContinent = groupedElements[continent]
        let countryModel = (countriesForContinent?[indexPath.row])!
        return countryModel
    }
    
    func loadView() {
        groupedElementss = Dictionary(grouping: products, by: { $0.category})
    }
    
    func cellTappedAt(_ indexPath: IndexPath){
        print("CellTappedAt CatalogPresenter")
        view?.showProductDetails(product: model(for: indexPath))
    }
    
}


