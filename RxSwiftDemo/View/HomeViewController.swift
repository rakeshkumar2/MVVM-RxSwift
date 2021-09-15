//
//  HomeViewController.swift
//  RxSwiftDemo
//
//  Created by zapbuild on 14/09/21.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet private weak var helloLabel: UILabel!
    
    //MARK:- Variable
    var username = BehaviorRelay<String?>(value: "")
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello \(username.value ?? "")"
    }
    
}
