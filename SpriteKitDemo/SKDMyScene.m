//
//  SKDMyScene.m
//  SpriteKitDemo
//
//  Created by Raul Quispe on 6/10/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "SKDMyScene.h"
#import "SKDBird.h"
@implementation SKDMyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        [self createBird];

    }
    return self;
}
#pragma mark - Scene
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [bird update:currentTime];

}
#pragma mark - Nodes
- (void)createBird
{
    bird = [SKDBird new];
    [bird setPosition:CGPointMake(100, CGRectGetMidY(self.frame))];
    [bird setName:@"bird"];
    [self addChild:bird];
}


@end
