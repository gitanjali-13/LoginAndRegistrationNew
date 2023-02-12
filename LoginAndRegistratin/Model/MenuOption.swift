//
//  MenuOption.swift
//  SideMenuProject
//
//  Created by Admin on 17/01/23.
//
import UIKit

enum MenuOption: Int , CustomStringConvertible {
    
    case note
    case remainder
    case deleted
    case logout
    case setting
    
    var description: String{
        
        switch self {
            
        case .note:
            return "notes"
        case .remainder:
            return "remainder"
        case .deleted:
            return "deleted"
        case .logout:
            return "logout"
        case .setting:
            return "setting"
            
            
        }
        
    }
    
    var image: UIImage {
            
            switch self {
                
            case .note:
                return UIImage(systemName: "note.text") ?? UIImage()
            case .remainder:
                return UIImage(systemName: "envelope.badge") ?? UIImage()
            case .deleted:
                return UIImage(systemName: "trash") ?? UIImage()
            case .logout:
                return UIImage(systemName: "person.badge.key") ?? UIImage()
            case .setting:
                return UIImage(systemName: "wrench.and.screwdriver") ?? UIImage()

                
            }
            
        }
}
