//
//  FavoritesPresenter.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import Foundation

protocol FavoritesViewProtocol: AnyObject {
    func deleteRowFromTable(indexPath: Int)
    func reloadData()
}

protocol FavoritesPresenterProtocol {
    init(view: FavoritesViewProtocol, persistanceManager: PersistanceManagerProtocol)
    
    func deleteFormDatabase(model: BusinessItemSD, indexPath: Int)
    func fetchFromDatabase()
    func didFavoritingNotificationReceived()
    func didGoToBusinessInfoTapped(businessID: String)
    var completionHandler: ((String) -> Void)? { get set }
    
    var businessesList: [BusinessItemSD] { get set }
}


final class FavoritesPresenter: FavoritesPresenterProtocol {
    // MARK: - Properties
    weak var view: FavoritesViewProtocol!
    var persistanceManager: PersistanceManagerProtocol!
    var completionHandler: ((String) -> Void)?

    var businessesList: [BusinessItemSD] = []
    
    
    // MARK: - Init
    required init(view: FavoritesViewProtocol, persistanceManager: PersistanceManagerProtocol) {
        self.view = view
        self.persistanceManager = persistanceManager
        fetchFromDatabase()
        didFavoritingNotificationReceived()
    }
    
    
    // MARK: - Methods
    func fetchFromDatabase() {
        persistanceManager.fetchingBusinessesFromDataBase { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let businesses):
                self.businessesList = businesses
                self.view.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteFormDatabase(model: BusinessItemSD,
                            indexPath: Int) {
        persistanceManager.deleteBusinessItem(model: model) { result in
            switch result {
            case .success(()):
                self.businessesList.remove(at: indexPath)
                self.view.deleteRowFromTable(indexPath: indexPath)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didFavoritingNotificationReceived() {
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("Favorited"),
            object: nil,
            queue: nil) { [weak self] _ in
            self?.fetchFromDatabase()
        }
    }
    
    func didGoToBusinessInfoTapped(businessID: String) {
        completionHandler?(businessID)
    }
}
