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
    var groupID : String? = nil

    @IBOutlet weak var groupNameTextfield: UITextField!
    @IBOutlet weak var addMemberTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        addMemberTextfield.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func groupFormButton(_ sender: Any) {
        if let groupName = groupNameTextfield.text, let groupCreator = Auth.auth().currentUser?.uid {
//            var ref: DocumentReference? = nil
            let ref = db.collection(K.groupCollection).addDocument(data: [K.Group.name: groupName])
            groupID = ref.documentID
            self.db.collection(K.userCollection).getDocuments { (querySnapshot, error) in
                if let e = error {
                    print("error returning users. \(e)")
                } else {
                    var i = 1
                    var dict = [String: String]()
                    dict["member0"] = groupCreator
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            let user = data[K.username] as? String
                            if self.members.contains(user!) {
                                dict["member" + String(i)] = doc.documentID
                                self.db.collection(K.userCollection).document(doc.documentID).collection(K.userG).document(ref.documentID)
                                i += 1
                            }
                        }
                        self.db.collection(K.groupCollection).document(ref.documentID).collection(K.Group.members).addDocument(data: dict)
                    }
                }
            }
            
//            ref.getDocument { (document, error) in
//                if let document = document, document.exists {
//
//                    var dict = [String: String]()
//                    dict["member0"] = groupCreator
//                    var i = 1
//                    print(self.members)
//                    for name in self.members {
//                        self.db.collection(K.userCollection).getDocuments { (querySnapshot, error) in
//                            if let e = error {
//                                print("error returning users. \(e)")
//                            } else {
//                                if let snapshotDocuments = querySnapshot?.documents {
//                                    for doc in snapshotDocuments {
//                                        let data = doc.data()
//                                        let user = data[K.username] as? String
//                                        if user == name {
//                                            dict["member" + String(i)] = doc.documentID
//                                            print(dict)
//                                        }
//                                    }
//                                }
//                            }
//                        }
//                        print(i)
//                        i += 1
//                    }
//                    print(dict)
//                    self.db.collection(K.groupCollection).document(document.documentID).collection(K.Group.members).addDocument(data: dict)
//                } else {
//                    print("Document does not exist")
//                }
//            }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "createGroupForm") {
            let vc = segue.destination as! OpenGroupVC
            vc.groupID = groupID
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

