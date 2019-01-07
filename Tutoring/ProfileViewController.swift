//
//  ProfileViewController.swift
//  Tutoring
//
//  Created by Tutoring SDP on 1/7/19.
//  Copyright © 2019 Tutoring SDP. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var txtUserName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    
    
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var PickerEducation: UIPickerView!
    
    @IBOutlet weak var pickerDate: UIDatePicker!
    
    @IBOutlet weak var txtEducation: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    
    
    var selectedEducation : String = "Primary School"
    
    //fill education picker
    var EducationData : [String] = [String]()
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return EducationData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return EducationData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedEducation = EducationData[row]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
        btnSave.isHidden = true
        PickerEducation.isHidden = true
        pickerDate.isHidden = true

        self.PickerEducation.delegate = self
        self.PickerEducation.dataSource = self
        EducationData = ["Primary School","Secondary School","High School","Bachelor","Master", "PHD"]
    

        // Do any additional setup after loading the view.
    }
    
    func fillData()
    {
        var user = PFUser.current()
        var userName =  user?["username"]

        var email =  user?["email"]
        var name1 =  user?["fname"]
        var name2 =  user?["lname"]
        var pass =  user?["password"]
        var dateOfBirth =  user?["BirthDate"]
        var Education =  user?["educationLevel"]
        var phone =  user?["phone"]
        
        txtEmail.text = email as! String
        txtLastName.text = name2 as! String
        txtFirstName.text = name1 as! String
        txtPhone.text = phone as! String
        txtEducation.text = Education as! String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: dateOfBirth as! Date)
        let yourDate = formatter.date(from: myString)
        
        formatter.dateFormat = "dd-MM-yyyy"
        
        let mystringfd = formatter.string(from: yourDate!)
        
        
        txtDate.text = mystringfd as! String
        txtUserName.text = userName as! String

        
    }
    
    @IBAction func btnEditPressed(_ sender: Any) {
        
        txtFirstName.isEnabled = true
        txtLastName.isEnabled = true
        txtPhone.isEnabled = true
        txtEmail.isEnabled = true
        btnSave.isHidden = false
        pickerDate.isHidden = false
        PickerEducation.isHidden = false

    }
    
    
    @IBAction func btnSavePressed(_ sender: Any) {
        
        var user = PFUser.current()
        user?.setValue(txtFirstName.text as! String, forKey: "fname")
        
        do {
            try user?.save()
            
        }
        catch {}
        
        
        
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
