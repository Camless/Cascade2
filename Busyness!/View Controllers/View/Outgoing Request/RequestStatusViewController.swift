//
//  RequestStatusViewController.swift
//  Busyness!
//
//  Created by Carlos Morales III on 11/15/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import UIKit
import CoreData

class RequestStatusViewController: UIViewController {

    @IBOutlet weak var questionTextView: UITextView!
    
    var selectedRequest: Request = Request(title: "Fire alarm system", body: "Is there someone knowledgeable in the fire alarm system who knows its sensitivity?", urgency: "low", senderID: "200", senderOriginLocation: "Kitchen")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTextView.text = selectedRequest.body
    }

}

