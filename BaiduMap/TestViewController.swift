//
//  TestViewController.swift
//  BaiduMap
//
//  Created by EIT on 16/7/13.
//  Copyright © 2016年 EIT. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let wayPoint = BMKPlanNode()
        wayPoint.name = "循礼门"
        wayPoint.cityName = "武汉"
        
        let wayPoint1 = BMKPlanNode()
        wayPoint1.name = "关谷广场"
        wayPoint1.cityName = "武汉"
        
        let wayPoint2 = BMKPlanNode()
        wayPoint2.name = "建设十路"
        wayPoint2.cityName = "武汉"
        
        let wayPoint3 = BMKPlanNode()
        wayPoint3.name = "青山少年宫"
        wayPoint3.cityName = "武汉"
        
        let wayPoint4 = BMKPlanNode()
        wayPoint4.name = "北洋桥路"
        wayPoint4.cityName = "武汉"
        
        let wayPoint5 = BMKPlanNode()
        wayPoint5.name = "团结大道黄鹤路"
        wayPoint5.cityName = "武汉"
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
