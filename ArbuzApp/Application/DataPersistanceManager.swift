//
//  DataPersistenceManager.swift
//  ArbuzApp
//
//  Created by Дильяра Кдырова on 21.05.2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistanceManager{
    
    enum DataBaseError: Error{
        case failedToSave
    }
    
    static let shared = DataPersistanceManager()
    
    func downloadProduct(model: Product, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = ProductElement(context: context)
        item.id = Int64(model.id)
        item.name = model.name
        item.price = model.price
        item.category = model.category
        item.image = model.image
        item.char = model.char
        
        do{
            try context.save()
            completion(.success(()))
        } catch{
            completion(.failure(DataBaseError.failedToSave))
        }
    }
    
    func fetchingProductsFromDB(completion: @escaping (Result<[ProductElement], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<ProductElement>
        request = ProductElement.fetchRequest()
        
        do {
            let products = try context.fetch(request)
            completion(.success(products))
        } catch{
            completion(.failure(DataBaseError.failedToSave))
        }
    }
    
    func deleteTitleWith(model: ProductElement, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DataBaseError.failedToSave))
        }
    }
}
