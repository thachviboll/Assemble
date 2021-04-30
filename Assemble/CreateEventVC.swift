//
//  CreateEventVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit

class CreateEventVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var eventNameInput: UITextField!
    
    @IBOutlet weak var descriptionInput: UITextField!
    
    @IBOutlet weak var locationInput: UITextField!
    
    @IBOutlet weak var dateInput: UITextField!
    
    @IBAction func createEventButton(_ sender: Any) {
        if (eventNameInput.text != "" && dateInput.text != "") {
            performSegue(withIdentifier: "createEventSegue", sender: self)
        }
    }
    
    var eventNameList = [String]()
    var descriptionList = [String]()
    var locationList = [String]()
    var dateList = [String]()
    var friendsList = [String]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "createEventSegue") {
            let vc = segue.destination as! OpenGroupVC
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
