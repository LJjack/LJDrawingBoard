//
//  LJDrawViewController.h
//  Testmasking
//
//  Created by liujunjie on 15-7-13.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJDrawToolView.h"
@class LJDrawViewController;
@protocol LJDrawViewControllerDelegate <NSObject>

@required
- (void)drawViewController:(LJDrawViewController *)drawViewController;
@end
@interface LJDrawViewController : UIViewController<LJDrawToolViewDelegate>
@property (assign, nonatomic) id<LJDrawViewControllerDelegate> delegate;
@end
