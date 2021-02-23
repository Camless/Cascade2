//
//  ViewController.swift
//  Busyness!
//
//  Created by Christian Gil on 11/12/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//
import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var App_Image: UIImageView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    var userData: [NSManagedObject]? // Core Data object
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.delegate = self
        passTextField.delegate = self
        
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.App_Image.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.userTextField.center.x += self.view.bounds.width
        }, completion: nil)
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
            self.passTextField.center.x += self.view.bounds.width
        }, completion: nil)
        
        User.deletePreviousUsers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // move the inital fields out of view in order to have them slide in
        userTextField.center.x -= view.bounds.width
        passTextField.center.x -= view.bounds.width
        App_Image.center.x -= view.bounds.width
        
        // Delete the text field info if we come to this screen fresh
        
        userTextField.text! = ""
        passTextField.text! = ""
    }
    
    
    // User Registration
    
    
    
    @IBAction func registerNewUser(_ sender: UIButton) {
        performSegue(withIdentifier: "loginToRegistrationSegue", sender: self)
    }
        
    // User Login
    
    @IBAction func loginUser(_ sender: UIButton) {
        
        // If both of the fields have text in them
        if !((userTextField.text!).isEmpty || (passTextField.text!).isEmpty) {
			self.performSegue(withIdentifier: "loginToMainViewSegue", sender: self)
            // Our authentication happens here, send a request to the server and await a response to login the user.
//            authenticateUser(email: userTextField.text!, password: passTextField.text!) { (completion, dataDict) in
//                if completion == true {
//                    //Here is where we store to coreData and for testing purpose we fetch the information
//                    DispatchQueue.main.async {
//                        User.saveLoggingToCoreData(validEmail: self.userTextField.text!, validPassword: self.passTextField.text!, id: dataDict["userID"] as! String)
//                        self.performSegue(withIdentifier: "loginToMainViewSegue", sender: self)
//                    }
//                }
//                else {
//                    DispatchQueue.main.async {
//                        self.presentAlert(alertTitle: "Invalid Login", alertText: "Wrong username and password combination")
//                    }
//                }
//            }
        } else {
            presentAlert(alertTitle: "Invalid Login", alertText: "Please fill in both username and password")
        }
    }
    
    
    //MARK: User Authentication
    
    
//    func authenticateUser(email: String, password: String, completion: @escaping (Bool, [String: Any]) -> ()) {
//
//        let URL = WebService.getBackendLogin()
//        var request = URLRequest(url: URL)
//        let currentUser = LoggingUser(username: email, password: password)
//
//        guard let userUpload = try? JSONEncoder().encode(currentUser) else {
//            completion( false, ["error": "Unable to send user data."] )
//            return
//        }
//
//        request.httpMethod = "POST"
//
//        let task = URLSession.shared.uploadTask(with: request, from: userUpload) { (data, response, error) in
//            if let error = error {
//                // Since there was an error, let the user know why
//                DispatchQueue.main.async {
//                    self.presentAlert(alertTitle: "No Connection", alertText: "No internet connection. Please reconnect.")
//                    print(error)
//                }
//                completion( false, ["error": "No internet connection" ] )
//                return
//            }
//
//            // If we dont get a 200 (OK) then just exit
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                self.presentAlert(alertTitle: "Server Error", alertText: "Unable to connect to the server.")
//                completion( false, [ "error": "Unable to connnect to server" ] )
//                return
//            }
//
//            // Successfully got the data
//            let dataString = String(data: data!, encoding: .utf8)
//
//            let dataOut = self.convertToDictionary(text: dataString!)
//            // Check if there was an error in the data
//            let errorExists = dataOut?["error"] != nil
//            if errorExists {
//                completion( false,  [ "error" : dataOut?["error"] ] )
//            }
//            else {
//                completion( true ,  dataOut! )
//            }
//
//        }
//
//        task.resume()
//    }
    
    
    // UI Helper Methods
    
    
    
    func presentAlert(alertTitle: String, alertText: String){
        let alert = UIAlertController(title: alertTitle,
                                      message: alertText,
                                      preferredStyle: .alert)
        
        let continueAction = UIAlertAction(title: "Continue",
                                           style: .default)
        
        alert.addAction(continueAction)
        
        present(alert, animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
