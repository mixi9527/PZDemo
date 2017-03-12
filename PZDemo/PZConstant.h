//
//  PZConstant.h
//  PZDemo
//
//  Created by 张佳佩 on 2017/03/10.
//  Copyright © 2017年 Jee. All rights reserved.
//

#ifndef PZConstant_h
#define PZConstant_h

/// 视图间隔
#define kViewMargin 8.0f
/// 圆角弧度
#define kCornerRadius 8.0f

/// 打印
#ifdef DEBUG
#define DLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define DLog(s, ...)
#endif

/// 设备的尺寸
#define kSB [UIScreen mainScreen].bounds
/// 设备的高度
#define kSH [[UIScreen mainScreen] bounds].size.height
/// 设备的宽度
#define kSW [[UIScreen mainScreen] bounds].size.width

/// 带有RGBA的颜色设置 UIColor *color=RGBA(102, 204, 255, 1.0)
#define kRGBA(R, G, B, A) [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]
/// 背景色
#define kBGColor [UIColor colorWithRed:242.0 / 255.0 green:236.0 / 255.0 blue:231.0 / 255.0 alpha:1.0]
/// 清除背景色
#define kCColor [UIColor clearColor]
/// UIColor里的RGBA是0～1，不是0～255
/// rgb颜色转换（16进制->10进制）
#define kRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

/// 随机颜色
#define kRColor [UIColor colorWithRed:(arc4random()%256)/256.f green:(arc4random()%256)/256.f blue:(arc4random()%256)/256.f alpha:1.0f]

/// 设置字体
#define kFont(SIZE) [UIFont systemFontOfSize:SIZE]
/// 设置粗体字体
#define kBFont(SIZE) [UIFont boldSystemFontOfSize:SIZE]


#endif /* PZConstant_h */
