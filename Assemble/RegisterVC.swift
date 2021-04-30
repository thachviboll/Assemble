//
//  RegisterVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    let db = Firestore.firestore()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpCompleteButton(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    //Navigate to the ChatViewController
//                    self.db.collection(K.userCollection).addDocument(data: [K.uid: authResult!.user.uid, K.username: username])
                    self.db.collection(K.userCollection).document(authResult!.user.uid).setData([K.username : username])
                    self.performSegue(withIdentifier: "signUpComplete", sender: self)
                }
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
