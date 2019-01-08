//
//  ViewController.swift
//  Tutoring
//
//  Created by Tutoring SDP on 12/31/18.
//  Copyright © 2018 Tutoring SDP. All rights reserved.
//

import UIKit
import Parse



class ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let image1 = UIImage(named: "image11")! as UIImage
        //print("heeel")
       // print(image1.size)
        //print(image1.compressImage()?.size)
        
        
        //var image11 = image1.jpegData(compressionQuality: 1)
        //print(image11?.count)
        
        //var image2 = image1.jpegData(compressionQuality: 0)
        //print(image2?.count)
        PFUser.logOut()
        
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
    
    @IBAction func btnLoginPressed(_ sender: Any) {
        
        let sv = UIViewController.displaySpinner(onView: self.view)
        PFUser.logInWithUsername(inBackground: txtName.text!, password: txtPass.text!) { (user, error) -> Void in
            UIViewController.removeSpinner(spinner: sv)
            
            
            if let loggedInUser = user {
                print("welcome \(PFUser.current()?.username)") //open home page
                
                
        
                
                
                self.performSegue(withIdentifier: "goToMainPage", sender: self)
            }
            else
            {
                if let descrip = error?.localizedDescription {
                    self.displayErrorMessage(message: descrip)
                }
            }
        }
        
        
        

    }
    
}
