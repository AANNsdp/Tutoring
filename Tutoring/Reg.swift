//
//  Reg.swift
//  Tutoring
//
//  Created by Tutoring SDP on 12/31/18.
//  Copyright © 2018 Tutoring SDP. All rights reserved.
//

import UIKit
import Parse

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    func compressImage() -> UIImage? {
        // Reducing file size to a 10th
        var actualHeight: CGFloat = self.size.height
        var actualWidth: CGFloat = self.size.width
        let maxHeight: CGFloat = 1136.0
        let maxWidth: CGFloat = 640.0
        var imgRatio: CGFloat = actualWidth/actualHeight
        let maxRatio: CGFloat = maxWidth/maxHeight
        var compressionQuality: CGFloat = 0.5
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        self.draw(in: rect)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        guard let imageData = img.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
}

class Reg: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
   
    
    @IBOutlet weak var btnSelectImage: UIButton!
    
    @IBOutlet weak var PickerDate: UIDatePicker!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtName2: UITextField!
    @IBOutlet weak var txtName1: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet var btnRegister: UIView!
    @IBOutlet weak var PickerEducation: UIPickerView!
    @IBOutlet weak var ProfileImgView: UIImageView!
    
    
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
        
        ProfileImgView.image =  UIImage(named: "defaultImage")
        

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
        
   
       // let image = ProfileImgView.image?.jpeg(.lowest)
        //let imageFile = PFFileObject(data: image!)
        
        let image = ProfileImgView.image?.compressImage()?.pngData()
        let imageFile = PFFileObject(data: image!)
      NewUser.setObject(imageFile, forKey: "ProfileImage")
        
       
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        NewUser.signUpInBackground { (success, error) in
            UIViewController.removeSpinner(spinner: sv)
            
            if success {
                print("new user created")
                self.loadHomeScreen()
            }
            else {
                
                if let descrip = error?.localizedDescription {
                    self.displayErrorMessage(message: descrip)
                }
            }
            }
    


        
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
    
    
    
    @IBAction func btnSelectImagePressed(_ sender: Any) {
        
        var myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        var selectedImage = info[.originalImage] as? UIImage
        if(selectedImage == nil) {
            selectedImage =  UIImage(named: "defaultImage")
        }
        
        ProfileImgView.image = selectedImage
        
        self.dismiss(animated: true, completion: nil)
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
