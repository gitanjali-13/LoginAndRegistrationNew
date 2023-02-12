//
//  ContainerController.swift
//  SideMenuProject
//
//  Created by Admin on 15/01/23.
//


import UIKit
import FirebaseAuth

class ContainerViewController: UIViewController {
  
    //MARK : PROPERTIES
    var menuController : MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    
    // MARK : INIT
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHomeController()
        
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
    //-------------  MARK : HANDLER  ---------------------------//
    
    func configureHomeController() {
        
        let homeController = HomeController()
        homeController.delegate = self
        
        //controller is embedded in navigation controller.
        centerController = UINavigationController(rootViewController: homeController)
        
        //ADD SUBVIEW IN VIEW CONTROLLER
        view.addSubview(centerController.view)
        
        addChild(centerController)
        
        //home controller did move to the parent view controller of self which is ContainerController.
        centerController.didMove(toParent: self)
    }
    
    func configureMenuController() {
        
        if menuController == nil {
            //Add our menuController
            menuController = MenuController()
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)
            menuController.delegate = self
//            print("did add menu controller")
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?) {
        
        if shouldExpand{
            //show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
               
                self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80
            }, completion: nil)

        } else {
            //hide menu
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
//            }, completion: nil)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations:  {
                self.centerController.view.frame.origin.x = 0
            }) { _ in
                guard let menuOption = menuOption else{return}
                self.didSelectMenuOption(menuOption: menuOption)
            }
        }
        animateStatusBar()
    }
    //Acton handler
    func didSelectMenuOption(menuOption: MenuOption) {
        
        switch menuOption {
            
        case .note:
            
            print("Show home screen for Note")
            
        case .remainder:
            print("Show Remainder")
            let container = RemainderController()
            let newVC = UINavigationController(rootViewController: container)
            newVC.modalPresentationStyle = .automatic
            present(newVC, animated: true,completion: nil)
                            
        case .deleted:
            print("Show Deleted items")
            let controller = DeleteViewController()
            let navController = UINavigationController(rootViewController: controller)
//            controller.userName = "XYZ"
            navController.modalPresentationStyle = .automatic
            present (navController, animated: true,completion: nil)
            
        case .logout:
            print("Show logout")
            
            do  {
                try FirebaseAuth.Auth.auth().signOut()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginTableViewController") as! LoginTableViewController
                let scene = UIApplication.shared.connectedScenes.first
                if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                    sd.window?.rootViewController = UINavigationController(rootViewController: loginVC)
                }
            }
            catch {
                print("Something went wrong")
            }
            
        case .setting:
            print("show setting view")
            let controller = SettingController()
            let navController = UINavigationController(rootViewController: controller)
            controller.userName = "XYZ"
            navController.modalPresentationStyle = .automatic
            
            present (navController, animated: true,completion: nil)
            
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0,options: .curveEaseInOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
        
    }
}

extension ContainerViewController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        //configureMenuController()
        if !isExpanded{
            configureMenuController()
        }
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}
