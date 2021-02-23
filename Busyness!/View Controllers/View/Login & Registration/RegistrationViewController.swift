//
//  RegistrationViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation


class RegistrationViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var newUserName: UITextField!
    @IBOutlet weak var newUserEmail: UITextField!
    @IBOutlet weak var newUserPassword: UITextField!
    @IBOutlet weak var newUserPasswordConfirmation: UITextField!
    @IBOutlet weak var newUserCompany: UITextField!
    @IBOutlet weak var newUserCompanyCode: UITextField!
    
    // Create Location Manager
    let locationManager = CLLocationManager()
    // Create string to hold location (Austin, TX)
    var location: String? // Core Location Object
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        newUserName.delegate = self
        newUserEmail.delegate = self
        newUserPassword.delegate = self
        newUserPasswordConfirmation.delegate = self
        newUserCompany.delegate = self
        newUserCompanyCode.delegate = self
    
        
        // Ask for Location Permissions
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    // Fetching details via Linkedin
    
    
    @IBAction func fetchDetailsViaLinkedin(_ sender: UIButton) {
        if fieldValidityReturnsTrue() {
            performSegue(withIdentifier: "registrationToLinkedinAPISegue", sender: self)
        }
        else {
            presentAlert(alertTitle: "Incomplete Fields", alertText: "Please fill in all the fields before continuing")
        }
    }
    
    
    // Fetch details Manually
    
    
    @IBAction func fetchDetailsManually(_ sender: UIButton) {
        if fieldValidityReturnsTrue() {
            performSegue(withIdentifier: "registrationToCustomizationSegue", sender: self)
        }
        else {
            presentAlert(alertTitle: "Incomplete Fields", alertText: "Please fill in all the fields before continuing")
        }
    }
    
    
    //MARK: Field Validation
    
    
    
    func fieldValidityReturnsTrue() -> Bool {
        // If any of the fields are empty then the fields are not complete
        return !((newUserName.text!).isEmpty ||
            (newUserEmail.text!).isEmpty ||
            (newUserCompany.text!).isEmpty ||
            (newUserCompanyCode.text!).isEmpty) && passwordMatching()
    }
    
    
    func passwordMatching() -> Bool {
        // This is a function to match the passwords and check if either one is empty
        
        let newPassEmpty = (newUserPassword.text! == "") || (newUserPassword.text!.isEmpty)
        let confPassEmpty = (newUserPasswordConfirmation.text! == "" || newUserPasswordConfirmation.text!.isEmpty)
        let passwordsMatch = (newUserPassword.text! == newUserPasswordConfirmation.text!)
        
        if  newPassEmpty
        {
            presentAlert(alertTitle: "Password", alertText: "Please enter a password")
        }
        else if confPassEmpty
        {
            presentAlert(alertTitle: "Password", alertText: "Please confirm your password")
        }
        else if !passwordsMatch
        {
            presentAlert(alertTitle: "No Matching Passwords", alertText: "Your confirmation password does not match")
        }
        
        return !(newPassEmpty && confPassEmpty) && passwordsMatch
    }
    
    
    func returnTextFieldData() -> [String: String] {
        // Transport the user-submitted details to the next controller, whichever the user picks.
        
        let returnData: [String: String] = ["name":     newUserName.text!,
                                            "email":    newUserEmail.text!,
                                            "password": newUserPassword.text!,
                                            "company":  newUserCompany.text!,
                                            "companyCode": newUserCompanyCode.text!,
                                            "location":  location!]
        return returnData
    }
    
    //MARK: Location Services
    
    
    func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
        // Method below takes in coordinates and gets the city and state
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Method obtains users coordinates and obtains the city and state.
        
        guard  let trueData: CLLocationCoordinate2D = manager.location?.coordinate else {return}
        geocode(latitude:trueData.latitude, longitude: trueData.longitude) { placemark, error in
            guard let placemark = placemark, error == nil else { return }
            self.location = placemark.locality! + "," + placemark.administrativeArea!
        }
    }

    
    
    //MARK: UI Helper Methods
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Have the keyboard move on to the next textfield upon pressing return key.
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            print(nextField.tag)
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    func presentAlert(alertTitle: String, alertText: String){
        // A function to create a simple alert for the user
        
        let alert = UIAlertController(title: alertTitle,
                                      message: alertText,
                                      preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "Continue",
                                           style: .default)
        
        alert.addAction(continueAction)
        
        present(alert, animated: true)
    }
    
    
    
    // MARK: Segue Method to prepare data before sending
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "registrationToCustomizationSegue" {
            let destinationVC = segue.destination as! UserCustomizationViewController
            destinationVC.registrationData = returnTextFieldData()
        }
    }
}
