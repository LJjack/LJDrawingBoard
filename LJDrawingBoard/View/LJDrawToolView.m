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
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"draw_btn_n"] forState:UIControlStateNormal];

        [self setBackgroundImage:[UIImage imageNamed:@"draw_btn_h"] forState:UIControlStateHighlighted];
        [self.titleLabel setFont:[UIFont fontWithDescriptor:[UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleSubheadline] size:17.0f]];
        [self setClipsToBounds:YES];
    }
    return self;
}
@end
@interface LJDrawToolView ()
{
    NSArray *_names;
}
@property (nonatomic, weak) LJButton *lastBtn;
@end
@implementation LJDrawToolView
- (void)awakeFromNib {
    _names = @[@"清空",@"上次痕迹",@"撤销",@"恢复",@"橡皮擦",@"上一页",@"下一页",@"保存",@"返回"];
    //添加所有按钮
    [self addAllBtn];
}
#pragma mark 添加所有按钮
- (void)addAllBtn {
    CGFloat width = 80;
    CGFloat height = self.bounds.size.height-20;
   
    NSInteger namesCount = [_names count]+1;
    for (NSInteger i = 1; i < namesCount; i ++) {
        CGFloat x = (i-1)*(width+1)+width*0.5;

        LJButton * button = [LJButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, width, height)];
        
        [button setCenter:CGPointMake(x, self.frame.size.height*0.5)];
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

    //1.清空 2.上次痕迹 3.撤销 4.恢复 5.橡皮擦 6.上一页 7.下一页 8.保存 9.返回
    switch (sender.tag) {
        case 1:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithClearScreen)]) {
                [_drawToolDelegate drawToolViewWithClearScreen];
            }
            break;
        case 2:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithLastTrace)]) {
                [_drawToolDelegate drawToolViewWithLastTrace];
            }
            break;
        case 3:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithUndo)]) {
                [_drawToolDelegate drawToolViewWithUndo];
            }
            break;
        case 4:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithRecovery)]) {
                [_drawToolDelegate drawToolViewWithRecovery];
            }
            break;
        case 5://橡皮擦
            [sender setBackgroundImage:[UIImage imageNamed:@"draw_btn_h"] forState:UIControlStateSelected];
            [sender setSelected:!sender.selected];

            
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithEraser:)]) {
                [_drawToolDelegate drawToolViewWithEraser:sender.selected];
            }
            
            break;
        case 6:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithPrevious)]) {
                
                [_drawToolDelegate drawToolViewWithPrevious];
            }
            break;
        case 7:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithNext)]) {
                
                [_drawToolDelegate drawToolViewWithNext];
            }
            break;
        case 8:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithKeepImage)]) {
                
                [_drawToolDelegate drawToolViewWithKeepImage];
            }
            break;
        case 9:
            if ([_drawToolDelegate respondsToSelector:@selector(drawToolViewWithBack)]) {
                
                [_drawToolDelegate drawToolViewWithBack];
            }
            break;
        default:
            break;
    }

}
@end
