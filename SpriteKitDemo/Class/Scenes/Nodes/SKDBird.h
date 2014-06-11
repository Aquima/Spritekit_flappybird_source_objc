//
//  SKDBird.h
//  SpriteKitDemo
//
//  Created by Raul Quispe on 6/10/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKDBird : SKSpriteNode{
    NSMutableArray*textureArray;
}
@property (strong,nonatomic) SKAction * flap;
@property (strong,nonatomic) SKAction * flapForever;

- (void) update:(NSUInteger) currentTime;
- (void) startPlaying;
- (void) bounce;
@end
