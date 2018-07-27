//
//  ViewController.swift
//  TestCompressImage
//
//  Created by WY on 2018/7/26.
//  Copyright © 2018年 WY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imageView1)
        self.view.addSubview(imageView2)
        imageView1.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height/2)
        imageView2.frame = CGRect(x: 0, y:self.view.bounds.height/2 , width: self.view.bounds.width, height: self.view.bounds.height/2)


        let image = UIImage(named:"view")
        self.imageView1.image = image
        let waterImage = UIImage(named:"ledpng")
        self.addWaterImage(waterImage!, in: image!)

    }
    
    func addWaterImage(_ waterImage : UIImage , in backgroundImage : UIImage) -> UIImage {
        print("开始第一步压缩")
        let backgroundImage = backgroundImage.compressImageQuality(quality: 0.1)
        print("开始第二步压缩")
//        backgroundImage?.writeImage()
        let img = backgroundImage.compressImageSize()
        print("开始添加水印")
        let img2 = img.addWaterImage(waterImage)
        print("添加水印结束 开始第三步压缩")
        let img3 = img2.compressImageQuality(quality: 0.1)
        print("压缩结束")
        img3.writeImage()
        self.imageView2.image = img3
        return img3
    }
  
}

