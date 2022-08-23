//
//  PersistanceManager.swift
//  Yelpy
//
//  Created by MAC
//

import UIKit
import CoreData

enum DatabaseError: Error {
    case failedToSaveData
    case failedToFetchData
    case failedToDeleteData
    case alreadySaved
}

protocol PersistanceManagerProtocol {
    func itemExists(_ businessID: String) -> Bool
    func saveBusinessItem(
        model: Business,
        completion: @escaping (Result<Void, Error>) -> Void)
    func fetchingBusinessesFromDataBase(
        completion: @escaping (Result<[BusinessItemSD], Error>) -> Void)
    func deleteBusinessItem(
        model: BusinessItemSD,
        completion: @escaping (Result<Void, Error>) -> Void)
}

/// Object to manage CoreData manipulations
final class PersistanceManager: PersistanceManagerProtocol {
    
    /// Checks if business already exists in database
    /// - Parameter businessID: Given businessID
    /// - Returns: Bool
    func itemExists(_ businessID: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BusinessItemSD")
        fetchRequest.predicate = NSPredicate(format: "id == %@", businessID)
        return ((try? context.count(for: fetchRequest)) ?? 0) > 0
    }
    
    
    /// Favorites (adds) business item to database
    /// - Parameters:
    ///   - model: Given business's model
    ///   - completion: Callback
    func saveBusinessItem(
        model: Business,
        completion: @escaping (Result<Void, Error>) -> Void)
    {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        if !itemExists(model.id) {
            let item = BusinessItemSD(context: context)
            item.name = model.name
            item.location = model.location.address1 ?? ""
            item.rating = model.stringRating
            item.imageURL = model.imageURL
            item.categories = model.categories.map({$0.title}).joined(separator: ", ")
            item.id = model.id
            item.price = model.price ?? ""
            item.isClosedLabel = model.formattedIsClosed
            
            do {
                  try context.save()
                  completion(.success(()))
              } catch {
                  completion(.failure(DatabaseError.failedToSaveData))
              }
        } else {
            completion(.failure(DatabaseError.alreadySaved))
        }
    }
    
    /// Fetch list of favorites businesses from database
    /// - Parameter completion: Callback
    func fetchingBusinessesFromDataBase(
        completion: @escaping (Result<[BusinessItemSD], Error>) -> Void)
    {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let request: NSFetchRequest<BusinessItemSD>
            request = BusinessItemSD.fetchRequest()
            
            do {
                let businesses = try context.fetch(request)
                completion(.success(businesses))
                
            } catch {
                completion(.failure(DatabaseError.failedToFetchData))
            }
        }
    
    
    /// Removes item from database
    /// - Parameters:
    ///   - model: Model
    ///   - completion: Callback
    func deleteBusinessItem(
        model: BusinessItemSD,
        completion: @escaping (Result<Void, Error>) -> Void)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        
        do {
              try context.save()
              completion(.success(()))
          } catch {
              completion(.failure(DatabaseError.failedToSaveData))
          }
    }

}
