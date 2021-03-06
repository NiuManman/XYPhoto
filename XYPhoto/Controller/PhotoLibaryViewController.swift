//
//  PhotoLibaryViewController.swift
//  XYPhoto
//
//  Created by jiaxiaoyan on 16/7/20.
//  Copyright © 2016年 jiaxiaoyan. All rights reserved.
//

import UIKit
import Photos
class PhotoLibaryViewController: UIViewController ,PHPhotoLibraryChangeObserver{
    
    var assetCollection : PHAssetCollection?
    var collectionView : PhotoLibaryCollectionView!
    var  navTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blueColor()

        setnav()
        // Do any additional setup after loading the view.
        
        let collectionViewFollowLayout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.mainScreen().bounds.width
        collectionViewFollowLayout.itemSize = CGSizeMake(screenWidth*0.3,screenWidth*0.3)
        collectionViewFollowLayout.minimumLineSpacing = CGFloat(1)
        let rect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        collectionView = PhotoLibaryCollectionView(frame: rect, collectionViewLayout: collectionViewFollowLayout)
        if let assetCollection = assetCollection {
            collectionView.setUpAssetCollection(assetCollection)
            title = navTitle
        }else{
            let cameraRollAlbums = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumUserLibrary, options: nil)
            getGroupData(cameraRollAlbums)

        }
        view.addSubview(collectionView)
        
    }

    func setnav() {
        let backButton = UIButton(type: .Custom)
        backButton.frame = CGRectMake(0, 0, 70, 44)
        backButton.backgroundColor = UIColor.clearColor()
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        backButton.setImage(UIImage(named: "backIcon"), forState: .Normal)
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0)
        backButton.setTitle("返回", forState: .Normal)
        backButton.addTarget(self, action: #selector(PhotoLibaryViewController.backButtonClick), forControlEvents: .TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backButton)
        
        let cancleButton = UIButton(type: .Custom)
        cancleButton.frame = CGRectMake(0, 0, 110, 44)
        cancleButton.backgroundColor = UIColor.clearColor()
        cancleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 40, 0, -40)
        cancleButton.setTitle("取消", forState: .Normal)
        cancleButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        cancleButton.addTarget(self, action: #selector(PhotoLibaryViewController.cancleButtonClick), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: cancleButton)

    }
    
    func  backButtonClick() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func getGroupData(phAssestResult :PHFetchResult) {
        
        weak var weakSelf = self
        
        phAssestResult.enumerateObjectsUsingBlock( {(collections, count, success) in
            
            
            print("phAssestResult count     \(count)")
            if let collection = collections as? PHAssetCollection {
                weakSelf!.collectionView.setUpAssetCollection(collection)
            }
        } )
    }
   
    func  cancleButtonClick() {

        self.dismissViewControllerAnimated(true, completion: nil)
      
    }
    
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func awakeFromNib() {
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
    
    func photoLibraryDidChange(changeInstance: PHChange){
        
    }
    deinit {
        PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
    }
}
