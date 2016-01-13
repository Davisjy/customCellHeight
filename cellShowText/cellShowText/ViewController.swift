//
//  ViewController.swift
//  cellShowText
//
//  Created by qingyun on 16/1/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var myTableView: UITableView!
    
    var dataArr: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置基本ui情况
        self.setupUI()
        
        // 加载数据
        self.loadData()
    }

    func setupUI() {
        self.title = "gogo🤗"
        self.view.backgroundColor = UIColor.whiteColor()
        myTableView = UITableView(frame: UIScreen.mainScreen().bounds, style: UITableViewStyle.Plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        self.view.addSubview(myTableView)
    }
    
    func loadData() {
        let filePath = NSBundle.mainBundle().URLForResource("TextInfo", withExtension: "json")
        let data: NSData! = NSData(contentsOfURL: filePath!)!
        let json: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
        let resultArr: AnyObject = json.objectForKey("textList")!
        for dict in resultArr as! [[String: AnyObject]] {
            let entity = TextEntity(dict: dict)
            self.dataArr.append(entity)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "identifier"
        var cell: MyTableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier) as? MyTableViewCell
        
        if cell == nil {
            cell = MyTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        cell?.selectionStyle = .None
        cell?.myclosure = myClosure
        
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        cell?.entity = self.dataArr[indexPath.row] as! TextEntity
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let entity: TextEntity!
        entity = self.dataArr[indexPath.row] as! TextEntity
        
        if entity != nil {
            return MyTableViewCell.cellHeight(entity)
        }
        return 0.0
    }
    
    func myClosure(cell: UITableViewCell) -> Void {
        let indexPath: NSIndexPath = (myTableView.indexPathForCell(cell))!
        myTableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }

}

