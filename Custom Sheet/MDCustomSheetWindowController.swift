//
//  MasterDetailCustomSheetWindowController.swift
//  MasterDetail
//
//  Created by Hussain  on 27/2/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import Cocoa

protocol MDCustomSheetDataSource{
    func updateMasterDetailSourceList(model : MDEmployeeModel) -> Void
}

class MDCustomSheetWindowController: NSWindowController {
    var titleMessage : String!
    dynamic var firstName : String = kEmpty
    dynamic var lastName : String = kEmpty
    dynamic var email : String = kEmpty
    dynamic var projectDescription : String = kEmpty
    dynamic var isButtonEnable : Bool = false
    dynamic var flag : Bool = false
    var dataSource : MDCustomSheetDataSource?

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func clickedOnOKButton(sender: AnyObject){
        let masterDetailEmployeeModel = (flag == true) ? MDEmployeeModel(firstName: self.firstName, lastName: self.lastName, email: self.email, designationType : kDesigner,projectDescription: "\(self.firstName)  \(projectDescription)") : MDEmployeeModel(firstName: self.firstName, lastName: self.lastName, email: self.email, designationType : kDeveloper, projectDescription: "\(self.firstName) \(projectDescription)")
        self.dataSource?.updateMasterDetailSourceList(masterDetailEmployeeModel)
        self.window?.orderOut(sender)
        clearValueOnUI()
    }
    
    @IBAction func clickedOnDismissButton(sender: AnyObject){
        self.window?.orderOut(sender)
        clearValueOnUI()
    }
    
    override func controlTextDidChange(obj: NSNotification) {
        if (self.firstName.characters.count > 0 && self.lastName.characters.count > 0 && self.email.characters.count > 0 && self.projectDescription.characters.count > 0)
        {
            self.isButtonEnable = true
        }
        else
        {
            self.isButtonEnable = false
        }
    }
    
    func clearValueOnUI(){
        self.firstName = kEmpty
        self.lastName = kEmpty
        self.email = kEmpty
        self.projectDescription = kEmpty
    }
}
