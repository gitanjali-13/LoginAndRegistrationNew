//
//  DeleteViewController.swift
//  LoginAndRegistration
//
//  Created by Admin on 04/02/23.
//


import UIKit
import Firebase
import FirebaseFirestore

class DeleteViewController: UIViewController  {
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var desclbl: UILabel!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var db = Firestore.firestore()
    
    var isDeleted = false
    
    var note: Note?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        guard let note = note else {return}
        titleTextField.text = note.title
        descriptionTextField.text = note.note
//        isDeleteFunction()
    }
     
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {

        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid else { return }
//////
        if let id = note?.id {
            
//            db.collection("user").document(id).collection("Note").document(id)
            print("check id is present\(id)")
            
            db.collection("user").document(uid).collection("Note").document(id).delete(completion: { error in
                
                if let error = error {
                    
                    print("errpr\(error.localizedDescription)")
                } else {
                    print("notes deleted successsfully.")
                    self.dismiss(animated: true)
                    self.navigationController?.popViewController(animated: true)
                }
            })
    
        }

    }
    
//    func isDeleteFunction() {
//
//        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid else {
//        return
//        }
//        if isDeleted == true {
//            print("note deleted successfully")
////            print("error in deleting note")
//
//        } else {
//            print("error in deleting note")
////            db.collection("user").document(uid).collection("Note").document().delete()
//
//        }
//
//    }
//
  
 
}

    

