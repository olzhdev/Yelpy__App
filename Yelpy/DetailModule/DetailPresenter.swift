//
//  DetailPresenter.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func failure(error: Error)
    func formLayoutProperties(model: Business)
    func setMapCoordinatesAndAnnotation(longitude: Double, latitude: Double)
    func showAlert(title: String, message: String)
    func showSkeleton(flag: Bool)
}

protocol DetailPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol,
         APICaller: APICallerProtocol,
         persistanceManager: PersistanceManagerProtocol,
         businessID: String)
    
    /// Given business properites
    var model: Business? { get set }
    var businessID: String? { get set }
    var businessURL: String? { get set }
    /// Array of images for photo slider
    var images: [String] { get set }
    
    func fetchData()
    func didFavoriteButtonTapped()
    var completionHandler: (() -> Void)? { get set }
}

class DetailPresenter: DetailPresenterProtocol {
    
    weak var view: DetailViewProtocol!
    var APICaller: APICallerProtocol!
    var persistanceManager: PersistanceManagerProtocol!
    var completionHandler: (() -> Void)?
    
    var model: Business?
    var businessURL: String?
    var images = [String]()
    var businessID: String?
    
    required init(view: DetailViewProtocol,
                  APICaller: APICallerProtocol,
                  persistanceManager: PersistanceManagerProtocol,
                  businessID: String) {
        self.view = view
        self.APICaller = APICaller
        self.persistanceManager = persistanceManager
        self.businessID = businessID
        fetchData()
        self.view.showSkeleton(flag: true)
    }
    
    func fetchData() {
        APICaller.getBusinessDetail(forBusinessID: businessID!) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let business):
                    self.model = business
                    self.images = business.photos.shuffled()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                        self.view.showSkeleton(flag: false)
                    }
                    self.view.formLayoutProperties(model: business)
                    self.view.setMapCoordinatesAndAnnotation(longitude: business.coordinates.longitude, latitude: business.coordinates.latitude)
                    self.businessURL = business.url
                    
                case .failure(let error):
                    self.view.failure(error: error)
                    print(error)
                }
            }
        }
    }
    
    func didFavoriteButtonTapped() {
        guard let model = model else { return }

        persistanceManager.saveBusinessItem(model: model) {[weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(()):
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Favorited"), object: nil)
                self.view.showAlert(title: "Added to watchlist", message: "We've added company to your watchlist 🎉")
                
            case .failure(let error):
                switch error {
                case DatabaseError.alreadySaved:
                    self.view.showAlert(title: "Already added!", message: "You already favorited this company ✌️")
                default: print(error)
                }
            }
        }
    }
    
    
}
