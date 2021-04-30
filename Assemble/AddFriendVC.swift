//
//  AddFriendVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit

class AddFriendVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    var friendsList = [String]()
    @IBOutlet weak var friendTextLabel: UITextField!
    
    @IBAction func addFriendButton(_ sender: Any) {
        if (friendTextLabel.text != "") {
            performSegue(withIdentifier: "backFromFriend", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "backFromFriend") {
            let vc = segue.destination as! OpenGroupVC
            if (friendTextLabel.text != "") {
                friendsList.append(friendTextLabel.text!)
                vc.friendsList = friendsList
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
