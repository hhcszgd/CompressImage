//
//  UIImageExtension.swift
//  TestCompressImage
//
//  Created by WY on 2018/7/27.
//  Copyright © 2018年 WY. All rights reserved.
//

import UIKit
extension UIImage{
    func compressImageSize() -> UIImage? {
        let dd = UIImageJPEGRepresentation(self, 1)
        if dd?.count ?? 0 > 1300000{//压缩到大概1M以下
            UIGraphicsBeginImageContextWithOptions(self.size, true, 0.5)
            self.draw(in: CGRect(x: 0, y: 0, width: self.size.width , height: self.size.height ))
            let  newImage  = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            guard let data = UIImageJPEGRepresentation(newImage!, 1) else{
                return nil
            }
            guard let convertImage = UIImage(data: data) else{return nil}
            return convertImage.compressImageSize()
        }
        return self
    }
    
    /// compressImageQuality
    ///
    /// - Parameters:
    ///   - quality: 0.0 ~ 1.0, 1.0 is the best quality
    func compressImageQuality( quality : CGFloat) -> UIImage? {
        guard let data = UIImageJPEGRepresentation(self , quality) else{
            return nil
        }
        guard let convertImage = UIImage(data: data) else{return nil}
        return convertImage
    }
    func addWaterImage(_ waterImage : UIImage , waterImageRect : CGRect? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, true, 0)// 0 不压缩
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width , height: self.size.height))
        let waterImageRect = waterImageRect
        if let waterImageRect = waterImageRect{
            waterImage.draw(in: waterImageRect)
        }else{
            
            let waterSizeScale = self.size.width/8 * 6 / waterImage.size.width
            let waterW:CGFloat = waterImage.size.width * waterSizeScale
            let waterH : CGFloat = waterImage.size.height * waterSizeScale
            let waterX : CGFloat = self.size.width/8
            let waterY:CGFloat = self.size.height/2 - waterH/2
            let waterRect = CGRect(x: waterX, y: waterY, width: waterW, height: waterH)
            waterImage.draw(in: waterRect)
        }
        let  newImage  = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        let data = UIImageJPEGRepresentation(newImage!, 1)////最好一个参数起压缩作用
        guard let convertImage = UIImage(data: data!) else{return nil}
        return convertImage
    }
    func writeImage(filePathLastComponent:String? = nil ) {
        let data = UIImageJPEGRepresentation(self,1)
        var homePathOrigin = NSHomeDirectory()
        if let filePathLastComponent = filePathLastComponent{
            homePathOrigin.append("/Library/\(filePathLastComponent)")
        }else{
            let fileName = "/Library/\(Date().timeIntervalSince1970)"
            homePathOrigin.append("\(fileName).jpeg")
        }
        let result1 = try?  data?.write(to: URL(fileURLWithPath: homePathOrigin))
    }
}
