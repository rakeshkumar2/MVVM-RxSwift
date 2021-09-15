//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by zapbuild on 14/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet private weak var userNameTextField: UITextField!
   
    
    //MARK:- Variables
    private var loginViewModel = LoginViewModel()
    
    //MARK:- Constants
    private let disposeBag = DisposeBag()
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let homeVC = segue.destination as? HomeViewController{
            homeVC.username = userNameTextField.text!
        }
    }
    
    //MARK:- Binding Views
    private func bindView(){
        title = "Login"
        self.userNameTextField.setLeftPaddingPoints(15)
        self.passwordTextField.setLeftPaddingPoints(15)
        //Handler Errors
        loginViewModel.error.observe(on: MainScheduler.instance).subscribe(onNext: { (error) in
            switch error.type{
            case .username:
                self.userNameErrorLabel.isHidden = error.errorString.isEmpty
                self.userNameErrorLabel.text = error.errorString
            case .password:
                self.passwordErrorLabel.isHidden = error.errorString.isEmpty
                self.passwordErrorLabel.text = error.errorString
            }
        }).disposed(by: disposeBag)
        
        //Login button click
        Observable.of(loginButton.rx.tap).merge().observe(on: MainScheduler.instance).subscribe(onNext: {
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        }).disposed(by: disposeBag)
        
        //User name Text field text change event
        Observable.of(userNameTextField.rx.controlEvent(.editingChanged)).merge().subscribe(onNext:{ text in
            self.loginViewModel.validateFields(usernameString: self.userNameTextField.text!, passwordString: self.passwordTextField.text!)
        }).disposed(by: disposeBag)
        
        //password text field text change event
        Observable.of(passwordTextField.rx.controlEvent(.editingChanged)).merge().subscribe(onNext:{
            self.loginViewModel.validateFields(usernameString: self.userNameTextField.text!, passwordString: self.passwordTextField.text!)
        }).disposed(by: disposeBag)
        
        //Enable disable login button subscriber
        loginViewModel.isLoginButtonEnable.subscribe(onNext: {isLoginButtonEnable in
            print(isLoginButtonEnable)
            self.loginButton.isEnabled = isLoginButtonEnable
            self.loginButton.alpha = isLoginButtonEnable ? 1 : 0.6
        }).disposed(by: disposeBag)
    }
   
    
}

