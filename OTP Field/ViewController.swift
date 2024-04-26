//
//  ViewController.swift
//  OTP Field
//
//  Created by Supriyo Dey on 22/04/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, OTPFieldDelegate {
    @IBOutlet weak var txtOtp1: OTPTextField!
    @IBOutlet weak var txtOtp2: OTPTextField!
    @IBOutlet weak var txtOtp3: OTPTextField!
    @IBOutlet weak var txtOtp4: OTPTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtOtp1.delegate = self
        txtOtp2.delegate = self
        txtOtp3.delegate = self
        txtOtp4.delegate = self
        
        txtOtp1.backDelegate = self
        txtOtp2.backDelegate = self
        txtOtp3.backDelegate = self
        txtOtp4.backDelegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case txtOtp1:
            if string.isEmpty {
                txtOtp1.text = string
            } else {
                //restrict to only numbersf
                if let _ = Int(string) {
                    txtOtp1.text = string
                    txtOtp2.becomeFirstResponder()
                }
            }
        case txtOtp2:
            if string.isEmpty {
                txtOtp2.text = string
                txtOtp1.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp2.text = string
                    txtOtp3.becomeFirstResponder()
                }
            }
        case txtOtp3:
            if string.isEmpty {
                txtOtp3.text = string
                txtOtp2.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp3.text = string
                    txtOtp4.becomeFirstResponder()
                }
            }
        case txtOtp4:
            if string.isEmpty {
                txtOtp4.text = string
                txtOtp3.becomeFirstResponder()
            } else {
                //restrict to only numbers
                if let _ = Int(string) {
                    txtOtp4.text = string
                }
            }
        default:
            return false
        }
        return false
    }
    
    
    func backwardDetected(textField: OTPTextField) {
        switch textField{
        case txtOtp1:
            print("txtOtp1 --> no change")
        case txtOtp2:
            txtOtp1.becomeFirstResponder()
        case txtOtp3:
            txtOtp2.becomeFirstResponder()
        case txtOtp4:
            txtOtp3.becomeFirstResponder()
        default:
            print("at default")
        }
    }
    
}

//MARK: - to detect backspace in empty textfield
protocol OTPFieldDelegate: AnyObject {
   func backwardDetected(textField: OTPTextField)
}

class OTPTextField: UITextField {
   weak var backDelegate: OTPFieldDelegate?

   override func deleteBackward() {
     super.deleteBackward()

     self.backDelegate?.backwardDetected(textField: self)
   }
}
