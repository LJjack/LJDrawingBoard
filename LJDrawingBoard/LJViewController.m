//
//  LJViewController.m
//  Testmasking
//
//  Created by liujunjie on 15-7-13.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJViewController.h"
#import "LJDrawViewController.h"
@interface LJViewController ()<LJDrawViewControllerDelegate>

@end

@implementation LJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (void)drawViewControllerBackImage:(UIImage *)image {
    CGSize imageSize = [image size];
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageSize.width*0.5, imageSize.height*0.5)];
    [iv setImage:image];
    [iv setCenter:self.view.center];

    [self.view addSubview:iv];
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
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
}

@end
