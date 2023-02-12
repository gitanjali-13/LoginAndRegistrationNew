//
//  Extension+String.swift
//  LoginAndRegistration
//
//  Created by Admin on 05/01/23.
//

import Foundation
import UIKit

extension String {
    
    //Email validation regex
    func validateEmailId() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegex)
    }
    
    // password regex
    func validatePassword(min: Int = 8, max: Int = 10) -> Bool {
        var passRegex = ""
        if min >= max{
             passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(min),}$"
        } else {
            passRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(min),\(max)}$"
            
        }
        return true
        //return applyPredicateOnRegex(regexStr: passRegex)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherSring = NSPredicate(format: "self matches %@", regexStr)
        let isValidateotherString = validateOtherSring.evaluate(with: trimmedString)
        return isValidateotherString
    }
}
