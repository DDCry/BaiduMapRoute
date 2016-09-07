//
//  ViewController.swift
//  BaiduMap
//
//  Created by EIT on 16/7/13.
//  Copyright © 2016年 EIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DDSegmentedControlDelegate {

    @IBOutlet weak var myTB: UITableView!
    
    var sectionInfoArray = [SectionInfo]()
    var opensectionindex:Int!
    var sectionHeaderView:BusListHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.initDatasource()
        let segmented = DDSegmentedControl(
            frame: CGRect(
                x: 0,
                y: 64,
                width: view.frame.size.width,
                height: 80),
            titles: [
                ["金银潭方向","发车:07:00"],
                ["光谷广场","发车:07:00"]
            ],
            action: {
                control, index in
                print ("segmented did pressed \(index)")
        })
        segmented.delegate = self
        view.addSubview(segmented)
        
//        self.myTB.registerClass(TestCell.self, forCellReuseIdentifier: "TestCell")
    }
    
    func initDatasource()
    {
        for index in 0 ..< 10 {
            let sectionInfo = SectionInfo()
            sectionInfo.rowsArray = NSArray.init(array: ["你打特"]) as! [String]
            sectionInfo.open = false
            sectionInfo.name = "关谷广场"
            self.sectionInfoArray.append(sectionInfo)
        }
        

            

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: YSSegmentedControlDelegate
    
    func segmentedControlWillPressItemAtIndex(segmentedControl: DDSegmentedControl, index: Int) {
        print ("[Delegate] segmented will press \(index)")
    }
    
    func segmentedControlDidPressedItemAtIndex(segmentedControl: DDSegmentedControl, index: Int) {
        print ("[Delegate] segmented did pressed \(index)")
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return self.sectionInfoArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 这个方法返回对应的section有多少个元素，也就是多少行
        let sectionInfo = self.sectionInfoArray[section] 
        let numStoriesInSection = sectionInfo.rowsArray.count
        let sectionOpen = sectionInfo.open
        
        return sectionOpen ? numStoriesInSection : 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TestCell", forIndexPath: indexPath) as! TestCell
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 70
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 0.001
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeaderView = NSBundle.mainBundle().loadNibNamed("BusListHeaderView", owner: self, options: nil).first as! BusListHeaderView
        
        let sectionInfo: SectionInfo = self.sectionInfoArray[section]
        sectionHeaderView.sectionInfo = sectionInfo
        sectionHeaderView.section = section
        sectionHeaderView.delegate = self
        
        return sectionHeaderView
    }
    
    
}

extension ViewController:SectionHeaderViewDelegate{
    
    // MARK: SectionHeaderViewDelegate
    
    func sectionHeaderView(sectionHeaderView: BusListHeaderView, sectionOpened: Int) {
        
        let sectionInfo = self.sectionInfoArray[sectionOpened] 
        
        sectionInfo.open = true
        
        self.myTB.reloadData()
//        self.myTB.reloadSections(NSIndexSet.init(index: sectionOpened), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func sectionHeaderView(sectionHeaderView: BusListHeaderView, sectionClosed: Int) {
        
        let sectionInfo = self.sectionInfoArray[sectionClosed] 
        
        sectionInfo.open = false
        
        self.myTB.reloadData()
//        self.myTB.reloadSections(NSIndexSet.init(index: sectionClosed), withRowAnimation: UITableViewRowAnimation.Automatic)

        

    }
}


class TestCell: UITableViewCell {
    
    
}


class SectionInfo: NSObject
{
    var open = false
    var name:String = ""
    var rowsArray = [String]()
    var headerView: BusListHeaderView!
    
}


protocol SectionHeaderViewDelegate: class, NSObjectProtocol{
    
    func sectionHeaderView(sectionHeaderView: BusListHeaderView, sectionOpened: Int)
    func sectionHeaderView(sectionHeaderView: BusListHeaderView, sectionClosed: Int)
}
class BusListHeaderView: UIView {
    
    @IBOutlet weak var busStationButton: UILabel!
    
    var delegate: SectionHeaderViewDelegate!
    
    var section: Int!
    
    var sectionInfo = SectionInfo()
    
    override func awakeFromNib() {
        
        // 建立点击手势识别
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BusListHeaderView.toggleOpen(_:)))
        
        self.addGestureRecognizer(tapGesture)
        
        
    }
    
    func toggleOpen(sender: UITapGestureRecognizer)
    {
        self.toggleOpenWithUserAction(true)
    }
    
    func toggleOpenWithUserAction(userAction: Bool)
    {

        sectionInfo.open = !sectionInfo.open
        
        if sectionInfo.open{
            self.delegate.sectionHeaderView(self, sectionOpened: self.section)
        }
        else{
            self.delegate.sectionHeaderView(self, sectionClosed: self.section)
        }
        
    }
    
}