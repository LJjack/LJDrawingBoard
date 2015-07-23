//
//  LJViewController.m
//  Testmasking
//
//  Created by liujunjie on 15-7-13.
//  Copyright (c) 2015年 rj. All rights reserved.
//
/*
 使用方法：
 1.引进头文件 #import "LJDrawViewController.h"
 2.遵守代理 <LJDrawViewControllerDelegate>
 3.添加方法
 4.使用模态弹出
 注意：放回的image因为是加上工具栏是满屏，
      所以对image处理时因该注意宽高比
 */
#import "LJViewController.h"
#import "LJDrawViewController.h"
@interface LJViewController ()<LJDrawViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@end

@implementation LJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)drawViewControllerBackImage:(UIImage *)image {
    
    CGRect frame = self.imageView1.frame;
    frame.size = image.size;
    self.imageView1.frame = frame;
    
    self.imageView1.image = image;
    [self saveImage:image];
}
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
- (IBAction)btn:(UIButton *)sender {
    LJDrawViewController *drawVC = [[LJDrawViewController alloc] init];
    [drawVC setDelegate:self];
    [self.navigationController presentViewController:drawVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
