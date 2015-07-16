//
//  LJDrawPath.h
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJDrawPath : NSObject
+ (id)drawPathWithCGPath:(CGPathRef)drawPath
                   color:(UIColor *)color
               lineWidth:(CGFloat)lineWidth;

@property (strong, nonatomic) UIBezierPath *drawPath;
@property (strong, nonatomic) UIColor *drawColor;
@property (assign, nonatomic) CGFloat lineWidth;

// 用户选择的图像
@property (strong, nonatomic) UIImage *image;
@end
