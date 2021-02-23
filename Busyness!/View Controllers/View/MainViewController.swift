//
//  MainViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import CoreData
class MainViewController: UIViewController {
    
    @IBOutlet weak var makeRequestButton: UIButton!
    @IBOutlet weak var incomingRequestsButton: UIButton!
    @IBOutlet weak var myRequestsButton: UIButton!
    @IBOutlet weak var logoutBarButton: UIBarButtonItem!
    
    @IBOutlet weak var welcome_label: UILabel!
    var userName = ""
    
    
    // These have to be asynchronous.
    @IBOutlet weak var userCount: UILabel!
    @IBOutlet weak var liveQuestionCount: UILabel!
    @IBOutlet weak var answeredQuestionCount: UILabel!
    @IBOutlet weak var welcomeText: UILabel! // Dependent on the user signed.
    var currentUser: [NSManagedObject]?
    
    
//    func fetch_User(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return}
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "UserEntity")
//        do {
//            currentUser = try managedContext.fetch(fetchRequest) as [NSManagedObject]
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    
    // Handles the logout of the user
    @IBAction func logoutBarButtonPressed(_ sender: Any) {
        // Go back one view conroller
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    
    var delegate: LoginUserDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        fetch_User()
//        userName = extractName(currentUser: currentUser![0])
        welcomeText.text = "Welcome!"
        //for object in currentUser!{
        //print(object.value(forKey: "email"))
        // }
    }
    
//    func extractName(currentUser: NSManagedObject) -> String {
//        let name = currentUser.value(forKey: "email") as? String
//        return name!
//    }
    
    // This hides the back button from the user if they login
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    
    // MARK: - Navigation
    
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
    
}

protocol LoginUserDelegate {
    func userAttemptingLogin()
}
