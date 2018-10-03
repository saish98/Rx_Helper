//
//  FieldViewModel.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import RxSwift

protocol FieldViewModel {
    var title: String { get }
    var errorMessage: String { get }
    
    var value: Variable<String> { get set }
    var errorValue: Variable<String?> { get }
    
    func validate() -> Bool
}

extension FieldViewModel {
    func validateSize(_ value: String, size: (min:Int, max:Int)) -> Bool {
        return (size.min...size.max).contains(value.count)
    }
    
    func validateString(_ value: String?, pattern: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: value)
    }
}
