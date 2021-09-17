//
//  LoginViewModel.swift
//  RxSwiftDemo
//
//  Created by zapbuild on 14/09/21.
//

import Foundation
import RxSwift
import RxCocoa


class LoginViewModel{
    
    let isUsernameError = PublishSubject<Bool>()
    let isPasswordError = PublishSubject<Bool>()
   
    let user = BehaviorRelay<UserModel>(value: UserModel())
    
    var isLoginButtonEnable: Observable<Bool> {
        //Validate fields
        return Observable.combineLatest(user.value.username.asObservable().startWith(""), user.value.password.asObservable().startWith("")) { name, password in
            
            self.isUsernameError.onNext(true)
            self.isPasswordError.onNext(true)

            //Check if username is valid or not
            if !Validations().isValidUserName(username: name) && !name.isEmpty{
                
                self.isUsernameError.onNext(false)
                //Check if password is valid or not
                if !Validations().isValidPassword(password: password) && !password.isEmpty{
                    self.isPasswordError.onNext(false)
                }
                return false
                //Check if password is valid or not
            }else if !Validations().isValidPassword(password: password) && !password.isEmpty{
                self.isPasswordError.onNext(false)
            
                return false
            }else if !password.isEmpty && !name.isEmpty{
            
                return true
            }
            return false
        }
    }
   
}

