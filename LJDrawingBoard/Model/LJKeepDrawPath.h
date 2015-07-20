//
//  LJKeepDrawPath.h
//  LJDrawingBoard
//
//  Created by liujunjie on 15-7-20.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJKeepDrawPath : NSObject
/*存储画笔*/
+ (void)storageDrawPath:(NSArray *) drawPathArray onPage:(NSInteger)page;
/*读取画笔*/
+ (NSArray *)readDrawPathWithPage:(NSInteger)page;
@end
