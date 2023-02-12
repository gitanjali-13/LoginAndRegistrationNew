//
//  HomeController.swift
//  SideMenuProject
//
//  Created by Admin on 15/01/23.

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase
import FirebaseAnalytics

class HomeController: UIViewController , UITableViewDataSource , UITableViewDelegate  {
    
    let db = Firestore.firestore()
    //MARK : PROPERTIES
    
    //create delegate for homecontroller
    var isSearch = false
    
    var delegate: HomeControllerDelegate?
    
    var noteItem = [Note]()
    var searchNote = [Note]()
    
    var tableView : UITableView = {
        
        let table = UITableView()
        table.register(CustomeTableViewCell.self, forCellReuseIdentifier: CustomeTableViewCell.identifier)
        
        return table
    }()
   
    // MARK : INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSearchController()
        configureNavigationBar()
        configureTableviewcontroller()
//        gettingDataFromFirestore()
//        loadSearchItem()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gettingDataFromFirestore()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    //MARK : HANDLER
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle(forMenuOption: nil)
        
    }
    @objc func handleaddButton(){
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let addVC = storyboard.instantiateViewController(withIdentifier: "NoteController") as! NoteController
        navigationController?.pushViewController(addVC, animated: true)
        
    }
    
    func configureNavigationBar() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: resizeImage(image: UIImage(systemName: "line.horizontal.3")! , newWidth: 30), style: .plain, target: self, action: #selector(handleMenuToggle))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: resizeImage(image: UIImage(systemName: "plus.app")!, newWidth: 30), style: .plain, target: self, action: #selector(handleaddButton))

        
    }
    
    func configureTableviewcontroller() {

        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        self.view.addSubview(tableView)
    }
    
    //getting data from firestore
    
    func gettingDataFromFirestore() {
        
        //get all data from firestore
        
        guard let uid = FirebaseAuth.Auth.auth().currentUser?.uid else{return}
        
        let getData = self.db.collection("user").document(uid).collection("Note").order(by: "title")
        getData.addSnapshotListener { querySnapshotListener, error in
            if let error = error {
                print("error")
                print("\(error.localizedDescription)")
            } else {
                
                self.noteItem.removeAll()
                
                for document in querySnapshotListener!.documents {
                    
                    let newObj = document.data()
                    let noteTitle = newObj["title"] as? String ?? ""
                    let noteDesc = newObj["note"] as? String ?? ""
                    let noteId = newObj["id"] as? String ?? ""
                    let newNote = Note(title: noteTitle, note: noteDesc, id: noteId)
                    self.noteItem.append(newNote)
                    
                }
//                print("reload data")
                
            }
            self.tableView.reloadData()
        }
        
        
//        getData.getDocuments { querySnapshot, error in
//            if let error = error {
//                print("error")
//                print("\(error.localizedDescription)")
//            } else {
//
//                self.noteItem.removeAll()
//
//                for document in querySnapshot!.documents {
//
//                    let newObj = document.data()
//                    let noteTitle = newObj["title"] as? String ?? ""
//                    let noteDesc = newObj["note"] as? String ?? ""
//                    let noteId = newObj["id"] as? String ?? ""
//                    let newNote = Note(title: noteTitle, note: noteDesc, id: noteId)
//                    self.noteItem.append(newNote)
//
//                }
//                print("reload data")
//
//            }
//            self.tableView.reloadData()
//        }
    }
        
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    //add search bar to home screen.
    func configureSearchController() {
        
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .default
        searchController.searchBar.placeholder = "Search in notes"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        //searchController?.searchBar.barTintColor = .blue
        searchController.searchBar.barTintColor = .darkGray
        
    }

    func loadSearchItem(){

//        let getData = self.db.collection("user").document(uid).collection("Note").order(by: "title")
           db.collection("user").getDocuments() { (querySnapshot, err) in
               if let err = err {

                   print("Error\(err.localizedDescription)")
               } else {
                   for document in querySnapshot!.documents {

                       let newObj = document.data()
                       let noteTitle = newObj["title"] as? String ?? ""
                       let noteDesc = newObj["note"] as? String ?? ""
                       let noteId = newObj["id"] as? String ?? ""
                       let newNoteList = Note(title: noteTitle , note: noteDesc, id: noteId)
                       self.noteItem.append(newNoteList)
                   }
                   self.tableView.reloadData()
               }
           }
       }
    
    //adding tableview methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return !isSearch ? noteItem.count : searchNote.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomeTableViewCell.identifier, for: indexPath) as! CustomeTableViewCell
        
        let note = !isSearch ? noteItem[indexPath.row] : searchNote[indexPath.row]
        
//      cell.textLabel!.text = noteItem[indexPath.row].title as? String
        cell.titlelbl.text = note.title
        cell.notelbl.text = note.note
//      cell.textLabel?.text = "hello world"
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("didselect row\(indexPath.row)")
        let note = noteItem[indexPath.row]
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let alertController = UIAlertController(title:"Note" , message: "choose action", preferredStyle: .alert)
        let updateAction = UIAlertAction(title: "update", style: .default) {(_) in
            
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let updateVC = storyboard.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
            //        let note = noteItem[indexPath.row]
                    updateVC.note = note
            
            self.navigationController?.pushViewController(updateVC, animated: true)
            
        }
        
        let deleteAction = UIAlertAction(title: "delete", style: .default) {(_) in
            
            
                    let deleteVC = storyboard.instantiateViewController(withIdentifier: "DeleteViewController") as! DeleteViewController
                    deleteVC.note = note
            
            self.navigationController?.pushViewController(deleteVC, animated: true)
            
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
//        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        let updateVC = storyboard.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
//       let note = noteItem[indexPath.row]
//        updateVC.note = note
//
//        navigationController?.pushViewController(updateVC, animated: true)

    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
        
    }
}

extension HomeController: UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {

//        guard let filter = searchController.searchBar.text , !filter.isEmpty else {
//                isSearch = false
//                return
//            }
//            isSearch = true
//            searchNote = noteItem.filter{_ in title!.lowercased().contains(filter.lowercased())}
        }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isSearch = !searchText.isEmpty
           
//           print("printing character \(searchText)")
        
           if searchBar.text?.isEmpty == true {
               
//             loadSearchItem()

               DispatchQueue.main.async {
                   
                   searchBar.resignFirstResponder()
                   
               }
               
           } else {
               
               searchNote = noteItem.filter { note in
                   note.title!.lowercased().contains(searchText.lowercased()) || note.note!.lowercased().contains(searchText.lowercased())
                   
               }
            }
        tableView.reloadData()
       }
}


