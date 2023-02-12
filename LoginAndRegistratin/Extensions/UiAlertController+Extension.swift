//
//  UiAlertController+Extension.swift
//  LoginAndRegistration
//
//  Created by Admin on 05/01/23.
//

import Foundation
import UIKit

extension UIViewController {
    public func openAlert(title: String,
                          message: String,
                          alertStyle: UIAlertController.Style,
                          actionTitle: [String],
                          actionStyle: [UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        
        for(index, indexTitle) in actionTitle.enumerated(){
            
            let action = UIAlertAction(title: indexTitle, style: actionStyle[index],handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}
