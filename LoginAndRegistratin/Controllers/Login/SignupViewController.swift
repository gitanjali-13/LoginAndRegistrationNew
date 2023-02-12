//
//  SignupViewController.swift
//  LoginAndRegistration
//
//  Created by Admin on 06/01/23.
//

import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UITableViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtEmailId: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer: )))
        
        //imgProfile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(tapGesture)
        

    }
    @objc func imageTapped(tapGestureRecognizer : UITapGestureRecognizer) {
        openGallery()
    }
    
    @IBAction func btnSignUp(_ sender: UIButton) {
        
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        
        if imgProfile.image?.pngData() != imgSystem?.pngData() {
            // select profile image
            if let email = txtEmailId.text, let password = txtPassword.text, let userName = txtUsername.text, let confirmPassword = txtConfirmPassword.text{
                
                if userName == "" {
                    print("please enter username")
                    
                } else if !email.validateEmailId() {
                    
                    openAlert(title: "title", message: "Enter valid Email", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions: [{_ in }])
                    print("Email is not valid")
                    
                 } else if !password.validatePassword() {
                     openAlert(title: "title", message: "Enter valid password", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions: [{_ in }])
                     print("Password is not valid")
                     
                 } else {
                        if confirmPassword == "" {
                        print("please confirm password")
                        } else {
                            if password == confirmPassword {
//
                                Auth.auth().createUser(withEmail: email, password: password){ result, error in
                                    guard let user = result, error == nil
                                    else{
                                        print("Error\(String(describing: error?.localizedDescription))")
                                        
                                        return
                                    }
                                    
                                    self.navigationController?.popViewController(animated: true)
                                    
                                }
                                //navigation code
                                //self.navigationController?.popViewController(animated: true)
//                                let containerVC = self.storyboard?.instantiateViewController(withIdentifier: "ContainerController") as! ContainerController
//                                self.navigationController?.pushViewController(containerVC, animated: true) 
                            print("navigation code")
                            } else {
                            print("password does not match")
                        }
                    }
                }
            } else {
                print("Please check your details.")
            }
        } else {
            openAlert(title: "title", message: "Please select profile picture", alertStyle: .alert, actionTitle: ["Ok"], actionStyle: [.default], actions: [{_ in }])
    }
}
    
    @IBAction func btnLoginClick(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewsHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        let centeringInset = (tableViewsHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}

extension SignupViewController : UINavigationControllerDelegate ,UIImagePickerControllerDelegate {
        
        func openGallery(){
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
            }
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as?UIImage {
            imgProfile.image = img
        }
        dismiss(animated: true)
    }
    
}
