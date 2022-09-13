//
//  FilterViewController.swift
//  Yelpy
//
//  Created by MAC on 12.09.2022.
//

import UIKit
import SnapKit

final class FilterViewController: UIViewController, FilterViewProtocol {

    
    // MARK: - Layout elements & Properties
    
    private let hotAndNewLabel = UILabel()
    private let hotAndNewSwitch = UISwitch()
    private let reservationLabel = UILabel()
    private let reservationSwitch = UISwitch()
    private let openToAllLabel = UILabel()
    private let openToAllSwitch = UISwitch()
    private let priceLabel = UILabel()
    private let priceSegmentedControl = UISegmentedControl(items: ["$", "$$", "$$$", "$$$$", "All"])
    private let applyButton = UIButton()
    
    var presenter: FilterPresenterProtocol!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
        constraint()
        addTargetsToElements()
    }
    
    // MARK: - ViewProtocol methods
    
    func makeButtonEnabled(flag: Bool) {
        if flag {
            applyButton.isEnabled = true
            applyButton.alpha = 1
        } else {
            applyButton.isEnabled = false
            applyButton.alpha = 0.5
        }
    }
    
    
    // MARK: - Private methods
    
    private func addTargetsToElements() {
        hotAndNewSwitch.addTarget(self, action: #selector(hotAndNewSwitchDidChanged(_:)), for: .valueChanged)
        reservationSwitch.addTarget(self, action: #selector(reservationSwitchDidChanged), for: .valueChanged)
        openToAllSwitch.addTarget(self, action: #selector(openToAllSwitchDidChanged), for: .valueChanged)
        priceSegmentedControl.addTarget(self, action: #selector(priceSegmentedControlDidChanged), for: .valueChanged)
        applyButton.addTarget(self, action: #selector(applyButtonDidTapped), for: .touchUpInside)
    }
    
    @objc private func applyButtonDidTapped() {
        presenter.didApplyButtonTapped()
    }
    
    @objc private func hotAndNewSwitchDidChanged(_ uiSwitch: UISwitch) {
        if uiSwitch.isOn {
            presenter.attributes.append("hot_and_new")
        } else {
            let i = presenter.attributes.firstIndex(of: "hot_and_new")!
            presenter.attributes.remove(at: i)
        }
        presenter.checkToMakeButtonEnabled()
    }
    
    @objc private func reservationSwitchDidChanged(_ uiSwitch: UISwitch) {
        if uiSwitch.isOn {
            presenter.attributes.append("reservation")
        } else {
            let i = presenter.attributes.firstIndex(of: "reservation")!
            presenter.attributes.remove(at: i)
        }
        presenter.checkToMakeButtonEnabled()

    }
    
    @objc private func openToAllSwitchDidChanged(_ uiSwitch: UISwitch) {
        if uiSwitch.isOn {
            presenter.attributes.append("open_to_all")
        } else {
            let i = presenter.attributes.firstIndex(of: "open_to_all")!
            presenter.attributes.remove(at: i)
        }
        presenter.checkToMakeButtonEnabled()

    }
    
    
    @objc private func priceSegmentedControlDidChanged(_ segmentedControl: UISegmentedControl) {
        var priceFilter = ""
        
        switch segmentedControl.selectedSegmentIndex {
        case 0: priceFilter = "1"
        case 1: priceFilter = "2"
        case 2: priceFilter = "3"
        case 3: priceFilter = "4"
        case 4: priceFilter = "1,2,3,4"
        default: priceFilter = "1,2,3,4"
        }
        presenter.priceFilterAttribute = priceFilter
        presenter.checkToMakeButtonEnabled()
    }
    
    
    private func configureUI() {
        view.addSubviews(hotAndNewLabel, hotAndNewSwitch, reservationLabel, reservationSwitch, openToAllLabel, openToAllSwitch, priceLabel, priceSegmentedControl, applyButton)
        
        hotAndNewLabel.text = "Hot & New"
        hotAndNewLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        reservationLabel.text = "Reservation Available"
        reservationLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        
        openToAllLabel.text = "Open To All"
        openToAllLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        priceLabel.text = "Price Category"
        priceLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        applyButton.setTitle("Apply", for: .normal)
        applyButton.backgroundColor = .systemOrange
        applyButton.alpha = 0.5
        applyButton.layer.cornerRadius = 15
        applyButton.layer.masksToBounds = true
        applyButton.isEnabled = false
        
        priceSegmentedControl.selectedSegmentIndex = 4
    }

    private func constraint() {
        let padding = 30
        
        hotAndNewLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(padding)
            make.trailing.equalTo(hotAndNewSwitch.snp.leading).inset(-5)
        }
        hotAndNewSwitch.snp.makeConstraints { make in
            make.top.equalTo(hotAndNewLabel)
            make.trailing.equalToSuperview().inset(padding)
        }
        
        reservationLabel.snp.makeConstraints { make in
            make.leading.equalTo(hotAndNewLabel.snp.leading)
            make.top.equalTo(hotAndNewLabel.snp.bottom).inset(-padding)
        }
        reservationSwitch.snp.makeConstraints { make in
            make.top.equalTo(reservationLabel)
            make.trailing.equalToSuperview().inset(padding)
        }
        
        openToAllLabel.snp.makeConstraints { make in
            make.leading.equalTo(hotAndNewLabel.snp.leading)
            make.top.equalTo(reservationLabel.snp.bottom).inset(-padding)
        }
        openToAllSwitch.snp.makeConstraints { make in
            make.top.equalTo(openToAllLabel)
            make.trailing.equalToSuperview().inset(padding)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(hotAndNewLabel.snp.leading)
            make.top.equalTo(openToAllLabel.snp.bottom).inset(-padding)
        }
        priceSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).inset(-10)
            make.leading.equalTo(priceLabel.snp.leading)
            make.trailing.equalToSuperview().inset(padding)
        }
        
        applyButton.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(padding)
        }
    }

}
