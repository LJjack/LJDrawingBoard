//
//  LJDrawViewController.h
//  Testmasking
//
//  Created by liujunjie on 15-7-13.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJDrawToolView.h"
@protocol LJDrawViewControllerDelegate <NSObject>

@required
- (void)drawViewControllerBackImage:(UIImage *)image;
@end
@interface LJDrawViewController : UIViewController<LJDrawToolViewDelegate>
@property (assign, nonatomic) id<LJDrawViewControllerDelegate> delegate;
@end
