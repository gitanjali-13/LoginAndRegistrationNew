//
//  UpdateNoteController.swift
//  LoginAndRegistration
//
//  Created by Admin on 02/02/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class UpdateViewController: UIViewController {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    
    @IBOutlet weak var titleTextfield: UITextField!
    
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var descTextField: UITextField!
    
    var db = Firestore.firestore()
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let note = note else {return}
        titleTextfield.text = note.title
        descTextField.text = note.note
        
    }
    
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        
        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid else {return}
        
        if let title = titleTextfield.text , let note = descTextField.text {
            
            var ref = self.db.collection("user").document(uid)
            
            let userData: [String : Any] = ["title" : title,
                                            "note" : note,
                                            "id" : ref.documentID]
            
            guard let noteId = self.note?.id else {return}
            
            self.db.collection("user").document(uid)
                .collection("Note").document(noteId).setData(userData) { error in
                    if error != nil {
                        print("\(error?.localizedDescription)")
                    }else {
                        print("data update successfully")
                        self.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}
