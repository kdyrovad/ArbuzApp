//
//  Product.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 20.05.2023.
//

import Foundation

class Product {
    let id: Int
    let name: String
    let price: String
    let image: String
    let category: String
    let char: String
    let isInStock: Bool
    
    init(id: Int, name: String, price: String, image: String, category: String, char: String, isInStock: Bool) {
        self.id = id
        self.name = name
        self.price = price
        self.image = image
        self.category = category
        self.char = char
        self.isInStock = isInStock
    }
}


