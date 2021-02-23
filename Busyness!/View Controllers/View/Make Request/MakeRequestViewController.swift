//
//  MakeRequestViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.


import UIKit
import CoreData
import CoreLocation

class MakeRequestViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate,CLLocationManagerDelegate  {

    
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var ThirtyMinButton: UIButton!
    @IBOutlet weak var ThreeHourButtonPressed: UIButton!
    @IBOutlet weak var DayButtonPressed: UIButton!
    
    var Location:String! // Core Location Object
    let locationManager = CLLocationManager()
    
    // Urgency will be declared 1-3, 1 meaning thirty minutes or less.
    var urgencyStatus: Int = 0
    var RequestObject: [NSManagedObject]?
    var currentUser: [NSManagedObject]?
    let date = NSDate()
    
    var ThirtyMinButtonOrigionalColor: UIColor!
    var ThreeHourButtonPressedOrigionalColor: UIColor!
    var DayButtonPressedOrigionalColor: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ThirtyMinButtonOrigionalColor = ThirtyMinButton.backgroundColor
        ThreeHourButtonPressedOrigionalColor = ThreeHourButtonPressed.backgroundColor
        DayButtonPressedOrigionalColor = DayButtonPressed.backgroundColor
        
        questionTextView.delegate = self
        titleTextField.delegate = self
        questionTextView.isEditable = true
        questionTextView.layer.borderWidth = 1.0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }

    @IBAction func ThirtyMinButtonPressed(_ sender: UIButton) {
        urgencyStatus = 1
        ThirtyMinButton.backgroundColor = UIColor.gray
        ThreeHourButtonPressed.backgroundColor = ThreeHourButtonPressedOrigionalColor
        DayButtonPressed.backgroundColor = DayButtonPressedOrigionalColor
    }
    
    @IBAction func ThreeHourButtonPressed(_ sender: UIButton) {
        urgencyStatus = 2
        ThreeHourButtonPressed.backgroundColor = UIColor.gray
        ThirtyMinButton.backgroundColor = ThirtyMinButtonOrigionalColor
        DayButtonPressed.backgroundColor = DayButtonPressedOrigionalColor
    }
    
    @IBAction func DayButtonPressed(_ sender: UIButton) {
        urgencyStatus = 3
        DayButtonPressed.backgroundColor = UIColor.gray
        ThirtyMinButton.backgroundColor = ThirtyMinButtonOrigionalColor
        ThreeHourButtonPressed.backgroundColor = ThreeHourButtonPressedOrigionalColor
    }
    
    
    @IBAction func sendRequestPressed(_ sender: UIButton) {
        // Fetch the user and request:
        
//        currentUser = User.fetchUser()
//        let id = User.returnUserID()
//
//        Request.saveRequestToCoreData(question: questionTextView.text!, urgency: urgencyStatus, title: titleTextField.text!, date: date as Date, Location: Location, id: id)
//
//        // Our authentication happens here, send a request to the server and await a response to login the user.
//        getServerResponse() { (completion, dataDict) in
//            if completion == true {
//                DispatchQueue.main.async {
//                    if let navController = self.navigationController {
//                        navController.popViewController(animated: true)
//                    }
//                }
//            }
//            else {
//                DispatchQueue.main.async {
//                    self.presentAlert(alertTitle: "Invalid Login", alertText: "Wrong username and password combination")
//                }
//            }
//        }
		
		self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: Networking
    
//    func getServerResponse(completion: @escaping (Bool, [String: Any]) -> ()) {
//
//        let URL = WebService.getBackendMakeRequest()
//        var request = URLRequest(url: URL)
//
//        let title = titleTextField.text!
//        let body = questionTextView.text!
//        let urgency = String(urgencyStatus)
//        let sender = User.returnUserID()
//        let senderOriginLocation = Location!
//
//        let actualRequest = Request(title: title, body: body, urgency: urgency, senderID: sender, senderOriginLocation: senderOriginLocation)
//
//
//        guard let userUpload = try? JSONEncoder().encode(actualRequest) else {
//            completion( false, ["error": "Unable to encode user data to JSON."] )
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
//                completion( false, ["error": "No internet connection" ] )
//                print(error)
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { // Guards against bad HTTP responses.
//                self.presentAlert(alertTitle: "Server Error", alertText: "Unable to connect to the server.")
//                completion( false, [ "error": "Unable to connnect to server" ] )
//                return
//            }
//
//            let dataString = String(data: data!, encoding: .utf8) // Got data back.
//
//            let dataOut = self.convertToDictionary(text: dataString!) // Check for errors that come from the server.
//            if let errorExists = dataOut?["error"] {
//                print(errorExists)
//                completion( false,  [ "error" : dataOut?["error"] as Any])
//            }
//            else { // Successfully made it without errors.
//                completion( true ,  dataOut! )
//            }
//
//        }
//
//        task.resume()
//    }
    
    
    // Core Location Delegate Methods
    
//    func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
//        // Method below takes in coordinates and gets the city and state
//
//        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        // Method obtains users coordinates and obtains the city and state.
//        guard  let trueData: CLLocationCoordinate2D = manager.location?.coordinate else {return}
//        geocode(latitude:trueData.latitude, longitude: trueData.longitude) { placemark, error in
//            guard let placemark = placemark, error == nil else { return }
//            self.Location = placemark.locality! + "," + placemark.administrativeArea!
//            print(self.Location)
//        }
//    }
    
    //MARK: UI Helper Methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
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
