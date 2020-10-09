//
//  MenuController.swift
//  MyCustomSideMenu
//
//  Created by Ahmed Fayek on 10/9/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

private let reuseIdentifer = "MenuOptionCell"

class MenuController: UIViewController {
    
    // MARK: - Properties
    
    private var tableView: UITableView!
    var delegate: MenuSideBarDelegate?
    private var lineView : UIView!
    private var firstMenuSection : [MenuOption]!
    private var secondMenuSection : [MenuOption]!
    private var thirdMenuSection : [MenuOption]!

    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpView ()
        configureTableView()
    }
    
    // MARK: - Handlers
    
    func setUpView(){
        
        firstMenuSection = [MenuOption]()
        firstMenuSection.append(.myAccounts)
        firstMenuSection.append(.Profile)
        
        secondMenuSection = [MenuOption]()
        secondMenuSection.append(.Notifications)
        secondMenuSection.append(.Settings)
        
        thirdMenuSection = [MenuOption]()
        thirdMenuSection.append(.SubmitComplaint)
        thirdMenuSection.append(.FAQ)
        thirdMenuSection.append(.AboutApp)
        
        lineView = UIView(frame: CGRect(x:0, y: 0, width:5, height:self.view.frame.height))
        lineView?.backgroundColor = UIColor(red: 224/255, green: 74/255, blue: 27/255, alpha: 1.0)
        self.view.addSubview(lineView)
        self.view.backgroundColor = .gray
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MenuOptionCell.self, forCellReuseIdentifier: reuseIdentifer)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.rowHeight = 45
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // tableview constraints
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -(self.view.frame.width * 0.2)-5).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        // tableview raduis
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 25 // Set As you want
        tableView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner]
        tableView.frame = CGRect(x: 0 , y: 0, width: (self.view.frame.width * 0.8)-5, height: self.view.frame.height)
        
        //add tableview header
        let headerView = UIView(frame: CGRect(x:0, y: 0, width:(self.view.frame.width * 0.8)-5, height:50))
        headerView.backgroundColor = .white
        self.tableView.tableHeaderView = headerView
    }
}

extension MenuController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRows = 1
        switch section {
        case 0:
            numberOfRows = firstMenuSection.count
        case 1:
            numberOfRows = secondMenuSection.count
        case 2:
            numberOfRows = thirdMenuSection.count
        default:
            numberOfRows = 1
        }
        
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer, for: indexPath) as! MenuOptionCell
        
        var menuOption:MenuOption!
        
        switch indexPath.section {
        case 0:
            menuOption = MenuOption(rawValue: firstMenuSection![indexPath.row].rawValue)
            
        case 1:
            menuOption = MenuOption(rawValue: secondMenuSection![indexPath.row].rawValue)
            
        case 2:
            menuOption = MenuOption(rawValue: thirdMenuSection![indexPath.row].rawValue)
            
        default:
            break
        }
        cell.descriptionLabel.text = menuOption?.description
        cell.iconImageView.image = menuOption?.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuOption = MenuOption(rawValue: indexPath.row)
        delegate?.handleMenuToggle(forMenuOption: menuOption)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        var footerView : UIView!
        
        switch section {
        case 0 , 1:
            footerView = Bundle.main.loadNibNamed("separatorLine", owner: self, options: nil)?.first as? SeparatorLine
        case 2:
             if let lastFooterView = Bundle.main.loadNibNamed("sideMenuFooter", owner: self, options: nil)?.first as? MenuFooter {
                lastFooterView.callUs.addTarget(self, action: #selector(handleCallUsButton), for: .touchUpInside)
                lastFooterView.logOut.addTarget(self, action: #selector(handleLogOutButton), for: .touchUpInside)
                
                return lastFooterView
            }
            
        default:
            break
        }

        return footerView
    }
    
    @objc func handleCallUsButton() {
        print("callus")
    }
    @objc func handleLogOutButton(){
        print("logOut")
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0 , 1:
            return 1
        case 2 :
            return 240
        default:
            return 1
        }
    }
    
}
