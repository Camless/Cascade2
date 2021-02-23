//
//  WebServiceURL.swift
//  Busyness!
//
//  Created by Carlos Morales III on 12/1/18.
//  Copyright © 2018 3 Amigos. All rights reserved.
//

import Foundation

// This is a repository for how we can store all the URLs (if more than one) in one place within the workspace.
public class WebService {
    static let baseBackend: String = "http://cascade-223722.appspot.com"
    
    static let backendLogin: URL = URL(string: baseBackend + "/login/")!
    static let backendNewUsers: URL = URL(string: baseBackend + "/newuser/")!
    
    static let backendIncomingRequest: URL = URL(string: baseBackend + "/loadmyrequests/")!
    static let backendOutgoingRequest: URL = URL(string: baseBackend + "/loadme/")!
    
    static let backendMakeRequest: URL = URL(string: baseBackend + "/makerequest/")!
    static let backendAnswerRequest: URL = URL(string: baseBackend + "/answerrequest/")!
    
    
    static func getBackendLogin() -> URL {
        return backendLogin // Returned directly as URL.
    }
    
    static func getBackendRegistration() -> URL {
        return backendNewUsers
    }
    
    static func getBackendIncomingRequest() -> URL {
        return backendIncomingRequest
    }
    
    static func getBackendOutgoingRequest() -> URL {
        return backendOutgoingRequest
    }
    
    static func getBackendMakeRequest() -> URL {
        return backendMakeRequest
    }
    
    static func getBackendAnswerRequest() -> URL {
        return backendAnswerRequest
    }
}
