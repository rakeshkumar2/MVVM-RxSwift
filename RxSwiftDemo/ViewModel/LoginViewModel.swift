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
    let isLoginButtonEnable: PublishSubject<Bool> = PublishSubject()
   
    private let disposable = DisposeBag()
   
    func validateFields(usernameString: String, passwordString: String){
        self.isLoginButtonEnable.onNext(false)
        
        error.onNext(LoginTextFieldError(type: .username, errorString: ""))
        
        error.onNext(LoginTextFieldError(type: .password, errorString: ""))
        
        if passwordString.isEmpty && usernameString.isEmpty{
            
            self.isLoginButtonEnable.onNext(false)
            
        }else if !Validations().isValidUserName(username: usernameString) && !usernameString.isEmpty{
            
            error.onNext(LoginTextFieldError(type: .username, errorString: Constants.AthenticationErrorMessage.incorrectUserName))
            
            if !Validations().isValidPassword(password: passwordString) && !passwordString.isEmpty{
                
                error.onNext(LoginTextFieldError(type: .password, errorString: Constants.AthenticationErrorMessage.incorrectPassword))
                
            }
            
        }else if !Validations().isValidPassword(password: passwordString) && !passwordString.isEmpty{
            
            error.onNext(LoginTextFieldError(type: .password, errorString: Constants.AthenticationErrorMessage.incorrectPassword))
            
        }else if !passwordString.isEmpty && !usernameString.isEmpty{
            
            isLoginButtonEnable.onNext(true)
            
        }
      
    }
}

