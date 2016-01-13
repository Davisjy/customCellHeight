//
//  MyTableViewCell.swift
//  cellShowText
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

import UIKit

let screenHeight = UIScreen.mainScreen().bounds.height
let screenWidth  = UIScreen.mainScreen().bounds.width

// 类似oc的typedef
typealias showMoreTextClosure = (cell: UITableViewCell) -> Void
class MyTableViewCell: UITableViewCell {

    var textTitle: UILabel!
    var textContent: UILabel!
    var moreTextBtn: UIButton!
    var entity: TextEntity!
    
    var myclosure: showMoreTextClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 设置标题
        textTitle = UILabel(frame: CGRect(x: 15, y: 5, width: 140, height: 20))
        textTitle.textColor = UIColor.grayColor()
        textTitle.font = UIFont.systemFontOfSize(16)
        self.contentView.addSubview(textTitle)
        
        // 设置内容
        textContent = UILabel(frame: CGRect(x: 15, y: 30, width: screenWidth - 30, height: 20))
        textContent.textColor = UIColor.blackColor()
        textContent.font = UIFont.systemFontOfSize(16)
        textContent.numberOfLines = 0
        self.contentView.addSubview(textContent)
        
        // 设置右上角btn按钮
        moreTextBtn = UIButton(type: UIButtonType.Custom)
        moreTextBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        moreTextBtn.frame = CGRectMake(screenWidth - 50, 5, 40, 20)
        moreTextBtn.addTarget(self, action: "moreTextAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.contentView.addSubview(moreTextBtn)
    }

    override func layoutSubviews() {
        textTitle.text = entity.textName
        textContent.text = entity.textContent
        
        if entity.isShowText == true {
            let text: NSString = NSString(CString: textContent.text!.cStringUsingEncoding(NSUTF8StringEncoding)!, encoding: NSUTF8StringEncoding)!
            let frame: CGRect = text.boundingRectWithSize(CGSizeMake(screenWidth - 30, CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: textContent.font], context: nil)
            let height = frame.size.height
            textContent.frame = CGRect(x: 15, y: 30, width: screenWidth - 30, height: height)
            moreTextBtn.setTitle("收起", forState: UIControlState.Normal)
        } else {
            moreTextBtn.setTitle("展开", forState: UIControlState.Normal)
            textContent.frame = CGRect(x: 15, y: 30, width: screenWidth - 30, height: 35)
        }
    }
    
    func moreTextAction() {
        entity.isShowText = !entity.isShowText
        if myclosure != nil {
            myclosure!(cell: self)
        }
    }
    
    static func cellHeight(entity: TextEntity) -> CGFloat {
        if entity.isShowText == true {
            let text: NSString = NSString(CString: entity.textContent!.cStringUsingEncoding(NSUTF8StringEncoding)!, encoding: NSUTF8StringEncoding)!
            let frame: CGRect = text.boundingRectWithSize(CGSizeMake(screenWidth - 30, CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(16)], context: nil)
            return frame.size.height + 50
        } else {
            return 85
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
