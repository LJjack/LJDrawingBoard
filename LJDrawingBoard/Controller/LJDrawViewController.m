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
#import "LJKeepDrawPath.h"
@interface LJDrawViewController ()
{
    NSInteger _pageNum;
    UIAlertView *_alert;
    
}
@property (weak, nonatomic) IBOutlet LJDrawView *page1DrawView;
@property (weak, nonatomic) IBOutlet LJDrawView *page2DrawView;
@property (weak, nonatomic) IBOutlet LJDrawView *page3DrawView;

@property (weak, nonatomic) IBOutlet LJDrawToolView *drawToolView;
@property (weak, nonatomic) IBOutlet LJBgView *bgView;
@end

@implementation LJDrawViewController
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.drawToolView setDrawToolDelegate:self];
    
    _pageNum = 1;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - drawToolDelegate
- (void)drawToolViewWithClearScreen {
    switch (_pageNum) {
        case 1:
            [self.page1DrawView clearScreen];
            break;
        case 2:
            [self.page2DrawView clearScreen];
            break;
        case 3:
            [self.page3DrawView clearScreen];
            break;
            
        default:
            break;
    }
    
}
- (void)drawToolViewWithLastTrace {
    switch (_pageNum) {
        case 1:
            [self.page1DrawView lastTrace:[LJKeepDrawPath readDrawPathWithPage:_pageNum]];
            break;
        case 2:
            [self.page2DrawView lastTrace:[LJKeepDrawPath readDrawPathWithPage:_pageNum]];
            break;
        case 3:
            [self.page3DrawView lastTrace:[LJKeepDrawPath readDrawPathWithPage:_pageNum]];
            break;
            
        default:
            break;
    }
}
- (void)drawToolViewWithUndo {
    switch (_pageNum) {
        case 1:
            [self.page1DrawView undo];
            break;
        case 2:
            [self.page2DrawView undo];
            break;
        case 3:
            [self.page3DrawView undo];
            break;
            
        default:
            break;
    }
}
- (void)drawToolViewWithRecovery {
    switch (_pageNum) {
        case 1:
            [self.page1DrawView recovery];
            break;
        case 2:
            [self.page2DrawView recovery];
            break;
        case 3:
            [self.page3DrawView recovery];
            break;
            
        default:
            break;
    }
}
- (void)drawToolViewWithEraser:(BOOL)isEraser {
    switch (_pageNum) {
        case 1:
            [self.page1DrawView eraser:isEraser];
            break;
        case 2:
            [self.page2DrawView eraser:isEraser];
            break;
        case 3:
            [self.page3DrawView eraser:isEraser];
            break;
            
        default:
            break;
    }
}


- (void)drawToolViewWithKeepImage {
    BOOL isExitDelegate = [_delegate respondsToSelector:
                           @selector(drawViewController:)];
    
    if (isExitDelegate) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self saveImage:[self mergedImage]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_delegate drawViewController:self];
                [self drawToolViewWithBack];
            });
        });
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
        
    }else {
        _pageNum = 3;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"页数" message:@"已经是最后一页" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];

        [alert show];
        [alert dismissWithClickedButtonIndex:alert.cancelButtonIndex animated:YES];
        
    }
}
#pragma mark - 私有方法
#pragma mark 截屏
- (UIImage *) screenShotWithView:(LJDrawView *)drawView {
    
    UIGraphicsBeginImageContext(drawView.bounds.size);
    [drawView.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage  *bigImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [self image:bigImage andFrame:[drawView drawImageFrame]];
    
}
#pragma mark 截取指定的区域
- (UIImage *)image:(UIImage *)image andFrame:(CGRect)frame {
    //定义myImageRect，截图的区域
    
    
    CGImageRef imageRef = image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, frame);
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, frame, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}

#pragma mark 合并图片
- (UIImage *)mergedImage {
    UIImage *image1 =nil,*image2 = nil,*image3 = nil;
    //1.
    if (self.page1DrawView.drawPaths) {
        //保存绘图路径
        [LJKeepDrawPath storageDrawPath:self.page1DrawView.drawPaths onPage:1];
        //截屏
        image1 = [self screenShotWithView:self.page1DrawView];
    }
    //2.
    if (self.page2DrawView.drawPaths) {
        [LJKeepDrawPath storageDrawPath:self.page2DrawView.drawPaths onPage:2];
        image2 = [self screenShotWithView:self.page2DrawView];
    }
    //3.
    if (self.page3DrawView.drawPaths) {
        [LJKeepDrawPath storageDrawPath:self.page3DrawView.drawPaths onPage:3];
        image3 = [self screenShotWithView:self.page3DrawView];
    }
    
    CGFloat width = MAX(MAX(image1.size.width, image2.size.width), image3.size.width);
    
    UIGraphicsBeginImageContext(CGSizeMake(width, image1.size.height+image2.size.height+image3.size.height));
    [image1 drawAtPoint:CGPointMake(0, 0)];
    [image2 drawAtPoint:CGPointMake(0, image1.size.height)];
    [image3 drawAtPoint:CGPointMake(0, image1.size.height+image2.size.height)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark 保存图片
- (void)saveImage:(UIImage *)image {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    
    BOOL isDir = NO;
    NSString *handWritingDir = [NSString stringWithFormat:@"%@/WISPResources",cachesDirectory];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:handWritingDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:handWritingDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *imageName = [NSString stringWithFormat:@"hand_writing.png"];
    
    NSString *savedImagePath = [handWritingDir stringByAppendingPathComponent:imageName];
    //also be .jpg or another
    
    
    NSData *imageData = UIImagePNGRepresentation(image);    //UIImageJPEGRepresentation(image)
    [imageData writeToFile:savedImagePath atomically:YES];
    NSLog(@"%@",savedImagePath);
}
#pragma mark -
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
