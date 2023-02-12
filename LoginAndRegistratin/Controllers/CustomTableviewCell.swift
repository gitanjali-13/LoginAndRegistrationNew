//
//  CustomTableviewCell.swift
//  LoginAndRegistration
//
//  Created by Admin on 29/01/23.
//
import UIKit

class CustomeTableViewCell: UITableViewCell {
    
    static let identifier = "cell"
    
    lazy var titlelbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = lbl.font.withSize(30)

        lbl.textAlignment = .left
        return lbl
    }()
    
    lazy var notelbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .left
        return lbl
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        setupUI()
        
    }
    
//    override func accessibilityScroll(_ direction: UIAccessibilityScrollDirection) -> Bool {
//        <#code#>
//    }
    
    func setupUI(){
        
        contentView.addSubview(titlelbl)
        contentView.addSubview(notelbl)
  
        NSLayoutConstraint.activate([
        
            titlelbl.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titlelbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titlelbl.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -20),
            titlelbl.heightAnchor.constraint(equalToConstant: 40),
                //set contraints of notelbl ffrom titlelbl
            notelbl.topAnchor.constraint(equalTo: titlelbl.bottomAnchor, constant: 20),
            
            notelbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            notelbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            notelbl.heightAnchor.constraint(equalToConstant: 40)
        
        ])
        
    
    }
    
    
}
