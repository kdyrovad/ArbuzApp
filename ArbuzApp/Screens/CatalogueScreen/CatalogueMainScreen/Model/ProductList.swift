//
//  ProductList.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 20.05.2023.
//

import Foundation

class ProductList {
    
    static var products: [Product] = [
        Product(id: 1, name: "Молоко соевое Alpro со вкусом ванили", price: "2 690 тг", image: "milk1", category: "Молочные продукты", char: "шт", isInStock: true),
        Product(id: 2, name: "Творог President домашний 5%", price: "477 тг", image: "milk2", category: "Молочные продукты", char: "шт", isInStock: false),
        Product(id: 3, name: "Масло Простоквашино сливочное 82%", price: "1830 тг", image: "milk3", category: "Молочные продукты", char: "шт", isInStock: true),
        Product(id: 4, name: "Сметана President 15%", price: "855 тг", image: "milk4", category: "Молочные продукты", char: "шт", isInStock: true),
        
        Product(id: 5, name: "Авокадо Хасс Колумбия", price: "1 190 тг", image: "fruit1", category: "Фрукты", char: "кг", isInStock: true),
        Product(id: 6, name: "Питахайя желтая", price: "19 540 тг", image: "fruit2", category: "Фрукты", char: "кг", isInStock: true),
        Product(id: 7, name: "Клубника Сольхянг", price: "3 250 тг", image: "fruit3", category: "Фрукты", char: "кг", isInStock: false),
        
        Product(id: 8, name: "Перец ласточка", price: "2 655 тг", image: "v1", category: "Овощи", char: "кг", isInStock: true),
        Product(id: 9, name: "Томаты бриоза оранжевые", price: "2 955 тг", image: "v2", category: "Овощи", char: "кг", isInStock: true),
        Product(id: 10, name: "Перец чили зеленый", price: "1 625 тг", image: "v3", category: "Овощи", char: "кг", isInStock: true)
    ]
}

