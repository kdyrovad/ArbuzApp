//
//  ProductDetailsPresenterProtocol.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 23.05.2023.
//

import Foundation

protocol ProductDetailsPresenterProtocol {
//    func viewDidLoad()
}

class ProductDetailsPresenter: ProductDetailsPresenterProtocol {
    
    private var view: ProductDetailsViewProtocol?
    private var product: Product?
    
    init(view: ProductDetailsViewProtocol, product: Product) {
        self.view = view
        self.product = product
    }
    
//    func viewDidLoad() {
//    }
}

