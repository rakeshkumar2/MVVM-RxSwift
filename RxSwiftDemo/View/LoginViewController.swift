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
    @IBOutlet private weak var passwordErrorLabel: UILabel!
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
            homeVC.username = self.loginViewModel.username
        }
    }
    
    //MARK:- Binding Views
    private func bindView(){
        title = "Login"
        self.userNameTextField.setLeftPaddingPoints(15)
        self.passwordTextField.setLeftPaddingPoints(15)
        
        //User name Text field text binding
        self.userNameTextField.rx.text.bind(to: self.loginViewModel.username).disposed(by: disposeBag)
       
        //password text field text binding
        self.passwordTextField.rx.text.bind(to: self.loginViewModel.password).disposed(by: disposeBag)
        
        //Error handling
        loginViewModel.error.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] (error) in
            guard let self = self else{return}
            switch error.type{
            case .username:
                self.userNameErrorLabel.isHidden = error.errorString.isEmpty
                self.userNameErrorLabel.text = error.errorString
            case .password:
                self.passwordErrorLabel.isHidden = error.errorString.isEmpty
                self.passwordErrorLabel.text = error.errorString
            }
        }).disposed(by: disposeBag)
        
        //Login button click Observer
        Observable.of(loginButton.rx.tap).merge().observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] _ in
            guard let self = self else{return}
            self.performSegue(withIdentifier: Constants.SegueIDs.home, sender: nil)
        }).disposed(by: disposeBag)
        
        //Enable disable login button subscriber
        loginViewModel.isLoginButtonEnable.observe(on: MainScheduler.instance).subscribe(onNext: {[weak self] isLoginButtonEnable in
            guard let self = self else{return}
            self.loginButton.isEnabled = isLoginButtonEnable
            self.loginButton.alpha = isLoginButtonEnable ? 1 : 0.6
        }).disposed(by: disposeBag)
    }
   
    
}

