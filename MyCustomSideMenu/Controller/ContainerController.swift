//
//  ContainerController.swift
//  MyCustomSideMenu
//
//  Created by Ahmed Fayek on 10/9/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {
    
    // MARK: - Properties
    private var menuController: MenuController!
    private var centerController: UIViewController!
    private var tap: UITapGestureRecognizer!
    let homeController      = HomeController()
    private var isExpanded  = false
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        configureHomeController()
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
       handleMenuToggle(forMenuOption: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    // MARK: - Handlers
    func configureHomeController() {
        homeController.delegate = self
        centerController        = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        if menuController == nil {
            menuController          = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        if shouldExpand {
            // show menu
            self.view.addGestureRecognizer(tap)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)
        } else {
            // hide menu
            self.view.removeGestureRecognizer(tap)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.centerController.view.frame.origin.x = 0
            }) { (_) in
                guard let menuOption = menuOption else { return }
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        animateStatusBar()
    }
    
    func didSelectMenuOption(menuOption: MenuOption) {
        switch menuOption {
        case .myAccounts:
            print("My Accounts")
        case .Profile:
            print("Show profile")
        case .SubmitComplaint:
            print("Show SubmitComplaint")
        case .Notifications:
            print("Show Notifications")
        case .Settings:
            print("Show Settings")
        case .FAQ:
            print("FAQ")
        case .AboutApp:
            print("About App")
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
}

extension ContainerController: MenuSideBarDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded {
            configureMenuController()
        }
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
