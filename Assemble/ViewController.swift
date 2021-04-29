//
//  ViewController.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBAction func tempTransition(_ sender: Any) {
        performSegue(withIdentifier: "tempSegue", sender: self)
    }
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogInButton(_ sender: Any) {
        // Check credentials
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    self.performSegue(withIdentifier: "logIn", sender: self)
                }
            }
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        performSegue(withIdentifier: "signUp", sender: self)
    }
    

}

@IBDesignable extension UIButton {

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

