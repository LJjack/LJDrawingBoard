//
//  LJDrawViewController.m
//  Testmasking
//
//  Created by liujunjie on 15-7-13.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJDrawViewController.h"
#import "LJDrawView.h"
#import "LJDrawToolView.h"
#import "LJBgView.h"
@interface LJDrawViewController ()
@property (weak, nonatomic) IBOutlet LJDrawView *drawView;
@property (weak, nonatomic) IBOutlet LJDrawToolView *drawToolView;
@property (weak, nonatomic) IBOutlet LJBgView *bgView;

@end

@implementation LJDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.drawToolView setDrawToolDelegate:self];
    
    [self.drawToolView click:self.drawToolView.fristBtn];
}
#pragma mark - drawToolDelegate
- (void)drawToolViewWithDraw {
    [self.drawView draw];
}
- (void)drawToolViewWithUndo {
    [self.drawView undo];
}

- (void)drawToolViewWithEraser {
    [self.drawView eraser];
}

- (void)drawToolViewWithClearScreen {
    [self.drawView clearScreen];
}
- (void)drawToolViewWithKeepImage {
    
    UIGraphicsBeginImageContext(self.drawView.bounds.size);
    [self.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if ([_delegate respondsToSelector:
         @selector(drawViewControllerBackImage:)]&&image) {
        
        [_delegate drawViewControllerBackImage:image];
    }
}
- (void)drawToolViewWithBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
