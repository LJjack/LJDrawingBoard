//
//  LJBgView.m
//  LJDrawingBoard
//
//  Created by liujunjie on 15-7-16.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJBgView.h"

@implementation LJBgView


- (void)awakeFromNib {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    for (NSInteger i = 0; i < 3; i ++) {
        UILabel *page = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
        [page setCenter:CGPointMake(screenWidth*0.5 + screenWidth*i , CGRectGetMaxY(self.frame)-20)];
        [page setTextAlignment:NSTextAlignmentCenter];
        [page setText:@"1/3页"];
        [self addSubview:page];
    }
    
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    
   
    
    [[UIColor colorWithRed:223/255.0 green:230/255.0 blue:239/255.0 alpha:1.0] set];
    CGFloat board = 64.0f;
    CGMutablePathRef drawPath = CGPathCreateMutable();
    //横
    NSInteger numC = rect.size.height/board;

    for (NSInteger x = 1; x <= numC; x ++) {
        
        CGPathMoveToPoint(drawPath, NULL, 0, x*board);

        CGPathAddLineToPoint(drawPath, NULL, rect.size.width, x*board);
    }
    // 添加路径
    CGContextAddPath(context, drawPath);
    
    // 绘制路径
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(drawPath);
    
    //竖
    CGMutablePathRef drawPath1 = CGPathCreateMutable();
    CGFloat lengths[1] = {10.0};
    CGContextSetLineDash(context, 0.0, lengths, 1);
    NSInteger numR = rect.size.width/board;

    for (NSInteger y = 1; y <= numR; y ++) {
        
        CGPathMoveToPoint(drawPath1, NULL, y*board, 0);
        CGPathAddLineToPoint(drawPath1, NULL, y*board, rect.size.height);
    }

    
    // 添加路径
    CGContextAddPath(context, drawPath1);
    
    // 绘制路径
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(drawPath1);
    
    
}


@end
