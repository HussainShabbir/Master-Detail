//
//  MasterDetailTableViewController.swift
//  MasterDetail
//
//  Created by Hussain  on 27/2/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import Cocoa

class MDTableViewController: NSViewController {
    
    var tableList = [MDEmployeeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
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
    
    func updateTableList(array : AnyObject){
        let modelList = array
        self.willChangeValueForKey("tableList")
        self.tableList = modelList as! [MDEmployeeModel]
        self.didChangeValueForKey("tableList")
    }
    
    func resetView()
    {
        let model : MDEmployeeModel = MDEmployeeModel(firstName: kEmpty, lastName: kEmpty, email: kEmpty, designationType: kEmpty, projectDescription: kEmpty)
        self.willChangeValueForKey("tableList")
        self.tableList = [model]
        self.didChangeValueForKey("tableList")
    }
    
}
