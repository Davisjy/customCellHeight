//
//  TextEntity.swift
//  cellShowText
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

import UIKit

class TextEntity: NSObject {
    var textId: Int!
    var textName: String!
    var textContent: String!
    var isShowText: Bool!
    
    init(dict: NSDictionary) {
        super.init()
        self.textId = dict["textId"] as! Int
        self.textName = dict["textName"] as! String
        self.textContent = dict["textContent"] as! String
        self.isShowText = false
    }
}
