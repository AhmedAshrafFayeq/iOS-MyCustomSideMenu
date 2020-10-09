//
//  MenuOption.swift
//  MyCustomSideMenu
//
//  Created by Ahmed Fayek on 10/9/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case myAccounts
    case Profile
    case SubmitComplaint
    case Notifications
    case Settings
    case FAQ
    case AboutApp
    
    var description: String {
        switch self {
        case .myAccounts: return "My Accounts"
        case .Profile: return "Profile"
        case .Notifications: return "Notifications"
        case .Settings: return "System Settings"
        case .SubmitComplaint: return "Submit Complaint"
        case .FAQ: return "FAQ"
        case .AboutApp: return "About App"
        }
    }
    
    var image: UIImage {
        switch self {
        case .myAccounts: return UIImage(named: "my_accounts") ?? UIImage()
        case .Profile: return UIImage(named: "my_profile") ?? UIImage()
        case .Notifications: return UIImage(named: "notifications") ?? UIImage()
        case .Settings: return UIImage(named: "system_settings") ?? UIImage()
        case .SubmitComplaint: return UIImage(named: "submit_complaint") ?? UIImage()
        case .FAQ: return UIImage(named: "faq") ?? UIImage()
        case .AboutApp: return UIImage(named: "about_app") ?? UIImage()
        
        }
    }
}
