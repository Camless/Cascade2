//
//  IncomingRequestsTableViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import SwiftyJSON

class IncomingRequestsTableViewController: UITableViewController {
    
    @IBOutlet var incomingRequestTableView: UITableView!
    var incomingRequests: [Request] = [Request(title: "To Our Resident Chef", body: "Did you forget to turn the stove off?", urgency: "high", senderID: "1", senderOriginLocation: "HQ")]
    var cellNumber: Int? = 0

    override func viewDidLoad() {
        super.viewDidLoad()
//        retrieveOwnRequests() { (completion, dataDict) in
//            if completion == true {
//                DispatchQueue.main.sync {
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incomingRequests.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        cellNumber = indexPath.row
        performSegue(withIdentifier: "incomingRequestsToResponseSegue", sender: self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomingRequestCell", for: indexPath) as! IncomingRequestTableViewCell
        let incomingRequest = incomingRequests[indexPath.row]
        cell.title.text = incomingRequest.title

        return cell
    }
    
    func transferData() -> [String: String]{
        let title = incomingRequests[cellNumber!].title
        let body = incomingRequests[cellNumber!].body
        let id = incomingRequests[cellNumber!].requestID
        let userID = incomingRequests[cellNumber!].userID
        return ["title": title, "body": body, "requestID": id, "sender": userID]
    }
    
//    func retrieveOwnRequests(completion: @escaping (Bool, JSON) -> ()) {
//        let URL = WebService.getBackendIncomingRequest()
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
//
//            do {
//                let json = try JSON(data: data!)
//                for (_ , Json) in json["data"] {
//                    let title = Json["title"].string!
//                    let body = Json["body"].string!
//
//
//                    let fetchedRequest = Request(title: title, body: body, urgency: "1", senderID: "000000", senderOriginLocation: "")
//                    self.incomingRequests.append(fetchedRequest)
//                }
//                completion(true, json)
//            } catch {
//                print("Framework busted")
//            }
//        }
//        task.resume()
//    }
    
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "incomingRequestsToResponseSegue" {
            let destinationVC = segue.destination as! RequestResponseViewController
            if let selectedCell = sender as? IncomingRequestTableViewCell {
                let indexPath = incomingRequestTableView.indexPath(for: selectedCell)
                let request = incomingRequests[(indexPath!.row)]
                destinationVC.selectedRequest = transferData()
			}
		}
	}
}

// For later implementation.
/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */
