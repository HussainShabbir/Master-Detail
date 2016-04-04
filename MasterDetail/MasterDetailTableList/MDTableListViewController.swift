//
//  MasterDetailTableListViewController.swift
//  MasterDetail
//
//  Created by Hussain  on 27/2/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import Cocoa

protocol MDTableViewRowChange{
    func tableViewRowDidChanged(rowObject : AnyObject)
}

class MDTableListViewController: NSViewController {
    
    var tableList = [MDEmployeeModel]()
    @IBOutlet weak var arrayController : NSArrayController!
    var delegate : MDTableViewRowChange?
    @IBOutlet weak var tableView : NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func updateTableList(array : AnyObject){
        let modelList = array
        self.willChangeValueForKey("tableList")
        self.tableList = modelList as! [MDEmployeeModel]
        self.didChangeValueForKey("tableList")
        self.tableView.deselectAll(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init()
    {
        self.init(nibName: nil, bundle: nil)!
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let rowIndex  = notification.object?.selectedRow
        if (rowIndex != -1 && self.arrayController.arrangedObjects.count > rowIndex)
        {
            let rowObject : AnyObject = self.arrayController.arrangedObjects[rowIndex!]
            self.delegate?.tableViewRowDidChanged(rowObject)
        }
    }
}
