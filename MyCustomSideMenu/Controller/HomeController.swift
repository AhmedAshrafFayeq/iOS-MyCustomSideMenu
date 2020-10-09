//
//  HomeController.swift
//  MyCustomSideMenu
//
//  Created by Ahmed Fayek on 10/9/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    var currentSelectedLabel = UILabel()
    var delegate: MenuSideBarDelegate?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
        view.addSubview(currentSelectedLabel)
        NSLayoutConstraint.activate([
            currentSelectedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentSelectedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentSelectedLabel.heightAnchor.constraint(equalToConstant: 180)
        ])
        currentSelectedLabel.translatesAutoresizingMaskIntoConstraints = false

        configureNavigationBar()
    }
    
    // MARK: - Handlers
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
    }
    
    func configureNavigationBar() {
        currentSelectedLabel.textColor                      = .white
        currentSelectedLabel.text                           = ""
        navigationController?.navigationBar.barTintColor    = .darkGray
        navigationController?.navigationBar.barStyle        = .black
        navigationItem.title                                = "Side Menu"
        navigationItem.leftBarButtonItem                    = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_menu_white_3x").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuToggle))
    }
}
