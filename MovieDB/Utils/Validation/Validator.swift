//
//  Validator.swift
//  MovieDB
//
//  Created by MhMuD SalAh on 05/09/2021.
//

import UIKit

let VALID = Validator.shared

struct ValidationRegEx {
    
    static let email = "(^[_A-Za-z0-9-+]{2,}(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]{2,}(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$)"
    static let phone = "^[+]?[0-9.-٩]{7,18}$"
}

class Validator: NSObject {
    
    static var shared = Validator()
    
    func isNotEmpty(_ text: String?) -> Bool {
        return text != nil && text!.trimmingCharacters(in: .whitespaces).count > 0
    }
    
    func isName(_ text: String?) -> Bool {
        return text != nil && text!.trimmingCharacters(in: .whitespaces).count > 2
    }
    
    func isEmail(_ text: String?) -> Bool {
        return validate(text, ValidationRegEx.email)
    }
    
    func isPhone(_ text: String?) -> Bool {
        return validate(text, ValidationRegEx.phone)
    }
    
    func isPassword(_ text: String?) -> Bool {
        return text != nil && text!.trimmingCharacters(in: .whitespaces).count > 5
    }
    
    func validate(_ text: String?, _ regEx: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", regEx)
        return test.evaluate(with: text)
    }
}
