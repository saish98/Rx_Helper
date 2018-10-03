//
//  PasswordFieldModel.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import RxSwift

struct PasswordFieldViewModel: FieldViewModel, SecureEntryFieldModel {
    
    var title: String = "Email"
    var errorMessage: String = "Email is wrong"
    var isSecureEntry: Bool = true
    
    var value: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable(nil)
    
    func validate() -> Bool {
        // between 8 and 25 caracters
        guard validateSize(value.value, size: (8,25)) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}

protocol SecureEntryFieldModel {
    var isSecureEntry: Bool { get }
}
