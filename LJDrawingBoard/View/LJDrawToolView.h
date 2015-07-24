//
//  LJDrawToolView.h
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJDrawToolView,LJButton;
@protocol LJDrawToolViewDelegate <NSObject>

//- (void)drawToolViewWithDraw;
- (void)drawToolViewWithUndo;//撤销
- (void)drawToolViewWithRecovery;//恢复
- (void)drawToolViewWithEraser:(BOOL)isEraser;//是否使用橡皮擦
- (void)drawToolViewWithClearScreen;//清屏
- (void)drawToolViewWithKeepImage;//保存图像
- (void)drawToolViewWithBack;//返回
- (void)drawToolViewWithNext;//下一页
- (void)drawToolViewWithPrevious;//上一页
- (void)drawToolViewWithLastTrace;//上次痕迹

@end
@interface LJDrawToolView : UIScrollView
@property (nonatomic, assign) id<LJDrawToolViewDelegate> drawToolDelegate;
@end
