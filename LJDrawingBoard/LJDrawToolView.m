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
        [self setBackgroundColor:
         [UIColor colorWithRed:44/255.0 green:114/255.0 blue:195/255.0 alpha:1.0]];

        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [self.titleLabel setFont:[UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline] size:17.0f]];
    }
    return self;
}

@end
@interface LJDrawToolView ()
{
    LJButton *_selectedbutton;
    NSArray *_names;
}
@property (nonatomic, weak) LJButton *lastBtn;
@end
@implementation LJDrawToolView
- (void)awakeFromNib {
    _names = @[@"写字",@"撤销",@"橡皮擦",@"清屏",@"保存",@"返回",@"上一页",@"下一页"];
    //添加所有按钮
    [self addAllBtn];
}
#pragma mark 添加所有按钮
- (void)addAllBtn {
    CGFloat width = (self.bounds.size.height - _names.count-1)/(_names.count*0.1);
    CGFloat height = self.bounds.size.height;
   
    NSInteger namesCount = [_names count]+1;
    for (NSInteger i = 1; i < namesCount; i ++) {
        CGFloat x = (i-1)*(width+1)+width*0.5;

        LJButton * button = [LJButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, width, height)];
        
        [button setCenter:CGPointMake(x, CGRectGetMidY(self.frame))];
        [button setTag:i];
        [button setTitle:_names[i-1] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 1) {
            _fristBtn = button;
        }
        if (i == namesCount-1) {
            _lastBtn = button;
        }
    }
    [self setContentSize:CGSizeMake(CGRectGetMaxX(_lastBtn.frame), 0)];
}
- (void)click:(LJButton *)sender {

    [_selectedbutton setSelected:NO];
    
    switch (sender.tag) {
        case 1:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithDraw)]) {
                [_drawToolDelegate drawToolViewWithDraw];
           }
            break;
        case 2:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithUndo)]) {
                [_drawToolDelegate drawToolViewWithUndo];
            }
            break;
        case 3:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithEraser)]) {
                [_drawToolDelegate drawToolViewWithEraser];
            }
            break;
        case 4:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithClearScreen)]) {
                [_drawToolDelegate drawToolViewWithClearScreen];
            }
            break;
        case 5:
        {
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithKeepImage)]) {
                
                [_drawToolDelegate drawToolViewWithKeepImage];
            }
        }
        case 6:
        {
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithBack)]) {
                
                [_drawToolDelegate drawToolViewWithBack];
            }
        }
        case 7:
        {
            
        }
        case 8:
        {
           
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
