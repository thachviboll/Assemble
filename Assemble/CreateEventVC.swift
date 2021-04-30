//
//  CreateEventVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit
import Firebase

class CreateEventVC: UIViewController {
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    @IBOutlet weak var descriptionInput: UITextField!
    
    @IBOutlet weak var locationInput: UITextField!
    
    @IBOutlet weak var dateInput: UITextField!
    
    @IBAction func createEventButton(_ sender: Any) {
        if let eventName = eventNameInput.text, let description = descriptionInput.text, let location = locationInput.text, let date = dateInput.text {
//            db.collection(K.event).addDocument(data: [K.Event.groupID: groupID!, K.Event.date: date, K.Event.des: description, K.Event.loc: location, K.Event.name: eventName])
            db.collection(K.groupCollection).document(groupID!).collection(K.Group.events).addDocument(data: [K.Event.groupID: groupID!, K.Event.date: date, K.Event.des: description, K.Event.loc: location, K.Event.name: eventName])
        }
        if (eventNameInput.text != "" && dateInput.text != "") {
            performSegue(withIdentifier: "createEventSegue", sender: self)
        }
    }
    
    var groupID : String? = nil
    var eventNameList = [String]()
    var descriptionList = [String]()
    var locationList = [String]()
    var dateList = [String]()
    var friendsList = [String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "createEventSegue") {
            let vc = segue.destination as! OpenGroupVC
            vc.groupID = groupID!
            if (eventNameInput.text != nil) {
                eventNameList.append(eventNameInput.text!)
                vc.eventNameList = eventNameList
            }
            if (descriptionInput.text != nil) {
                descriptionList.append(descriptionInput.text!)
                vc.descriptionList = descriptionList
            }
            if (locationInput.text != nil) {
                locationList.append(locationInput.text!)
                vc.locationList = locationList
            }
            if (dateInput.text != nil) {
                dateList.append(dateInput.text!)
                vc.dateList = dateList
            }
            
            vc.friendsList = friendsList
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
