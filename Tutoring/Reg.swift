//
//  Reg.swift
//  Tutoring
//
//  Created by Tutoring SDP on 12/31/18.
//  Copyright © 2018 Tutoring SDP. All rights reserved.
//

import UIKit
import Parse
class Reg: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    @IBOutlet weak var PickerDate: UIDatePicker!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName2: UITextField!
    @IBOutlet weak var txtName1: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet var btnRegister: UIView!
    @IBOutlet weak var PickerEducation: UIPickerView!
    
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
        
        self.PickerEducation.delegate = self
        self.PickerEducation.dataSource = self
        
        EducationData = ["Primary School","Secondary School","High School","Bachelor","Master", "PHD"]
        

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func BtnRegClick(_ sender: Any) {
        
        let NewUser = PFUser()
        NewUser.setObject(txtEmail.text!, forKey: "email")
        NewUser.setObject(txtUserName.text!, forKey: "username")
        NewUser.setObject(txtName2.text!, forKey: "lname")
        NewUser.setObject(txtName1.text!, forKey: "fname")
        NewUser.setObject(txtPass.text!, forKey: "password")
        NewUser.setObject(txtPhone.text!, forKey: "phone")
        NewUser.setObject(selectedEducation, forKey: "educationLevel")
        NewUser.setObject(PickerDate.date, forKey: "BirthDate")
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        NewUser.signUpInBackground { (success, error) in
            UIViewController.removeSpinner(spinner: sv)
            
            if success {
                
                self.loadHomeScreen()
            }
            else {
                
                if let descrip = error?.localizedDescription {
                    self.displayErrorMessage(message: descrip)
                }
            }
            }
    

        print("new user created")

        
    }
    
    func displayErrorMessage(message:String) {
        let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
        }
        alertView.addAction(OKAction)
        if let presenter = alertView.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = self.view.bounds
        }
        self.present(alertView, animated: true, completion:nil)
    }
    
    func loadHomeScreen(){
       self.performSegue(withIdentifier: "GoToHomePage", sender: self)
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
