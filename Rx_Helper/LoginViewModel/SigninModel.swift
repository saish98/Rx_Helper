//
//  SigninModel.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation

class SigninModel {
    
    var email:String = ""
    var password:String = ""
    
    convenience init (email: String, password: String) {
        self.init()
        self.email = email
        self.password = password
    }
}
