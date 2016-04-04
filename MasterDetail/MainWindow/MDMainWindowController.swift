//
//  MasterDetailMainWindowController.swift
//  MasterDetail
//
//  Created by Hussain  on 24/2/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import Cocoa

class MDMainWindowController: NSWindowController,MDOutlineViewRowChange,MDTableViewRowChange,MDCustomSheetDataSource {
    
    @IBOutlet weak var sourceListPlaceHolderView : NSView!
    @IBOutlet weak var masterDetailPlaceHolderSplitView : NSSplitView!
    @IBOutlet weak var masterPlaceHolderView : NSView!
    @IBOutlet weak var detailPlaceHolderView : NSView!
    lazy var sourceListViewController = MDSourceListViewController(nibName : kSourceListView, bundle: nil)
    lazy var masterDetailTableListViewController = MDTableListViewController(nibName: kMasterDetailTableListView, bundle: nil)
    lazy var masterDetailTableViewController = MDTableViewController(nibName: kMasterDetailTableView, bundle: nil)
    var customSheetWindowController = MDCustomSheetWindowController(windowNibName: kMasterDetailCustomSheetWindow)
    dynamic var isAddButtonEnable  = true
    dynamic var isremoveButtonEnable = true
    dynamic var isDesigner = true
    dynamic var tempRowObject : AnyObject?
    
    override func windowDidLoad() {
        super.windowDidLoad()
        addSourceListView()
        addMasterListView()
        addMasterDetailView()
        if let item = self.sourceListViewController as MDSourceListViewController!{
            item.sourceListOutlineView.selectRowIndexes(NSIndexSet(index: 1), byExtendingSelection: false)
        }
        

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    func addSourceListView(){
        let sourceListView = self.sourceListViewController!.view
        self.sourceListPlaceHolderView.addSubview(sourceListView)
        sourceListView.translatesAutoresizingMaskIntoConstraints = false
        let viewDictionary = ["sourceListView" : sourceListView]
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[sourceListView]|", options: [], metrics: nil, views: viewDictionary)
        self.sourceListPlaceHolderView.addConstraints(verticalConstraint)
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[sourceListView]|", options: [], metrics: nil, views: viewDictionary)
        self.sourceListPlaceHolderView.addConstraints(horizontalConstraint)
        self.sourceListViewController?.delegate = self
    }
    
    func addMasterListView()
    {
        let masterListView = self.masterDetailTableListViewController!.view
        self.masterDetailTableListViewController?.delegate = self
        self.masterPlaceHolderView.addSubview(masterListView)
        masterListView.translatesAutoresizingMaskIntoConstraints = false
        let viewDictionary = ["masterListView" : masterListView]
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[masterListView]|", options: [], metrics: nil, views: viewDictionary)
        self.masterPlaceHolderView.addConstraints(verticalConstraint)
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[masterListView]|", options: [], metrics: nil, views: viewDictionary)
        self.masterPlaceHolderView.addConstraints(horizontalConstraint)
    }
    
    
    
    func addMasterDetailView(){
        let masterDetailView = self.masterDetailTableViewController!.view
        self.detailPlaceHolderView.addSubview(masterDetailView)
        masterDetailView.translatesAutoresizingMaskIntoConstraints = false
        let viewDictionary = ["masterDetailView" : masterDetailView]
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[masterDetailView]|", options: [], metrics: nil, views: viewDictionary)
        self.detailPlaceHolderView.addConstraints(verticalConstraint)
        let horizontalConsraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[masterDetailView]|", options: [], metrics: nil, views: viewDictionary)
        self.detailPlaceHolderView.addConstraints(horizontalConsraint)
    }

    func outlineViewRowDidChanged(rowObject: AnyObject) {
        if let masterDetailEmployeeModel = rowObject as? MDEmployeeModel
        {
            self.tempRowObject = masterDetailEmployeeModel
            let masterDetailEmployeeModelList = [masterDetailEmployeeModel]
            self.masterDetailTableListViewController?.updateTableList(masterDetailEmployeeModelList)
            self.isAddButtonEnable = false
            self.isremoveButtonEnable = true
        }
        else if let masterDetailAccountModel = rowObject as? MDAccountModel
        {
            self.masterDetailTableListViewController?.updateTableList(masterDetailAccountModel.employeeList)
            self.isAddButtonEnable = true
            self.isremoveButtonEnable = false
            let index = self.sourceListViewController?.sourceListOutlineView.selectedRow
            self.isDesigner = (index == 1 )
            self.masterDetailTableViewController?.resetView()
        }
        else
        {
            self.masterDetailTableViewController?.resetView()
        }

    }
    
    func tableViewRowDidChanged(rowObject : AnyObject) {
        if let masterDetailEmployeeModel = rowObject as? MDEmployeeModel
        {
            let masterDetailEmployeeModelList = [masterDetailEmployeeModel]
            self.masterDetailTableViewController?.updateTableList(masterDetailEmployeeModelList)
        }
    }
    
    @IBAction func addPerson(sender : AnyObject){
        self.customSheetWindowController.titleMessage = kAddPersonSheetMessage
        let sheetWindow = self.customSheetWindowController.window
        self.window?.beginSheet(sheetWindow!, completionHandler:nil);
        self.customSheetWindowController.dataSource = self
        self.customSheetWindowController.flag = self.isDesigner
    }
    
    func updateMasterDetailSourceList(model: MDEmployeeModel)
    {
        
        self.sourceListViewController?.addEmployeesInSourceListArray(model)
    }
    
    @IBAction func removePerson(sender : AnyObject){
        let model = self.tempRowObject as! MDEmployeeModel
        self.sourceListViewController?.removeEmployeedInSourceListArray(model)
    }
}
