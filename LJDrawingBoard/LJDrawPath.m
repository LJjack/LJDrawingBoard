//
//  LJDrawPath.m
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJDrawPath.h"

@implementation LJDrawPath
+ (id)drawPathWithCGPath:(CGPathRef)drawPath
                   color:(UIColor *)color
               lineWidth:(CGFloat)lineWidth {
    LJDrawPath *path = [[LJDrawPath alloc] init];
    path.drawPath = [UIBezierPath bezierPathWithCGPath:drawPath];
    path.drawColor = color;
    path.lineWidth = lineWidth;
    return path;
}
@end
