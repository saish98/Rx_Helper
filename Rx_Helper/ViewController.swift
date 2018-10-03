//
//  ViewController.swift
//  Rx_Helper
//
//  Created by Heady on 03/10/18.
//  Copyright © 2018 Heady. All rights reserved.
//

import UIKit
import RxCocoa
import Action
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!

    @IBOutlet weak var buttonLogin: UIButton!

    @IBOutlet weak var labelMessage: UILabel!
    var viewModel: ViewModel!
    var disposableBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel.init()
        setupRx()
    }

    func setupRx() {
        _ = textFieldEmail.rx.text.map{ $0 ?? "" }.bind(to: viewModel.emailText)
        _ = textFieldPassword.rx.text.map{ $0 ?? "" }.bind(to: viewModel.passwordText)
        _ = viewModel.isValid.bind(to: buttonLogin.rx.isEnabled)
        
        viewModel.isValid.subscribe(onNext: { [unowned self] isValid in
            self.labelMessage.text = isValid ? "Perform Somme Action" : "Action Not Allowd"
        } ).disposed(by: disposableBag)
        
        buttonLogin.rx.tap.bind {
            print("button tap")
        }.disposed(by: disposableBag)
    }
}

