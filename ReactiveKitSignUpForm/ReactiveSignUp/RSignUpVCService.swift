//
//  RSignUpVCService.swift
//  ReactiveKitSignUpForm
//
//  Created by Lyupko on 6/29/17.
//  Copyright © 2017 Lyupko. All rights reserved.
//

import Foundation
import ReactiveKit

class RSignUpVCService {
    
    var rBag = DisposeBag()
 
    let signUpOnTapAction = SafePublishSubject<Void>()
    
    let email = Property<String?>(nil)
    let password = Property<String?>(nil)
    
    let isPasswordWarningHidden = Property<Bool>(true)
    let isEmailWarningHidden = Property<Bool>(true)
    let isSignUpEnabled = Property<Bool>(false)
    
    init() {
        signUpOnTapAction.observeNext {
            print("You're all signed up.")
        }.dispose(in: rBag)
        
        combineLatest(email, password).map({ self.isValid(emailAddress: $0) && self.isValid(password: $1) }).bind(to: isSignUpEnabled).dispose(in: rBag)
        
        email.map({ self.isValid(emailAddress: $0) }).bind(to: isEmailWarningHidden).dispose(in: rBag)
        password.map({ self.isValid(password: $0) }).bind(to: isPasswordWarningHidden).dispose(in: rBag)
    }
    
    deinit {
        rBag.dispose()
    }
    
    // MARK: - Private interface 
    
    private func isValid(emailAddress email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        return NSPredicate(format: "SELF MATCHES %@", "\\A[^@]+@[^@]+\\z").evaluate(with: email)
    }
    
    private func isValid(password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        return password.characters.count >= 8
    }
    
}
