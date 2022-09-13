//
//  ListViewController.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import UIKit

final class ListViewController: UIViewController, ListViewProtocol {
    // MARK: - Properties & Elements
    /// Main tableView and SegmentedControl as filter
    private let tableView = UITableView()
    
    var presenter: ListPresenterProtocol!
    
    let spinner = UIActivityIndicatorView(style: .large)
    var loadingView: UIView = UIView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        configureViewController()
        addFilterButtonToNavBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    
    // MARK: - Private methods
    
    /// ViewController configurations
    private func configureViewController() {
        view.backgroundColor = .secondarySystemBackground
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemOrange
    }
    
    private func addFilterButtonToNavBar() {
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "slider.horizontal.3"), style: .plain, target: self, action: #selector(filterChoseButtonTapped))

        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func filterChoseButtonTapped() {
        presenter.didFilterChooseButtonTapped()
    }
    
    /// Main tableView configurations
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BusinessesListItemTableViewCell.self, forCellReuseIdentifier: BusinessesListItemTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .secondarySystemBackground
    }
    
    
    // MARK: - ViewProtocol methods
    func setNavBarTitle(title: String) {
        self.title = title
    }
    
    func success() {
        tableView.reloadData()
    }
    
    func failure(error: Error) {
        print("ListPresenter failure: \(error)")
    }

    func showingSpinner(flag: Bool) {
        DispatchQueue.main.async {
            if flag {
                self.loadingView = UIView()
                self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
                self.loadingView.center = self.view.center
                self.loadingView.backgroundColor = UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 0.5)
                self.loadingView.alpha = 0.7
                self.loadingView.clipsToBounds = true
                self.loadingView.layer.cornerRadius = 10
                
                self.spinner.frame = CGRect(x: 0.0, y: 0, width: 80.0, height: 80.0)
                self.spinner.center = CGPoint(x: self.loadingView.bounds.size.width / 2, y: self.loadingView.bounds.size.height / 2)
                
                self.loadingView.addSubview(self.spinner)
                self.view.addSubview(self.loadingView)
                self.spinner.startAnimating()
            } else {
                self.spinner.stopAnimating()
                self.loadingView.removeFromSuperview()
            }
        }
    }
    
    func showingSpinnerInFooter(flag: Bool) {
        if flag {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
            
            let spinner = UIActivityIndicatorView()
            spinner.center = footerView.center
            footerView.addSubview(spinner)
            spinner.startAnimating()
            
            tableView.tableFooterView = footerView
        } else {
            tableView.tableFooterView = nil
        }
    }
}

// MARK: - Extensions

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// NumberOfRows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.businessesList.count
    }
    
    /// CellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BusinessesListItemTableViewCell.identifier) as! BusinessesListItemTableViewCell
        
        cell.set(viewModel: .init(model: presenter.businessesList[indexPath.row]))
        
        return cell
    }
    
    /// HeightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BusinessesListItemTableViewCell.prefferedHeight
    }
    
    /// DidSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedBusinessId = presenter.businessesList[indexPath.row].id
        presenter.didGoToBusinessInfoTapped(businessID: selectedBusinessId)
    }
}


extension ListViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            
            showingSpinnerInFooter(flag: true)
            
            if presenter.offset > presenter.remaining {
                presenter.offset = presenter.offset
                presenter.count = presenter.remaining
            }
            
            presenter.fetchDataForPagination(offset: presenter.offset)
            
            presenter.offset += presenter.count
            presenter.remaining -= presenter.count
        }
    }
}

