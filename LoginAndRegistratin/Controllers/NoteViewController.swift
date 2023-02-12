//
//  NoteViewController.swift
//  LoginAndRegistration
//
//  Created by Admin on 27/01/23.
//

//import UIKit
//import Firebase
//import FirebaseAuth
//import FirebaseFirestore
//
//class NoteViewController: UIViewController {
//    
//    let db = Firestore.firestore()
//    
//    let textField: UITextField = {
//        let noteTitle = UITextField()
//        noteTitle.placeholder = "Title"
//        noteTitle.textAlignment = .left
//        noteTitle.translatesAutoresizingMaskIntoConstraints = false
//        return noteTitle
//    }()
//    
//    let noteField: UITextField = {
//        let note = UITextField()
//        note.placeholder = "Description"
//        note.textAlignment = .left
//        note.backgroundColor = UIColor.white
//        note.translatesAutoresizingMaskIntoConstraints = true
//        return note
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("note view")
//        view.addSubview(textField)
//        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        textField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
//        textField.becomeFirstResponder()
//        
//        view.addSubview(noteField)
//        noteField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        noteField.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        noteField.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        noteField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
//        
//        
//        view.backgroundColor = .white
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(handleSaveButton))
//        
//    }
//    
//    @objc func handleSaveButton(){
//        
//        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid else{
//            return
//            
//        }
//        if let inputTitle = textField.text , let inputNote = noteField.text{
//            
//            var ref:DocumentReference? = nil
//            
//            let documentRef = self.db.collection("user").document()
//            let userData:[String : Any] = [
//                "noteTitle": inputTitle,
//                "noteDescription": inputNote,
//                "id": documentRef.documentID]
//            ref = self.db.collection("user").document(uid)
//                .collection("Note").addDocument(data: userData){
//                    (error:Error?) in
//                    if let error = error{
//                        
//                        print("error adding data")
//                        print("\(error.localizedDescription)")
//                        
//                        
//                    }else{
//                        print("Document created: \(ref?.documentID)")
//                        self.dismiss(animated: true, completion: nil)
//                    }
//                }
//        }
//    }
//    
//    
//}
