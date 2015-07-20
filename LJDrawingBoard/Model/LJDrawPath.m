//
//  LJDrawPath.m
//  Testmasking
//
//  Created by liujunjie on 15-7-10.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJDrawPath.h"

@implementation LJDrawPath
+ (id)drawPathWithCGPath:(CGPathRef)drawPath
                   color:(UIColor *)color
               lineWidth:(CGFloat)lineWidth {
    LJDrawPath *path = [[LJDrawPath alloc] init];
    path.drawPath = [UIBezierPath bezierPathWithCGPath:drawPath];
    path.drawColor = color;
    path.lineWidth = lineWidth;
    return path;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_drawPath forKey:@"_drawPath"];
    [aCoder encodeObject:_drawColor forKey:@"_drawColor"];
    [aCoder encodeObject:@(_lineWidth) forKey:@"_lineWidth"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.drawPath = [aDecoder decodeObjectForKey:@"_drawPath"];
        self.drawColor = [aDecoder decodeObjectForKey:@"_drawColor"];
        self.lineWidth = [[aDecoder decodeObjectForKey:@"_lineWidth"] doubleValue];
    }
    return self;
}
@end
