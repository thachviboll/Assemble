//
//  CreateGroupVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit
import Firebase

class CreateGroupVC: UIViewController, UITextFieldDelegate {
    
    let db = Firestore.firestore()
    var members = [String]()

    @IBOutlet weak var groupNameTextfield: UITextField!
    @IBOutlet weak var addMemberTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addMemberTextfield.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func groupFormButton(_ sender: Any) {
        if let groupName = groupNameTextfield.text, let groupCreator = Auth.auth().currentUser?.email {
            let ref = db.collection(K.groupCollection).addDocument(data: [K.Group.name: groupName])
            ref.getDocument { (doc, error) in
                if let doc = doc, doc.exists {
                    
                    var dict = [String: String]()
                    dict["member0"] = groupCreator
                    var i = 1
                    for name in self.members {
                        dict["member" + String(i)] = name
                        i += 1
                    }
                    self.db.collection(K.groupCollection).document(doc.documentID).collection(K.Group.members).addDocument(data: dict)
                } else {
                    print("Document does not exist")
                }
            }
//            db.collection(K.groupCollection).document(String(ref)).collection(K.Group.members).addDocument(data: [K.Group.members: groupCreator])
            performSegue(withIdentifier: "createGroupForm", sender: self)
        }
    }
    
    @IBAction func addMemberPressed(_ sender: Any) {
        addMemberTextfield.endEditing(true)
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addMemberTextfield.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        members.append(textField.text!)
        addMemberTextfield.text = ""
//        need to check if username exists
        
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

