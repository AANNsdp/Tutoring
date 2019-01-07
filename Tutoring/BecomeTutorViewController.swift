//
//  BecomeTutorViewController.swift
//  Tutoring
//
//  Created by Tutoring SDP on 1/1/19.
//  Copyright © 2019 Tutoring SDP. All rights reserved.
//

import UIKit
import Parse



class BecomeTutorViewController: UIViewController{


    
    @IBOutlet weak var ckprimary: CheckBox!
    
    @IBOutlet weak var ckSecondary: CheckBox!
    
    @IBOutlet weak var ckHighSchool: CheckBox!
    
    
    @IBOutlet weak var txtCV: UITextField!
    
    @IBOutlet weak var txtCertificate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func btnUploadCVPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func btnSubmitPressed(_ sender: Any) {
        
        print("\(ckprimary.isChecked)")
        print("\(ckSecondary.isChecked)")
        print("\(ckHighSchool.isChecked)")

        
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
