//
//  ViewController.swift
//  3DTouchDemo
//
//  Created by 刘彦玮 on 16/3/21.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

import UIKit

class ViewController: LYWDKBaseTableVIewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.rightBarButtonItem = buttonForInsertNewRowWithDate()
    //注册委托
    registerForPreviewingWithDelegate(self, sourceView: view)
    
    tableViewData.append("3DTouch出现peek视图a");     tableViewData.append("3DTouch出现peek视图a");
  }

}

extension ViewController: UIViewControllerPreviewingDelegate {
    
    // MARK: UIViewControllerPreviewingDelegate
    
    /// Create a previewing view controller to be shown at "Peek".
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        // Obtain the index path and the cell that was pressed.
        guard let indexPath = tableView.indexPathForRowAtPoint(location),
            cell = tableView.cellForRowAtIndexPath(indexPath) else { return nil }
        
        // Create a detail view controller and set its properties.
        let detailViewController = DetailViewController()
        
        detailViewController.title =  "\(indexPath.row)"
        
        /*
        Set the height of the preview by setting the preferred content size of the detail view controller.
        Width should be zero, because it's not used in portrait.
        */
        detailViewController.preferredContentSize = CGSize(width: 0.0, height: 0.0)
        
        // Set the source rect to the cell frame, so surrounding elements are blurred.
        previewingContext.sourceRect = cell.frame
        
        detailViewController.setContent("title", subTitle: "subtitle")
        
        return detailViewController
    }
    
    /// Present the view controller for the "Pop" action.
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        // Reuse the "Peek" view controller for presentation.
        showViewController(viewControllerToCommit, sender: self)
    }
}

