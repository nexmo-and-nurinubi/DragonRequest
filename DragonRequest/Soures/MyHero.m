//
//  MyHero.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "MyHero.h"

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
    
    if(_animationImage == nil){
        _animationImage = [[UIImageView alloc]initWithImage:img];
        _animationImage.tag = HumanTypeHero;
        _animationImage.userInteractionEnabled = YES;
    }
    
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,_imageWidth,_imageHeight);
    
    [parentView addSubview:_animationImage];
    
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

    _animationImage.animationImages = ImsArray;
    _animationImage.animationDuration = 1;
    _animationImage.frame = CGRectMake(self.position.x,self.position.y,
                                       heroImageSizeWidth,heroImageSizeHeight);

}

@end
