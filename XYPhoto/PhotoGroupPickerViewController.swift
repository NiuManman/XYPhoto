//
//  PhotoGroupPickerViewController.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//
import UIKit
import Photos

class PhotoGroupPickerViewController: UIViewController,PhotoGroupTableDelegate {
    var tableView : PhotoGroupTableView!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        setUpTableView()
    }
    
    func setUpTableView(){
        if tableView == nil{
            tableView = PhotoGroupTableView()
            let rect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
            tableView.setUpSelf(rect)
            tableView.photoGroupDelegate = self
            view.addSubview(tableView)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setnav()
    }
    func setnav() {
        title = "照片"
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRectMake(0, 0, 70, 44)
        backButton.backgroundColor = UIColor.lightGrayColor()
        backButton.setTitle("取消", forState: .Normal)
        backButton.addTarget(self, action: #selector(PhotoLibaryViewController.cancleButtonClick), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: backButton)
        self.navigationItem.hidesBackButton = true
    }
    
    func  cancleButtonClick() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    func didSelectPhotoGroupTableRowCallBack(assetCollection : PHAssetCollection ,name : String){
        let vc = PhotoLibaryViewController()
        print("\(self.navigationController)")
        self.navigationController?.pushViewController(vc, animated: true)
        vc.navTitle = name
        vc.assetCollection = assetCollection
    }
}