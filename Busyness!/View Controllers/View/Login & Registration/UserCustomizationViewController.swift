//
//  UserCustomizationViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import CoreData

class UserCustomizationViewController: UIViewController {
    
    
    // Current text fields the user can add into
    @IBOutlet weak var Degree: UITextField!
    @IBOutlet weak var Bachelor_University: UITextField!
    @IBOutlet weak var Grad_degree: UITextField!
    @IBOutlet weak var Grad_university: UITextField!
    @IBOutlet weak var Current_job_title: UITextField!
    @IBOutlet weak var years_at_company: UITextField!
    @IBOutlet weak var skills_keywords: UITextField!
    
    var No_Linkin2: [NSManagedObject]?
    var registrationData:[String: String]? // Get the data from the previous screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    
    // Register Function Button
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
//        // TO DO: Send the data to the server
//        insertUserToDatabase() { (completion, dataDict) in
//            if completion == true {
//                DispatchQueue.main.async {
//                    self.performSegue(withIdentifier: "backToLoginSegue", sender: self)
//                }
//            }
//            else{
//                DispatchQueue.main.async {
//                    self.presentAlert(alertTitle: "Invalid Login", alertText: dataDict["error"] as! String)
//                }
//            }
//
//        }
		self.performSegue(withIdentifier: "backToLoginSegue", sender: self)
    }
    
    
    //MARK: User Insertion to Database
    
    
    
    func insertUserToDatabase(completion: @escaping (Bool, [String: Any]) -> ()) {
        
        let URL = WebService.getBackendRegistration()
        var serverRequest = URLRequest(url: URL)
        let newUser = registrationData
        
        guard let newUserUpload = try? JSONEncoder().encode(newUser) else {
            completion ( false, ["error": "Unable to encode user data."] )
            return
        }
        
        serverRequest.httpMethod = "POST"
        
        let task = URLSession.shared.uploadTask(with: serverRequest, from: newUserUpload) { (data, response, error) in
            if let error = error {
                // Since there was an error, let the user know why
                DispatchQueue.main.async {
                    self.presentAlert(alertTitle: "No Connection", alertText: "No internet connection. Please reconnect.")
                    print(error)
                }
                completion( false, ["error": "No internet connection" ] )
                return
            }
            
            // If we dont get a 200 (OK) then just exit
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                self.presentAlert(alertTitle: "Server Error", alertText: "Unable to connect to the server.")
                completion( false, [ "error": "Unable to connnect to server" ] )
                return
            }
            
            
            let dataString = String(data: data!, encoding: .utf8)
            print("Success! Data received: \(dataString)")
            
            // Here we manipulate the data we receive back from the server
            let dataOut = self.convertToDictionary(text: dataString!)
            print(dataOut)
            // Check if there was an error in the data
            let errorExists = (dataOut?["error"] != nil)
            if errorExists {
                completion( false,  [ "error" : dataOut?["error"] ] )
            }
            else {
                let name = self.registrationData!["name"]!
                let password = self.registrationData!["password"]!
                let email = self.registrationData!["email"]!
                let company = self.registrationData!["company"]!
                let companyCode = self.registrationData!["companyCode"]!
                
                User.saveUserToCoreData(newUserName: name, newUserEmail: email, newUserPassword: password, newUserCompany: company, newUserCompanyCode: companyCode, bachelorDegree: self.Degree.text!, bachelorUniversity: self.Bachelor_University.text!, graduateDegree: self.Grad_degree.text!, graduateUniversity: self.Grad_university.text!, currentJobTitle: self.Current_job_title.text!, yearsAtCompany: self.years_at_company.text!, skillKeywords: self.skills_keywords.text!)
                completion( true ,  dataOut! )
            }
        }
        
        task.resume()
    }
    
    
    //MARK: UI Helper Methods
    func presentAlert(alertTitle: String, alertText: String) {
        // A function to create a simple alert for the user
        
        let alert = UIAlertController(title: alertTitle,
                                      message: alertText,
                                      preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "Continue",
                                           style: .default)
        
        alert.addAction(continueAction)
        
        present(alert, animated: true)
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
