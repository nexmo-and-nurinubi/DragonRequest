//
//  FiraSpriteImage.m
//  DragonRequest
//
//  Created by apple on 2015/02/14.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "FiraSpriteImage.h"

@implementation FiraSpriteImage

- (id)initWithImageName:(NSString *)imageName
         charactarWidth:(int)charactarWidth
        charactarHeight:(int)charactarHeiht {
    
    if (self = [super init]) {
        
        self.image = [UIImage imageNamed:imageName];
        self.width = charactarWidth;
        self.height = charactarHeiht;
        
        [self initArray];
    }
    
    return self;
}

- (void)initArray {
    UIImage *image01 = [self createImageArrayWithPosX:self.width*0 posY:self.height*0];
    UIImage *image02 = [self createImageArrayWithPosX:self.width*1 posY:self.height*0];
    UIImage *image03 = [self createImageArrayWithPosX:self.width*2 posY:self.height*0];
    UIImage *image04 = [self createImageArrayWithPosX:self.width*3 posY:self.height*0];
    UIImage *image05 = [self createImageArrayWithPosX:self.width*4 posY:self.height*0];
    UIImage *image06 = [self createImageArrayWithPosX:self.width*5 posY:self.height*0];
    UIImage *image07 = [self createImageArrayWithPosX:self.width*6 posY:self.height*0];
    UIImage *image08 = [self createImageArrayWithPosX:self.width*7 posY:self.height*0];
    self.spriteArray = @[image01, image02, image03, image04, image05, image06, image07, image08];
}

@end
