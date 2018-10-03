//
//  SigninViewModel.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SigninViewModel {
    
    var model: SigninModel
    private let bag = DisposeBag()
    
    let emailFieldViewModel = EmailFieldViewModel()
    let passwordFieldViewModel = PasswordFieldViewModel()
    
    var isLoading = Variable(false)
    var isSuccess = Variable(false)
    var errorMessage = Variable<String?>("")
    
    init(model: SigninModel) {
        self.model = model
    }
    
    func validForm() -> Bool {
        return  passwordFieldViewModel.validate() && emailFieldViewModel.validate()
    }
    
    func signIn() {
        model.email = emailFieldViewModel.value.value
        model.password = passwordFieldViewModel.value.value
        
        apiProvider.rx.request(.create(name:model.email, job:model.password))
            .`do`(onSubscribe: { [weak self] in
                self?.isLoading.value = true
            })
            .subscribe { event in
            switch event {
            case .success(_):
                self.isLoading.value = false
                self.isSuccess.value = true
            case let .error(error):
                self.isLoading.value = false
                self.errorMessage.value = error.localizedDescription
                self.isSuccess.value = false
            }
        }.disposed(by: bag)
    }
}
