//
//  SKDBird.m
//  SpriteKitDemo
//
//  Created by Raul Quispe on 6/10/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "SKDBird.h"
#define VERTICAL_SPEED 1 // la velocidad vertical
#define VERTICAL_DELTA 2.0 // es el valor de desplazamiento inicial vertical nota: puedes verificarlo antes de iniciar la mecanica del juego
@implementation SKDBird
static CGFloat deltaPosY = 0;
static bool goingUp = false;
- (id)init
{
    if(self = [super init]){

        // TODO : use texture atlas
    /*    SKTexture* birdTexture1 = [SKTexture textureWithImageNamed:@"bird_1"];
        birdTexture1.filteringMode = SKTextureFilteringNearest;
        SKTexture* birdTexture2 = [SKTexture textureWithImageNamed:@"bird_2"];
        birdTexture2.filteringMode = SKTextureFilteringNearest;
        SKTexture* birdTexture3 = [SKTexture textureWithImageNamed:@"bird_3"];
        birdTexture2.filteringMode = SKTextureFilteringNearest;

        self = [BirdNode spriteNodeWithTexture:birdTexture1];

        self.flap = [SKAction animateWithTextures:@[birdTexture1, birdTexture2,birdTexture3] timePerFrame:0.2];
        self.flapForever = [SKAction repeatActionForever:self.flap];

        [self setTexture:birdTexture1];
        [self runAction:self.flapForever withKey:@"flapForever"];*/
        SKTextureAtlas *textureAtlas =[SKTextureAtlas atlasNamed:@"Bird"];
        NSArray *imagesArray = [textureAtlas  textureNames];
        imagesArray = [imagesArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        textureArray = [NSMutableArray new];
        for (NSString*fileName in imagesArray) {
            SKTexture*texture=[textureAtlas textureNamed:fileName];
            [textureArray addObject:texture];
        }
        self = [SKDBird spriteNodeWithTexture:(SKTexture*)[textureArray objectAtIndex:0]];

        self.flap = [SKAction animateWithTextures:textureArray timePerFrame:0.2f];
        self.flapForever = [SKAction repeatActionForever:self.flap];

        
    }
    return self;
}

- (void) update:(NSUInteger) currentTime{
    if(!self.physicsBody){
        NSLog(@"deltaPos: %0.2f",deltaPosY);
        if(deltaPosY > VERTICAL_DELTA){
            goingUp = false;
        }
        if(deltaPosY < -VERTICAL_DELTA){
            goingUp = true;
        }

        float displacement = (goingUp)? VERTICAL_SPEED : -VERTICAL_SPEED;
        self.position = CGPointMake(self.position.x, self.position.y + displacement);
        deltaPosY += displacement;
    }

    // Rotate body based on Y velocity (front toward direction)
    self.zRotation = M_PI * self.physicsBody.velocity.dy * 0.0005;
}
- (void) startPlaying{
    deltaPosY = 0;
    // establecemos el cuerpo del bird nota: sirve para detectar la colision con los demas objetos
    [self setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(26, 18)]];
    self.physicsBody.categoryBitMask = birdBitMask;
    self.physicsBody.mass = 0.1;
    [self removeActionForKey:@"flapForever"];
}
- (void) bounce{

}
@end
