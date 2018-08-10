//
//  CLImageBrower.h
//  CLPhotoBrower
//
//  Created by Gentear on 2018/8/10.
//  Copyright © 2018年 zyyt. All rights reserved.
//


#define kCLScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCLScreenHeight [UIScreen mainScreen].bounds.size.height
#define kCLScreenBounds [UIScreen mainScreen].bounds
//图片缩放比例
#define kCLMinZoomScale 1.0f
#define kCLMaxZoomScale 2.0f
//图片浏览器图片间距
#define kCLImageSpace 40.0f

#import "CLPhotoViewCell.h"
#import "CLPhotoFlowLayout.h"
#import "CLBrowserView.h"
#import "CLProgressView.h"
#import "UIImageView+WebCache.h"
