//
//  MainPageViewController.swift
//  Tutoring
//
//  Created by Tutoring SDP on 1/1/19.
//  Copyright © 2019 Tutoring SDP. All rights reserved.
//

import UIKit
import Parse

class MainPageViewController: UIViewController {

    @IBOutlet weak var lblWelcome: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var currentUser = PFUser.current()
        var name = currentUser?["fname"]
        lblWelcome.text = "welcome \(name as! String)"
        

        // Do any additional setup after loading the view.
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
