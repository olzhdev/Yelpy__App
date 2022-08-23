//
//  FavoritesViewController.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import UIKit

class FavoritesViewController: UIViewController, FavoritesViewProtocol {
    // MARK: - Properties & Layout elements
    private let tableView = UITableView()
    var presenter: FavoritesPresenterProtocol!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    // MARK: - Private methods
    /// VC configuration
    private func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Favorites"
    }
    
    /// TableView configuration
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BusinessesListItemTableViewCell.self, forCellReuseIdentifier: BusinessesListItemTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    
    // MARK: - Protocol methods
    func reloadData() {
        tableView.reloadData()
    }
    
    func deleteRowFromTable(indexPath: Int) {
        let index = IndexPath.init(row: indexPath, section: 0)
        tableView.deleteRows(at: [index], with: .fade)
    }

}

// MARK: - Extensions
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.businessesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusinessesListItemTableViewCell.identifier) as! BusinessesListItemTableViewCell
        let item = presenter.businessesList[indexPath.row]
        
        cell.set(viewModel: .init(model: item))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BusinessesListItemTableViewCell.prefferedHeight
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            presenter.deleteFormDatabase(model: presenter.businessesList[indexPath.row],
                                         indexPath: indexPath.row)
        default: break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let selectedBusinessId = presenter.businessesList[indexPath.row].id else { return }
        
        presenter.didGoToBusinessInfoTapped(businessID: selectedBusinessId)
    }
}
