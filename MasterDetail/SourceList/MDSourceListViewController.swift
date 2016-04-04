//
//  SourceListViewController.swift
//  MasterDetail
//
//  Created by Hussain  on 24/2/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import Cocoa

protocol MDOutlineViewRowChange
{
    func outlineViewRowDidChanged(rowObject : AnyObject)
}

class MDSourceListViewController: NSViewController {

    @IBOutlet weak var sourceListOutlineView : NSOutlineView!
    var delegate : MDOutlineViewRowChange?
    let masterDetailDepartmentModel = MDDepartmentModel(name : kITDepartment)
    let masterDetailAccountDesignerModel = MDAccountModel(name : kDesigner)
    let masterDetailAccountDeveloperModel = MDAccountModel(name : kDeveloper)
    
    let masterDetailEmployeeDesignerModelList = [MDEmployeeModel(firstName: "Martin", lastName: "Peter", email: "Martin.p@gmail.com",designationType: "Designer", projectDescription: "Martin is a designer"),MDEmployeeModel(firstName: "Harry", lastName: "John", email: "larry.p@gmail.com",designationType: "Designer",projectDescription: "John is a designer")]
    
    let masterDetailEmployeeDeveloperModelList = [MDEmployeeModel(firstName: "Steve", lastName: "Hatling", email: "Steve.H@gmail.com",designationType: "Developer",projectDescription: "Steve is a developer"),MDEmployeeModel(firstName: "Ricky", lastName: "Clarke", email: "Ricky.C@gmail.com",designationType: "Developer", projectDescription: "Ricky is a developer")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for masterDetailEmployeeDesignerModel in masterDetailEmployeeDesignerModelList
        {
            masterDetailAccountDesignerModel.employeeList.append(masterDetailEmployeeDesignerModel)
        }
        
        for masterDetailEmployeeDeveloperModel in masterDetailEmployeeDeveloperModelList
        {
            masterDetailAccountDeveloperModel.employeeList.append(masterDetailEmployeeDeveloperModel)
        }
        
        masterDetailDepartmentModel.accounts.append(masterDetailAccountDesignerModel)
        masterDetailDepartmentModel.accounts.append(masterDetailAccountDeveloperModel)
        self.sourceListOutlineView.expandItem(nil, expandChildren: true)
        // Do view setup here.
    }
    
    
// MARK: NSOutlineViewDataSource method
    func outlineView(outlineView: NSOutlineView, numberOfChildrenOfItem item: AnyObject?) -> Int{
        if let item  : AnyObject = item{
            switch item{
                case let masterDetailDepartmentModel as MDDepartmentModel:
                return masterDetailDepartmentModel.accounts.count
                
            case let masterDetailAccountModel as MDAccountModel:
                return masterDetailAccountModel.employeeList.count
            default:
                return 0
                
            }
        }
        else{
            return 1
        }
        
    }
    func outlineView(outlineView: NSOutlineView, child index: Int, ofItem item: AnyObject?) -> AnyObject{
        if let item : AnyObject = item{
            switch item{
            case let masterDetailDepartmentModel as MDDepartmentModel:
                return masterDetailDepartmentModel.accounts[index]
                
            case let masterDetailAccountModel as MDAccountModel:
                return masterDetailAccountModel.employeeList[index]
                
            default:
                return self
        }
        }else{
            return masterDetailDepartmentModel
        }
        
    }
    func outlineView(outlineView: NSOutlineView, isItemExpandable item: AnyObject) -> Bool{
        if let item  : AnyObject = item{
            switch item{
            case let masterDetailDepartmentModel as MDDepartmentModel:
                return (masterDetailDepartmentModel.accounts.count > 0) ?  true : false
                
            case let masterDetailAccountModel as MDAccountModel:
                return (masterDetailAccountModel.employeeList.count > 0) ? true : false
            default:
                return false
            }
        }
    }
    
// MARK: NSOutlineViewDelegate method 
    func outlineView(outlineView: NSOutlineView, viewForTableColumn: NSTableColumn?, item: AnyObject) -> NSView? {
        switch item {
        case let masterDetailDepartmentModel as MDDepartmentModel:
            let view = outlineView.makeViewWithIdentifier(kHeaderRow, owner: self) as! NSTableCellView
            view.textField?.stringValue = masterDetailDepartmentModel.name
            return view
        case let masterDetailAccountModel as MDAccountModel:
            let view = outlineView.makeViewWithIdentifier(kDataRow, owner: self) as! NSTableCellView
            view.textField?.stringValue = masterDetailAccountModel.name
            return view
        case let masterDetailEmployeeModel as MDEmployeeModel:
            let view = outlineView.makeViewWithIdentifier(kDataRow, owner: self) as! NSTableCellView
            view.textField?.stringValue = masterDetailEmployeeModel.firstName + " " + masterDetailEmployeeModel.lastName
            return view
        default:
            return nil
        }
    }
    
    func outlineView(outlineView: NSOutlineView, isGroupItem item: AnyObject) -> Bool {
        switch item {
        case _ as MDDepartmentModel:
            return true
        default:
            return false
        }
    }
    
    func outlineViewSelectionDidChange(notification: NSNotification){
        let rowIndex = notification.object?.selectedRow
        let rowObject = self.sourceListOutlineView.itemAtRow(rowIndex!)
        if (rowObject !== nil){
            self.delegate?.outlineViewRowDidChanged(rowObject!)
        }
    }
    
    
    func addEmployeesInSourceListArray(masterDetailEmployeeModel: MDEmployeeModel){
        if (masterDetailEmployeeModel.designationType == kDesigner)
        {
            self.masterDetailAccountDesignerModel.employeeList.append(masterDetailEmployeeModel)
        }
        else
        {
            self.masterDetailAccountDeveloperModel.employeeList.append(masterDetailEmployeeModel)
        }
        self.sourceListOutlineView.reloadData()
        self.sourceListOutlineView.selectRowIndexes(NSIndexSet(index: 1), byExtendingSelection: false)
    }
    
    func removeEmployeedInSourceListArray(masterDetailEmployeeModel: MDEmployeeModel){
        if masterDetailEmployeeModel.isKindOfClass(MDEmployeeModel)
        {
            let index : Int = self.sourceListOutlineView.childIndexForItem(masterDetailEmployeeModel)
            if (masterDetailEmployeeModel.designationType == kDesigner){
            self.masterDetailAccountDesignerModel.employeeList.removeAtIndex(index)
            }
            else{
                self.masterDetailAccountDeveloperModel.employeeList.removeAtIndex(index)
            }
            
            self.sourceListOutlineView.reloadData()
            self.sourceListOutlineView.selectRowIndexes(NSIndexSet(index: 1), byExtendingSelection: false)
        }
        
    }
}
