//
//  FilterPresenter.swift
//  Yelpy
//
//  Created by MAC on 12.09.2022.
//

import Foundation

/// ViewProtocol (from Presenter to View)
protocol FilterViewProtocol: AnyObject {
    func makeButtonEnabled(flag: Bool)
}

/// PresenterProtocol (from View to Presenter)
protocol FilterPresenterProtocol {
    init(view: FilterViewProtocol)
    var attributes: [String] { get set }
    var priceFilterAttribute: String { get set }
    
    func checkToMakeButtonEnabled()
    func didApplyButtonTapped()
    
    var completionHandler: (() -> Void)? { get set }
}

/// FilterPresenter
final class FilterPresenter: FilterPresenterProtocol {
    // MARK: - Properties
    weak var view: FilterViewProtocol!
    var attributes = [String]()
    var priceFilterAttribute = "1,2,3,4"
    var completionHandler: (() -> Void)?
    
    // MARK: - Init
    init(view: FilterViewProtocol) {
        self.view = view
    }
    
    
    // MARK: - Methods
    func checkToMakeButtonEnabled() {
        if !attributes.isEmpty || (priceFilterAttribute != "1,2,3,4") {
            view.makeButtonEnabled(flag: true)
        } else {
            view.makeButtonEnabled(flag: false)
        }
    }
    
    func didApplyButtonTapped() {
        completionHandler?()
        let attributes = attributes.joined(separator: ",")
        NotificationCenter.default.post(name: NSNotification.Name("applyFilterAndFetch"), object: ["attributes": attributes, "priceFilterAttribute": priceFilterAttribute])
    }
    
}
