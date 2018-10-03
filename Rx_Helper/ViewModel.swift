//
//  ViewModel.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import RxSwift

struct ViewModel {
    //MARK: Input
    var emailText = Variable<String>("")
    var passwordText = Variable<String>("")
    
    //MARK: Output
    var isValid: Observable<Bool>!
    
    
    init() {
        setup()
    }
    
    mutating func setup() {
        isValid = Observable.combineLatest(emailText.asObservable(), passwordText.asObservable()) {
            email, password in
            return email.isEmailValid() && password.isPasswordValid()
        }
    }
}

extension String {
    func isEmailValid() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isPasswordValid() -> Bool {
        return self.count > 5
    }
}
