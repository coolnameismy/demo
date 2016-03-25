//
//  DetailViewController.swift
//  3DTouchDemo
//
//  Created by 刘彦玮 on 16/3/25.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

import UIKit

class DetailViewController: LYWDKBaseViewController {

    lazy var previewActions:[UIPreviewActionItem] = {
        func previewActionWithTitle(title:String, style:UIPreviewActionStyle = .Default) -> UIPreviewAction {
            return UIPreviewAction(title: title, style: style) { (previewAction, viewController) -> Void in
                NSLog("\(previewAction.title)")
            }
        }
        
        let a = previewActionWithTitle("a")
        let b = previewActionWithTitle("b", style: .Destructive)
        let c = previewActionWithTitle("c", style: .Selected)
        let d_e_f = UIPreviewActionGroup(title: "d&e&f ...",
                                     style: .Default,
                                     actions: [previewActionWithTitle("d"),previewActionWithTitle("e"),previewActionWithTitle("f")])

        return [a,b,c,d_e_f]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setContent(title: String, subTitle: String) {
        super.setContent(title, subTitle: subTitle)
    }

    
    //
    override func previewActionItems() -> [UIPreviewActionItem] {
        return previewActions
    }

}
