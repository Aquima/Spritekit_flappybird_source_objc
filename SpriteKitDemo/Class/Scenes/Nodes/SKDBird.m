//
//  SKDBird.m
//  SpriteKitDemo
//
//  Created by Raul Quispe on 6/10/14.
//  Copyright (c) 2014 kodebinario. All rights reserved.
//

#import "SKDBird.h"
#define VERTICAL_SPEED 1 // la velocidad vertical
#define VERTICAL_DELTA 5.0 // es el valor de desplazamiento inicial vertical nota: puedes verificarlo antes de iniciar la mecanica del juego
@implementation SKDBird
static CGFloat deltaPosY = 0;
static bool goingUp = false;
- (id)init
{
    if(self = [super init]){
        //Usamos Texture Atlas
        SKTextureAtlas *textureAtlas =[SKTextureAtlas atlasNamed:@"Bird"];
        NSArray *imagesArray = [textureAtlas  textureNames];
        imagesArray = [imagesArray sortedArrayUsingSelector:@selector(localizedStandardCompare:)];
        textureArray = [[NSMutableArray alloc] init];
        for (NSString*fileName in imagesArray) {
            SKTexture*__weak texture=(SKTexture*)[textureAtlas textureNamed:fileName];
            [textureArray addObject:texture];
        }

        self.flap = [SKAction animateWithTextures:textureArray timePerFrame:0.2f];//accion volar
        self.flapForever = [SKAction repeatActionForever:self.flap];//accion volar por siempre
        
        sprite = [SKSpriteNode spriteNodeWithTexture:[textureArray firstObject]];
        [self addChild:sprite];
        [sprite runAction:self.flapForever withKey:@"flapForever"];
        textureAtlas=nil;
    }
    return self;
}

- (void) update:(NSUInteger) currentTime{

    if(!self.physicsBody){
      //  NSLog(@"deltaPos: %0.2f",deltaPosY);
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
    self.physicsBody.categoryBitMask = birdBitMask;// manejo de colisiones damos una categoria
    self.physicsBody.mass = 0.1;//masa para el pajarito le da mayor peso
    [self removeActionForKey:@"flapForever"];// removemos la accion volar por siempre
}
- (void) bounce{
    NSLog(@"%@",textureArray);

    [self.physicsBody setVelocity:CGVectorMake(0, 0)];
    [self.physicsBody applyImpulse:CGVectorMake(0, 40)];//impulso en el vector y de 40
    [self runAction:self.flap];//ejecutar accion
}
-(void)deletBird{
    [self removeAllActions];
     //[self removeActionForKey:@"flapForever"];
    [self removeAllChildren];
    [textureArray removeAllObjects];
}
@end
