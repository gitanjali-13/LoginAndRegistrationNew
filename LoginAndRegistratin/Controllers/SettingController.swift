//
//  SettingController.swift
//  SideMenuProject
//
//  Created by Admin on 18/01/23.
//

import UIKit

class SettingController: UIViewController {
    
    //Mark : properties
    var userName: String?
    
    //init 
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = .red
       configureUI()
//        if let userName = userName{
//            print("username is\(userName)")
//        }
        
    }
    // selctor
    
    @objc func handleDismiss() {
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
//    Mark: Helper function
    
    func configureUI() {

        view.backgroundColor = .white

        navigationController?.navigationBar.barTintColor = .darkGray
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.title = "Settings"

       // navigationController?.navigationBar.barStyle = .black

        navigationController?.navigationItem.title = "Settings"
        self.title = "Settings"
        //navigationController?.navigationBar.isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationItem.leftBarButtonItem = UIBarButtonItem(image:  UIImage(systemName: "arrowshape.left")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleDismiss))
    }

}
