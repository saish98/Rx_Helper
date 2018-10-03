//
//  EmailFieldViewModel.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import RxSwift

struct EmailFieldViewModel: FieldViewModel {
    
    var title: String = "Email"
    var errorMessage: String = "Email is wrong"
    
    var value: Variable<String> = Variable("")
    var errorValue: Variable<String?> = Variable(nil)
    
    func validate() -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
        guard validateString(value.value, pattern:emailPattern) else {
            errorValue.value = errorMessage
            return false
        }
        errorValue.value = nil
        return true
    }
}
