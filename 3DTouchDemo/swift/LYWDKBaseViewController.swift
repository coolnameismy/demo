//
//  LYWDKBaseViewController.swift
//  3DTouchDemo
//
//  Created by 刘彦玮 on 16/3/25.
//  Copyright © 2016年 刘彦玮. All rights reserved.
//

import UIKit

class LYWDKBaseViewController: UIViewController {

    struct ViewContent {
        let title:String
        let subTitle:String
    }
    
    var content:ViewContent?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        
        view.backgroundColor = UIColor.whiteColor()
        guard let content = content else {
            return
        }

        let content_title =  UILabel(frame: CGRect(x: 0, y: view.center.y, width: view.frame.width, height: 50))
        content_title.text = content.title
        content_title.textAlignment = .Center
        content_title.autoresizingMask = UIViewAutoresizing.FlexibleTopMargin

        content_title.backgroundColor = UIColor.greenColor()
        view.addSubview(content_title)
        
    }
    
    func setContent (title:String,subTitle:String) {
        content = ViewContent(title: title, subTitle: subTitle)
    }
}
