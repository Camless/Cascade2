//
//  RequestResponseViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit

class RequestResponseViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleSectionLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionSectionLabel: UITextView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerSectionLabel: UITextView!
    
    @IBOutlet weak var reccomendButton: UIButton!
    @IBOutlet weak var idkButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var selectedRequest: [String: String]?
    
    var knows: Bool = true
    var answer: String = ""
    var reference: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionSectionLabel.layer.borderWidth = 1.0
        titleSectionLabel.layer.borderWidth = 1.0
        answerSectionLabel.layer.borderWidth = 1.0

    }
    // What happens right as the view is about to load
    override func viewWillAppear(_ animated: Bool) {
//        titleSectionLabel.text! = selectedRequest!["title"]!
//        questionSectionLabel.text! = selectedRequest!["body"]!
		questionSectionLabel.text! = "Did you forget to turn off the stove?"
		titleSectionLabel.text! = "To Our Resident Chef"
    }
    
    @IBAction func recommendButtonPressed(_ sender: UIButton) {
        // Let the recipient tell the system who to recommend, essentially making this a special case of "dunno". Relay this person to the server (and thus system)
//        knows = false
//        if let navController = self.navigationController {
//            navController.popViewController(animated: true)
//        }
		
		self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func idkButtonPressed(_ sender: UIButton) {
        // Send a request to the server to let the system recommend someone else. Update the status of the source's outgoing request. Immediately dismiss the view.
        
        // Go back one view conroller
//        knows = false
//        sendRequestToServer { (completion, json) in
//            if completion == true {
//                DispatchQueue.main.sync {
//                    if let navController = self.navigationController {
//                        navController.popViewController(animated: true)
//                    }
//                }
//            } else {
//                print("Error sending request")
//            }
//        }
		self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        // Send the information the recipient types back to the source (i.e. the asker). Relay to the server that this question has been "closed", and update both the recipient's incoming request to mark it as "answered" as well as the source's outgoing requests as "answered" as well as its status.
        
//        sendRequestToServer { (completion, json) in
//            if completion == true {
//                if let navController = self.navigationController {
//                    navController.popViewController(animated: true)
//                }
//            } else {
//                print("Error sending request")
//            }
//        }
//    }
//
//    func sendRequestToServer(completion: @escaping (Bool, [String: Any]) -> ()) {
//        let URL = WebService.getBackendAnswerRequest()
//        var serverRequest = URLRequest(url: URL)
//
//        var answer = self.answerSectionLabel.text!
//        if answer == nil {
//            answer = ""
//        }
//
//
//        let requestPackage = ["senderID": User.returnUserID(), "recipientID": selectedRequest!["userID"], "doesKnow": String(knows), "reference": "", "answer": answer, "requestID": selectedRequest!["requestID"]]
//
//        guard let newRequestPackage =  try? JSONEncoder().encode(requestPackage) else {
//            completion(false, ["error": "Unable to encode response."])
//            return
//        }
//
//        serverRequest.httpMethod = "POST"
//
//        let task = URLSession.shared.uploadTask(with: serverRequest, from: newRequestPackage) { (data, response, error) in
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
//
//            let dataString = String(data: data!, encoding: .utf8)
//            print("Success! Data received: \(dataString)")
//
//            // Here we manipulate the data we receive back from the server
//            let dataOut = self.convertToDictionary(text: dataString!)
//            print(dataOut)
//            // Check if there was an error in the data
//            if let errorExists = dataOut?["error"] {
//                completion(false, ["error": dataOut?["error"]])
//            }
//        }
		
		self.navigationController?.popViewController(animated: true)
        
    }
    
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
