//
//  Validations.swift
//  RxSwiftDemo
//
//  Created by zapbuild on 15/09/21.
//

import Foundation
class Validations{
     func isValidPassword(password: String) -> Bool{
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@!?_]).{5,}$"
        
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPredicate.evaluate(with: password)
    }

     func isValidUserName(username: String) -> Bool{
        
        let usernameRegEx = "[A-Za-z0-9]*"
        
        let usernamePredicate = NSPredicate(format:"SELF MATCHES %@", usernameRegEx)
        return usernamePredicate.evaluate(with: username)
        
    }
}
