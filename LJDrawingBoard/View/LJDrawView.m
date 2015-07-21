//
//  LJDrawView.m
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJDrawView.h"
#import "LJDrawPath.h"
@interface LJDrawView ()
{
    // 当前的绘图路径
    CGMutablePathRef _drawPath;
}

// 恢复绘图路径数组
@property (strong, nonatomic) NSMutableArray *recoveryDrawPathArray;
//画笔颜色
@property (strong, nonatomic) UIColor *color;
@property (assign,nonatomic) CGFloat lineWidth;
@property (assign,nonatomic) BOOL pathReleased;
@property (assign,nonatomic) BOOL isEraser;

@end
@implementation LJDrawView
- (void)awakeFromNib {
    self.color = [UIColor blackColor];
    self.lineWidth = 2.0;
    
    
}
#pragma mark - 画图
- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawView:context];

}
- (void)drawView:(CGContextRef)context {
    // 1. 设置上下文属性
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    // 2.添加上次路径
    for (LJDrawPath *path in self.drawPathArray) {
        
        CGContextAddPath(context, path.drawPath.CGPath);
        CGContextSetLineWidth(context, path.lineWidth);
        [path.drawColor set];
        // 4. 绘制路径
        CGContextDrawPath(context, kCGPathStroke);
    }
    if (!self.pathReleased) {
        // 3. 添加路径
        CGContextAddPath(context, _drawPath);
        CGContextSetLineWidth(context, self.lineWidth);
        [self.color set];
        // 4. 绘制路径
        CGContextDrawPath(context, kCGPathStroke);
    }
    
}
#pragma mark - 触摸事件
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (_isEraser) {
        for (LJDrawPath *path in self.drawPathArray) {
            if (CGRectContainsPoint(path.drawPath.bounds, point)) {
                [self.recoveryDrawPathArray addObject:path];
                [self.drawPathArray removeObject:path];
                [self setNeedsDisplay];
                break;
            }
        }
    }else {
        _drawPath = CGPathCreateMutable();
        self.pathReleased = NO;
        // 在路径中记录触摸的初始点
        CGPathMoveToPoint(_drawPath, NULL, point.x, point.y);
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (_isEraser) {
        for (LJDrawPath *path in self.drawPathArray) {
            if (CGRectContainsPoint(path.drawPath.bounds, point)) {
                [self.recoveryDrawPathArray addObject:path];
                [self.drawPathArray removeObject:path];
                [self setNeedsDisplay];
                break;
            }
        }
    }else {
        CGPathAddLineToPoint(_drawPath, NULL, point.x, point.y);
        [self setNeedsDisplay];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!_isEraser) {
        // 一笔画完之后，将完整的路径添加到路径数组之中
        //懒加载
        if (self.drawPathArray == nil) {
            self.drawPathArray         = [NSMutableArray array];
            self.recoveryDrawPathArray = [NSMutableArray array];
        }
        // 要将CGPathRef添加到NSMutableArray之中，需要借助贝塞尔曲线对象
        // 贝塞尔曲线是UIKit对CGPathRef的一个封装，贝塞尔路径的对象可以直接添加到数组
        //    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:self.drawPath];
        LJDrawPath *path = [LJDrawPath drawPathWithCGPath:_drawPath  color:self.color lineWidth:self.lineWidth];
        [self.drawPathArray addObject:path];
        self.pathReleased = YES;
        CGPathRelease(_drawPath);
    }
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
#pragma mark -工具
#pragma mark 撤销
- (void)undo {
    // 要做撤销操作，需要把路径数组中的最后一条路径删除
    if (self.drawPathArray.lastObject) {
        [self.recoveryDrawPathArray addObject:[self.drawPathArray lastObject]];
        [self.drawPathArray removeLastObject];
        [self setNeedsDisplay];
    }

}
#pragma mark 橡皮擦
- (void)eraser:(BOOL)isEraser {
    _isEraser = isEraser;
    
}
#pragma mark 清屏
- (void)clearScreen {
    [self.drawPathArray removeAllObjects];
    [self setNeedsDisplay];
}
#pragma mark 恢复
- (void)recovery {
    // 要做恢复操作，需要把路径数组中的最后一条路径添加
    if (self.recoveryDrawPathArray.lastObject) {
        
        [self.drawPathArray addObject:[self.recoveryDrawPathArray lastObject]];
        [self.recoveryDrawPathArray removeLastObject];
        [self setNeedsDisplay];
    }
}
#pragma mark 上次痕迹
- (void)lastTrace:(NSArray *)drawPathArray {
    self.drawPathArray = (NSMutableArray *)drawPathArray;
    if (self.recoveryDrawPathArray == nil) {
        self.recoveryDrawPathArray = [NSMutableArray array];
    }
    [self setNeedsDisplay];
}
@end
