//
//  GroupsVC.swift
//  Assemble
//
//  Created by Viboll Thach on 3/28/21.
//

import UIKit

class GroupsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createGroupButton(_ sender: Any) {
        performSegue(withIdentifier: "createGroup", sender: self)
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
