//
//  HomeViewController.swift
//  RxSwiftDemo
//
//  Created by zapbuild on 14/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK:- Outlets
    @IBOutlet private weak var helloLabel: UILabel!
    
    //MARK:- Variable
    var username = ""
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello \(username)"
    }
    
}
