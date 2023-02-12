//
//  NoteController.swift
//  LoginAndRegistration
//
//  Created by Admin on 27/01/23.
//

import UIKit

import Firebase
import FirebaseFirestore
import FirebaseAuth

class NoteController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!


    @IBOutlet weak var descTextField: UITextField!
    
    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func saveButtontapped(_ sender: UIButton) {
        
        
        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid else {
                    return
            }
        
        if let title = titleTextField.text , let note = descTextField.text {
           
            var ref: DocumentReference? = nil
//            let newDocument = db.collection("wine").document()
//            newDocument.setData(["year" :2017,"type": "abc", "label":"peller", "id":newDocument.documentID])
            
            ref = self.db.collection("user").document(uid)
               .collection("Note").document()
            
            let userData: [String : Any] = [
                    "title" : title,
                    "note" : note,
                    "id" : ref!.documentID]
            
            self.db.collection("user").document(uid)
                .collection("Note").document(ref!.documentID).setData(userData)  { error in
                    if let error = error {
                        print("\(error.localizedDescription)")
                    }else {
                        print("document created\(ref?.documentID)")
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                    
                }
            
            self.navigationController?.popViewController(animated: true)

            print("note added successfully")

        }
    }
}
