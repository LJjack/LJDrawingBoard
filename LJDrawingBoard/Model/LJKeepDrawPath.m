//
//  LJKeepDrawPath.m
//  LJDrawingBoard
//
//  Created by liujunjie on 15-7-20.
//  Copyright (c) 2015年 rj. All rights reserved.
//

#import "LJKeepDrawPath.h"

@implementation LJKeepDrawPath
+ (void)storageDrawPath:(NSArray *) drawPathArray onPage:(NSInteger)page{
    NSString *path = [NSString stringWithFormat:@"drawPathPage%ld",(long)page];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:drawPathArray];
    [defaults setObject:data forKey:path];
    [defaults synchronize];
}
+ (NSArray *)readDrawPathWithPage:(NSInteger)page {
    NSString *path = [NSString stringWithFormat:@"drawPathPage%ld",(long)page];
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:path];
    return (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
}
@end
