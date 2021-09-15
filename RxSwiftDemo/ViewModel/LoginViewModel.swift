//
//  LoginViewModel.swift
//  RxSwiftDemo
//
//  Created by zapbuild on 14/09/21.
//

import Foundation
import RxSwift
import RxCocoa

enum  LoginTextFieldType{
    case username
    case password
}

struct LoginTextFieldError {
    var type:LoginTextFieldType
    var errorString: String
}

class LoginViewModel{
    
    let error: PublishSubject<LoginTextFieldError> = PublishSubject()
    
    let username = BehaviorRelay<String?>(value: "")
    let password = BehaviorRelay<String?>(value: "")
    
    var isLoginButtonEnable: Observable<Bool> {
        //Validate fields
        return Observable.combineLatest(username, password) { name, password in
            
            self.error.onNext(LoginTextFieldError(type: .username, errorString: ""))
            
            self.error.onNext(LoginTextFieldError(type: .password, errorString: ""))
            
            guard name != nil && password != nil else {
                return false
            }
            if !Validations().isValidUserName(username: name!) && !name!.isEmpty{
                
                self.error.onNext(LoginTextFieldError(type: .username, errorString: Constants.AthenticationErrorMessage.incorrectUserName))
                
                if !Validations().isValidPassword(password: password!) && !password!.isEmpty{
                    
                    self.error.onNext(LoginTextFieldError(type: .password, errorString: Constants.AthenticationErrorMessage.incorrectPassword))
                    
                }
                return false
            }else if !Validations().isValidPassword(password: password!) && !password!.isEmpty{
                
                self.error.onNext(LoginTextFieldError(type: .password, errorString: Constants.AthenticationErrorMessage.incorrectPassword))
                return false
            }else if !password!.isEmpty && !name!.isEmpty{
            
                print("Username:- \(self.username.value ?? "")")
                print("Password:- \(self.password.value ?? "")")
                return true
            }
            return false
        }
    }
   
}

