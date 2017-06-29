//
//  RSignUpVC.swift
//  ReactiveKitSignUpForm
//
//  Created by Lyupko on 6/29/17.
//  Copyright © 2017 Lyupko. All rights reserved.
//

import UIKit

import ReactiveKit
import Bond

protocol VMViewProtocol {
    func advise()
    func unadvise()
}

class RSignUpVC: UIViewController, VMViewProtocol {
    
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var emailWarningLbl: UILabel!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var passwordWarningLbl: UILabel!
    @IBOutlet var signUpBtn: UIButton!
    
    var service: RSignUpVCService? = RSignUpVCService()
    
    var rBag: DisposeBag {
        return reactive.bag
    }
    
    // MARK: - Lilfecycle
    
    override func viewDidLoad() {
        advise()
        super.viewDidLoad()
    }
    
    deinit {
        unadvise()
    }
    
    // MARK: - VM interface
    
    func advise() {
        guard let service = service else {
            return
        }
        
        signUpBtn.reactive.tap.bind(to: service.signUpOnTapAction).dispose(in: service.rBag)
        emailTF.reactive.text.bind(to: service.email).dispose(in: service.rBag)
        passwordTF.reactive.text.bind(to: service.password).dispose(in: service.rBag)

        service.isEmailWarningHidden.bind(to: emailWarningLbl.reactive.isHidden).dispose(in: rBag)
        service.isPasswordWarningHidden.bind(to: passwordWarningLbl.reactive.isHidden).dispose(in: rBag)
        service.isSignUpEnabled.bind(to: signUpBtn.reactive.isEnabled).dispose(in: rBag)
    }
    
    func unadvise() {
        reactive.bag.dispose()
        service = nil
    }
    
}
