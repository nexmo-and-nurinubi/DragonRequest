//
//  MyHero.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "MyHero.h"
#import "FireSpriteImage.h"
#import "FiraSpriteImage.h"

@implementation MyHero

- (id)init :(CGPoint)initPos{
    
    self = [super init:initPos];
    
    if (self) {
        
        _myHumanType = HumanTypeHero;
        
        self.name = heroDefaultName;
        
        self.power = heroDefaultPower;
        self.minusPower = heroMinusPower;
        
        _stepX = heroStepX;
        _stepY = heroStepY;
        
        _reach = heroReach;
        
        _imageWidth = heroImageSizeWidth;
        _imageHeight = heroImageSizeHeight;
        
    }
    return self;
}

- (id)initWithImageName:(NSString *)imageName
         charactarWidth:(int)charactarWidth
        charactarHeight:(int)charactarHeiht {
    
    if (self = [super init]) {
        
        _orgImage = [UIImage imageNamed:imageName];
        _width = charactarWidth;
        _height = charactarHeiht;
        
       
    }
    
    return self;
}

- (BOOL)fight:(Human *)target {
    
    //human super class
    if (ABS(self.animationImage.center.x - target.animationImage.center.x) <= _reach && ABS(self.animationImage.center.y - target.animationImage.center.y) <= _reach) {
        // バトルアニメーション
        SpriteImage *spriteImage;
        if(self.level == 1){
            spriteImage = [[FireSpriteImage alloc] initWithImageName:@"pipo-btleffect024.png" charactarWidth:240 charactarHeight:240];
        }
        else if(self.level == 2){
            spriteImage = [[FiraSpriteImage alloc] initWithImageName:@"pipo-btleffect037.png" charactarWidth:240 charactarHeight:240];
        }
        self.fightAnimationImage.frame = CGRectMake(0, 0, 64, 64);
        self.fightAnimationImage.center = target.animationImage.center;
        self.fightAnimationImage.animationImages = spriteImage.spriteArray;
        self.fightAnimationImage.animationDuration = 1.0;
        self.fightAnimationImage.animationRepeatCount = 1.0;
        [self.fightAnimationImage startAnimating];
        
        // 体力を減らす
        target.power -= self.minusPower;
        if (target.power <= 0) {
            return YES;
        }
    }
    
    return NO;
}

- (UIImage *)createImageArrayWithPosX:(int)posX posY:(int)posY {
    
    CGRect trimArea = CGRectMake(posX, posY, _imageWidth, _imageHeight);
    CGImageRef imageRef = [_orgImage CGImage];
    CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
    UIImage *trimeImage = [UIImage imageWithCGImage:trimeImageRef];
    
    return trimeImage;
}

-(void)setImage:(UIView *)parentView
{
    NSLog(@"myhero setImage");
    
    UIImage *img = [UIImage imageNamed:@"hero3.png"];
    
    if(self.animationImage == nil){
        self.animationImage = [[UIImageView alloc]initWithImage:img];
        self.animationImage.tag = HumanTypeHero;
        self.animationImage.userInteractionEnabled = YES;
    }
    
    self.animationImage.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    
    [parentView addSubview:self.animationImage];
    
    
    self.fightAnimationImage = [[UIImageView alloc] init];
    
    [parentView addSubview:self.fightAnimationImage];
}

-(void)setAnimation:(DirectionType)direction
{
    NSArray *ImsArray = nil;
    
    HeroSpriteImageTrim *scriptHeroImage = [[HeroSpriteImageTrim alloc] initWithImageName:@"hero1.png" charactarWidth:32 charactarHeight:32];
    
    if (direction == DirectionTypeFromRightToLeft) {
        
        ImsArray = scriptHeroImage.leftArray;


    }
    if (direction == DirectionTypeFromLeftToRight) {
        ImsArray = scriptHeroImage.rightArray;

    


    }
    if (direction == DirectionTypeFromBottomToTop) {
        ImsArray = scriptHeroImage.backArray;

 

    }
    if (direction == DirectionTypeFromTopToBottom) {
        ImsArray = scriptHeroImage.frontArray;


    }

    self.animationImage.animationImages = ImsArray;
    self.animationImage.animationDuration = 1;
    self.animationImage.frame = CGRectMake(self.position.x,self.position.y,
                                       heroImageSizeWidth,heroImageSizeHeight);

}

@end
