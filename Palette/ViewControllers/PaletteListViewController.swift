//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Kaden Hendrickson on 6/11/19.
//  Copyright © 2019 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteListViewController: UIViewController {
    
    //Source of Truth
    var photos: [UnsplashPhoto] = []

    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    
    var buttons: [UIButton] {
        return[featuredButton, randomButton, doubleRainbowButton]
    }
    
    override func loadView() {
        super.loadView()
        addSubViews()
        setUpStackView()
        setUpTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        activateButtons()
        selectButton(featuredButton)
        configureTableView()
        //selectButton(featuredButton)

    }
    
    func addSubViews() {
        view.addSubview(featuredButton)
        view.addSubview(randomButton)
        view.addSubview(doubleRainbowButton)
        view.addSubview(buttonStackView)
        view.addSubview(paletteTableView)
    }
    
    func configureTableView() {
        paletteTableView.dataSource = self
        paletteTableView.delegate = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "colorCell")
        paletteTableView.allowsSelection = false
    }
    
    func searchForCategory(_ unsplashRoute: UnsplashRoute) {
        UnsplashService.shared.fetchFromUnsplash(for: unsplashRoute) { (unsplashPhotos) in
            guard let unsplashPhotos = unsplashPhotos else {return}
            self.photos = unsplashPhotos
            DispatchQueue.main.async {
                self.paletteTableView.reloadData()
            }
        }
    }
    
    func activateButtons() {
        buttons.forEach{$0.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)}
    }
    
    func selectButton(_ button: UIButton) {
        buttons.forEach{$0.setTitleColor(.lightGray, for: .normal)}
        button.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
        
    }

    func setUpStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(featuredButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        /*
        buttonStackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
         */
        
        //Same as above, extension on UIView
        buttonStackView.anchor(top: safeArea.topAnchor, bottom: nil, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 16, paddingBottom: 0, paddingLeading: 16, paddingTrailing: -16)
    }
    //MARK: - Views
    let featuredButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("Featured", for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("Random", for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitle("Double Rainbow", for: .normal)
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
        return button
    }()
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    func setUpTableView() {
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 8, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0)
    }
    
    @objc func searchButtonTapped(sender: UIButton) {
        selectButton(sender)
        switch sender {
        case featuredButton:
            searchForCategory(.featured)
        case randomButton:
            searchForCategory(.random)
        case doubleRainbowButton:
            searchForCategory(.doubleRainbow)
        default:
            print("How did you find a fourth button??")
        }
        print("\(sender.titleLabel?.text ?? "Search") button was tapped")
    }
}
