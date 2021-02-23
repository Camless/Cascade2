//
//  OutgoingRequestsTableViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON


class OutgoingRequestsTableViewController: UITableViewController {
    
    
    @IBOutlet var requestTableView: UITableView!
    var outgoingRequests: [Request] = [Request(title: "Fire alarm system", body: "Is there someone knowledgeable in the fire alarm system who knows its sensitivity?", urgency: "low", senderID: "200", senderOriginLocation: "Kitchen")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        retrieveOwnRequests { (completion, json) in
//            if completion == true {
//                print("Good")
//                DispatchQueue.main.sync {
//                    self.tableView.reloadData()
//                }
//            }
//        }
//
//    }
    
    // MARK: - Table view data source methods

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return outgoingRequests.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Generating cells directly off CoreData objects (title is only thing required for cell)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OutgoingRequestCell", for: indexPath) as! OutgoingRequestTableViewCell
        cell.title.text = outgoingRequests[indexPath.row].title
		cell.time.text = "02-22-2021"
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "outgoingToRequestStatusSegue", sender: self)
    }
    
    
//    func retrieveOwnRequests(completion: @escaping (Bool, JSON) -> ()) {
//        let URL = WebService.getBackendOutgoingRequest()
//        var request = URLRequest(url: URL)
//        let currentUserID = User.returnUserID()
//        let jsonID: [String: String] = ["userID": currentUserID]
//        print("Are we running this?")
//
//        guard let userUpload = try? JSONSerialization.data(withJSONObject: jsonID, options: []) else {
//            completion( false, ["error": "Unable to encode user data to JSON."])
//            return
//        }
//
//        request.httpMethod = "POST"
//
//        let task = URLSession.shared.uploadTask(with: request, from: userUpload) { (data, response, error) in
//            if let error = error {
//                DispatchQueue.main.async {
//                    self.presentAlert(alertTitle: "No Connection", alertText: "No internet connection. Please reconnect.") // Present error to user.
//                }
//                completion( false, ["error": "No internet connection" ])
//                print(error)
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { // Guards against bad HTTP responses.
//                self.presentAlert(alertTitle: "Server Error", alertText: "Unable to connect to the server.")
//                completion( false, [ "error": "Unable to connnect to server" ])
//                return
//            }
//
//            do {
//                let json = try JSON(data: data!)
//                for (_ , Json) in json["data"] {
//                    let title = Json["title"].string!
//                    let body = Json["body"].string!
//                    let urgency = Json["priority"].string!
//                    let fetchedRequest = Request(title: title, body: body, urgency: urgency, senderID: "000000", senderOriginLocation: "")
//                    self.outgoingRequests.append(fetchedRequest)
//                }
//                completion(true, json)
//            } catch {
//                print("Framework busted")
//            }
//
//        }
//
//        task.resume()
//
//    }
    
    
    func presentAlert(alertTitle: String, alertText: String){
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
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Transporting the cell number to the following controller.
//        if segue.identifier == "outgoingToRequestStatusSegue" {
//            let destinationVC = segue.destination as! RequestStatusViewController
//            if let selectedCell = sender as? OutgoingRequestTableViewCell {
//                let indexPath = requestTableView.indexPath(for: selectedCell)
//                let selectedRequest = outgoingRequests[(indexPath!.row)]
//                destinationVC.selectedRequest = selectedRequest
//            }
//        }
//    }
    
}
