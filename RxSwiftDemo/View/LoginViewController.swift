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
            homeVC.user = self.loginViewModel.user
        }
    }
    
    //MARK:- Binding Views
    private func bindView(){
        title = "Login"
        self.userNameTextField.setLeftPaddingPoints(15)
        self.passwordTextField.setLeftPaddingPoints(15)
        
        //User name Text field text binding
        self.userNameTextField.rx.text.asObservable().map{$0 ?? ""}.bind(to: self.loginViewModel.user.value.username).disposed(by: disposeBag)
       
        //password text field text binding
        self.passwordTextField.rx.text.asObservable().map{$0 ?? ""}.bind(to: self.loginViewModel.user.value.password).disposed(by: disposeBag)
        
        //login button binding
        loginViewModel.isLoginButtonEnable.map{$0 ? 1 : 0.4}.bind(to: loginButton.rx.alpha).disposed(by: disposeBag)
        
        loginViewModel.isLoginButtonEnable.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        //Binding error labels
        loginViewModel.isUsernameError.bind(to: userNameErrorLabel.rx.isHidden).disposed(by: disposeBag)
        
        loginViewModel.isPasswordError.bind(to: passwordErrorLabel.rx.isHidden).disposed(by: disposeBag)
        
    }
   
    //MARK:- Button Actions
    @IBAction private func loginButtonClicked(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constants.SegueIDs.home, sender: nil)
    }
    
}

