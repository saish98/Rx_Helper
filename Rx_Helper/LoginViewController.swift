//
//  LoginViewController.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {

    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    var viewModel: SigninViewModel = SigninViewModel(model: SigninModel(email: "", password: ""))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindUI()
        configureServiceCallBacks()
    }
    

    private func bindUI() {
        
        textFieldEmail.rx.text
            .orEmpty
            .bind(to: viewModel.emailFieldViewModel.value)
            .disposed(by: disposeBag)
        
        textFieldPassword.rx.text
            .orEmpty
            .bind(to: viewModel.passwordFieldViewModel.value)
            .disposed(by: disposeBag)
        
        buttonLogin.rx.tap
            .`do`(onNext:  { [unowned self] in
                self.textFieldEmail.resignFirstResponder()
                self.textFieldPassword.resignFirstResponder()
            }).subscribe(onNext: { [unowned self] in
                if self.viewModel.validForm() {
                    self.viewModel.signIn()
                }
            }).disposed(by: disposeBag)
    }
    
    private func configureServiceCallBacks() {
        
        // loading
        viewModel.isLoading
            .asDriver()
            .drive(loader.rx.isHidden)
            .disposed(by: disposeBag)

       // errors
        viewModel.errorMessage
            .asObservable()
            .bind { errorMessage in
                // Show error
                //                VSToastManager.showMessage(errorMessage)
                if errorMessage != nil {
                    print(errorMessage)
                }
                
            }.disposed(by: disposeBag)

        // success
        viewModel.isSuccess
            .asObservable()
            .filter { $0 }.bind { _ in
                // Show success
                let successMessage = "Login success!"
                //                VSToastManager.showMessage(successMessage)
                print(successMessage)
            }.disposed(by: disposeBag)
    }

}
