//
//  LoginTableViewController.swift
//  LoginAndRegistratin
//
//  Created by Admin on 04/01/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn
import FBSDKLoginKit

class LoginTableViewController: UITableViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var buttonFacebook: FBLoginButton!
    
    
    @IBOutlet weak var googleLogin: UIButton!
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let token = AccessToken.current,
                !token.isExpired {
                // User is logged in, do work such as go to next view controller.
        } else {
            buttonFacebook.permissions = ["public_profile", "email"]
            buttonFacebook.delegate = self
        }
    }
    
    fileprivate func validationForEmailPassword() {
        
        if let email = txtEmail.text, let password = txtPassword.text {
            if !email.validateEmailId() {
                openAlert(title: "Alert", message: "Email address not found", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions:  [{  _ in
                    print("Ok clicked")
                }])
            } else if !password.validatePassword(){
                openAlert(title: "Alert", message: "Enter valid password", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions:  [{  _ in
                    print("Ok clicked")
                }])
            } else {
                
                
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if error != nil {
                        print("something went wrong")
                        return
                    }
                    
                    let saveData: [String: Any] = ["email": email as Any]
                    self.db.collection("user").addDocument(data: saveData)
                  
                    DispatchQueue.main.async {
                        let containerController = ContainerViewController()
                        let nav = UINavigationController(rootViewController: containerController)
//                        self.present(nav, animated: true)
                        let scene = UIApplication.shared.connectedScenes.first
                        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
        //                    sd.blah()
                            sd.window?.rootViewController = nav
                            
                        }
                    }
                    print("another screen page")
                }
            }
            
        }else {
            openAlert(title: "Alert", message: "Please enter details.", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions:  [{  _ in
                print("Ok clicked") }])
        }
    }
    
    @IBAction func btnLoginClick(_ sender: UIButton) {
        validationForEmailPassword()
    }
    @IBAction func btnSignupClick(_ sender: UIButton) {
        if let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController {
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
    
    
    
    //add googlebtn
    
    @IBAction func googleLoginbtn(_ sender: UIButton) {
        let signInConfig = GIDConfiguration(clientID: "400897756021-tg5a8c5l01ms46bfo0nnhormt6ou3ic9.apps.googleusercontent.com")
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else{return}
            
            let email = signInResult?.user.profile?.email
            
            print("Google sign in successfullyy")
//            let authentication = signInResult?.user.authentication
            guard let accessToken = signInResult?.user.accessToken,
                  let idToken = signInResult?.user.idToken
            else{return}
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            Auth.auth().signIn(with: credential ) { authResult , error in
                if let error = error {
                    print("\(error)")
                }else {
                
//                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "ContainerController")
//                    let container = ContainerController()
//                    let navigation = UINavigationController(rootViewController: homeVC)
//                    present(navigation, animated: true)
                    
                    print("navigate to successfully google login")
                }
                let dataSave : [String: Any] = ["email": email as Any]
                self.db.collection("Note").addDocument(data: dataSave)
            }
        }
    }

}

extension LoginTableViewController{
//        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//            return UIScreen.main.bounds.height
//        }
//    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewsHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        let centeringInset = (tableViewsHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
}

extension LoginTableViewController : LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: nil, version: nil, httpMethod: .get)
        
        request.start{(connection, result , error) in
            print("\(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
    
    
}
