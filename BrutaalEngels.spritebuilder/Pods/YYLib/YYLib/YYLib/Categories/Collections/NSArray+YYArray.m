//
//  NSArray+YYArray.m
//  BrutaalEngels
//
//  Created by Tim Pelgrim on 15/03/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "NSArray+YYArray.h"

@implementation NSArray (YYArray)


-(NSArray *)YYShuffle
{
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
    NSUInteger count = [mutableArray count];
    if (count > 1) {
        for (NSUInteger i = count - 1; i > 0; --i) {
            [mutableArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
        }
    }
    return [NSArray arrayWithArray:mutableArray];
}

-(id)YYrandomItem
{
    if ([self count] > 0)
    {
        return self[arc4random_uniform((u_int32_t)[self count])];
    }
    return nil;
}

@end
