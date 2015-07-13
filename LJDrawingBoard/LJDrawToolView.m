//
//  LJDrawToolView.m
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJDrawToolView.h"
@interface LJButton : UIButton

@end
@implementation LJButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 3.0f;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1.0f;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

@end
@interface LJDrawToolView ()
{
    LJButton *_selectedbutton;
    NSArray *_names;
}
@end
@implementation LJDrawToolView
- (void)awakeFromNib {
    _names = @[@"写字",@"撤销",@"橡皮擦",@"清屏",@"保存",@"返回"];
    //添加所有按钮
    [self addAllBtn];
}
#pragma mark 添加所有按钮
- (void)addAllBtn {
    CGFloat width = (self.bounds.size.height - _names.count-1)/(_names.count*0.1);
    CGFloat height = self.bounds.size.height;
   
    NSInteger namesCount = [_names count]+1;
    for (NSInteger i = 1; i < namesCount; i ++) {
        CGFloat x = (i-1)*(width+1);
        CGFloat y = 0;
        
        LJButton * button = [LJButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(x, y, width, height)];
        [button setTag:i];
        [button setTitle:_names[i-1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 1) {
            _fristBtn = button;
        }
    }
  
}
- (void)click:(LJButton *)sender {
    [sender.layer setBorderColor:[UIColor redColor].CGColor];
    [_selectedbutton setSelected:NO];
    
    switch (sender.tag) {
        case 1:
            if ([_delegate respondsToSelector:@selector(drawToolViewWithDraw)]) {
                [_delegate drawToolViewWithDraw];
           }
            break;
        case 2:
            if ([_delegate respondsToSelector:@selector(drawToolViewWithUndo)]) {
                [_delegate drawToolViewWithUndo];
            }
            break;
        case 3:
            if ([_delegate respondsToSelector:@selector(drawToolViewWithEraser)]) {
                [_delegate drawToolViewWithEraser];
            }
            break;
        case 4:
            if ([_delegate respondsToSelector:@selector(drawToolViewWithClearScreen)]) {
                [_delegate drawToolViewWithClearScreen];
            }
            break;
        case 5:
        {
            if ([_delegate respondsToSelector:@selector(drawToolViewWithKeepImage)]) {
                
                [_delegate drawToolViewWithKeepImage];
            }
        }
        case 6:
        {
            if ([_delegate respondsToSelector:@selector(drawToolViewWithBack)]) {
                
                [_delegate drawToolViewWithBack];
            }
        }
            break;
        default:
            break;
    }
    if (_selectedbutton != sender) {
        [_selectedbutton.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
    [sender setSelected:YES];
    _selectedbutton = sender;
}
@end
