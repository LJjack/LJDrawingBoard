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
{
    NSInteger _pageNum;
    UIAlertView *_alert;
}
@property (weak, nonatomic) IBOutlet LJDrawView *drawView;
@property (weak, nonatomic) IBOutlet LJDrawToolView *drawToolView;
@property (weak, nonatomic) IBOutlet LJBgView *bgView;

@end

@implementation LJDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.drawView drawOnPage:1];
    [self.drawToolView setDrawToolDelegate:self];
    
    [self.drawToolView click:self.drawToolView.fristBtn];
    _pageNum = 1;
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
         @selector(drawViewControllerBackImage1:andImage2:andImage3:)]&&image) {
        
        [_delegate drawViewControllerBackImage1:image andImage2:nil andImage3:nil];
    }
}
- (void)drawToolViewWithBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)drawToolViewWithPrevious {
    _pageNum --;
    if (_pageNum >= 1) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = weakSelf.bgView.frame;
            frame.origin.x += [UIScreen mainScreen].bounds.size.width;
            weakSelf.bgView.frame = frame;
        }];
        [self.drawView drawOnPage:_pageNum];
        
    }else {
        _pageNum = 1;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"页数" message:@"已经是第一页" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:YES];

    }
    
}
- (void)drawToolViewWithNext {
    _pageNum ++;
    if (_pageNum<=3) {
        
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = weakSelf.bgView.frame;
            frame.origin.x -= [UIScreen mainScreen].bounds.size.width;
            weakSelf.bgView.frame = frame;
        }];
        [self.drawView drawOnPage:_pageNum];
    }else {
        _pageNum = 3;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"页数" message:@"已经是最后一页" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];

        [alert show];
        [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:YES];
        
    }
}
#pragma mark -
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
