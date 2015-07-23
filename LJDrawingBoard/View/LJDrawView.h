//
//  LJDrawView.h
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJDrawView : UIView
// 绘图路径数组
@property (strong, nonatomic) NSMutableArray *drawPathArray;
//绘制图片的frame
@property (assign,nonatomic) CGRect drawImageFrame;
/*撤销*/
- (void)undo;
/*橡皮擦*/
- (void)eraser:(BOOL)isEraser;
/*清屏*/
- (void)clearScreen;
/*恢复*/
- (void)recovery;
/*上次痕迹*/
- (void)lastTrace:(NSArray *)drawPathArray;
@end
