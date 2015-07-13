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

- (void)drawToolViewWithDraw;
- (void)drawToolViewWithUndo;
- (void)drawToolViewWithEraser;
- (void)drawToolViewWithClearScreen;
- (void)drawToolViewWithKeepImage;
- (void)drawToolViewWithBack;
@end
@interface LJDrawToolView : UIView
@property (nonatomic, assign) id<LJDrawToolViewDelegate> delegate;
@property (nonatomic, weak) LJButton *fristBtn;
- (void)click:(LJButton *)sender ;
@end
