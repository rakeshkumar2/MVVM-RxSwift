//
//  UserModel.swift
//  RxSwiftDemo
//
//  Created by zapbuild on 17/09/21.
//

import Foundation
import RxCocoa
import RxSwift

struct UserModel {
    let username = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
}
