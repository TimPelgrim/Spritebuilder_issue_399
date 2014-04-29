//
//  BEGameFillInPlants.m
//  BrutaalEngels
//
//  Created by Tim Pelgrim on 17/02/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "TestScene.h"

@implementation TestScene
{

}

//==============================================
#pragma mark - CCNode
//==============================================

-(void)onEnter
{
    [super onEnter];
    
    CCSprite *node = (CCSprite *)[CCBReader load:@"TestNode"];
    node.position = ccp(100,100);
    [self addChild:node];
    
    CCActionScaleTo *scaleIn = [CCActionScaleTo actionWithDuration:0.8 scale:1.0f];
    CCActionEaseBounceOut *bounceIn = [CCActionEaseBounceOut actionWithAction:scaleIn];
    CCActionFadeIn *fadeIn = [CCActionFadeIn actionWithDuration:0.8];
    
    CCActionSpawn *animateIn = [CCActionSpawn actionWithArray:@[bounceIn,fadeIn]];
    
    CCActionDelay *startDelay = [CCActionDelay actionWithDuration:0.4];
    CCActionMoveTo *moveTo = [CCActionMoveTo actionWithDuration:0.5 position:ccp(200,200)];
    CCActionScaleTo *scaleTo = [CCActionScaleTo actionWithDuration:0.5 scale:0.01];
    CCActionSpawn *transform = [CCActionSpawn actionWithArray:@[moveTo,scaleTo]];
    CCActionRemove *remove = [CCActionRemove action];
    CCActionCallBlock *callBlock = [CCActionCallBlock actionWithBlock:^{CCLOG(@"Test");}];
    CCActionSequence *sequence = [CCActionSequence actionWithArray:@[animateIn,startDelay,transform,callBlock,remove]];
    
    [node runAction:sequence];
    node = nil;

}

@end
