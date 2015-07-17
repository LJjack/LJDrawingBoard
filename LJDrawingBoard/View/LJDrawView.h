//
//  LJDrawView.h
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJDrawView : UIView
// 每一页的绘图
@property (strong,nonatomic) NSMutableDictionary *drawPages;
;
@property (assign,nonatomic) NSInteger page;
/*画图*/
- (void)draw;
/*撤销*/
- (void)undo;
/*橡皮擦*/
- (void)eraser;
/*清屏*/
- (void)clearScreen;
/*在第page页绘画*/
- (void)drawOnPage:(NSInteger )page;
@end
