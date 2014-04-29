//
//  NSArray+YYArray.h
//  BrutaalEngels
//
//  Created by Tim Pelgrim on 15/03/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (YYArray)

/**
 *  Randomizes the order of the array by using a Fisher-Yates shuffle
 *  Results are unbiased and performance is optimal
 *  
 *  See http://en.wikipedia.org/wiki/Fisher–Yates_shuffle
 */
-(NSArray *)YYShuffle;

/**
 *  Returns an unbiasedly-picked random item from the array
 *
 *  @return the item at the randomly selected index
 */
-(id)YYrandomItem;

@end
