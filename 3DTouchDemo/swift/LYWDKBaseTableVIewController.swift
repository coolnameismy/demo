//
//  LYWDKBaseTableVIewController.swift
//  3DTouchDemo
//
//  Created by 刘彦玮 on 16/3/23.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

import UIKit

class LYWDKBaseTableVIewController: UITableViewController {

    //tableView的数据集
    var tableViewData = [AnyObject]()
  
  
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
  
    // MARK: -left and right buttonItem options
    func buttonForInsertNewRowWithDate()->UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewRow:")
    }
  
    // MARK: - shortcut method
  
    //add demo row in data,content is a date on now
    func insertNewRow(sender: AnyObject) {
      tableViewData.insert(NSDate().description, atIndex: 0)
      let indexPath = NSIndexPath(forRow: 0, inSection: 0)
      self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
  
    
    //set menu and vc
    func addMenu() {
        
    }
    func addMenus() {
        
    }
    
    // MARK: - Table view data source
  
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      return 1
    }
  
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tableViewData.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel!.text = tableViewData[indexPath.row] as? String
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


//class LYWDKBaseTableVIewControllerOption:NSObject {
//    var has
//}
