//
//  MasterDetailEmployeeModel.swift
//  MasterDetail
//
//  Created by Hussain  on 24/2/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import Cocoa

class MDEmployeeModel: NSObject {
    var firstName : String
    var lastName : String
    var email : String
    var designationType : String
    var projectDescription : String
    
    init(firstName : String, lastName : String, email : String, designationType : String, projectDescription : String){
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.designationType = designationType
        self.projectDescription = projectDescription
    }
}
