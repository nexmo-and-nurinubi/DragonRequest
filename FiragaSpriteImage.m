//
//  FiragaSpriteImage.m
//  DragonRequest
//
//  Created by apple on 2015/02/14.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "FiragaSpriteImage.h"

@implementation FiragaSpriteImage

- (void)initArray {
    UIImage *image01 = [self createImageArrayWithPosX:self.width*0 posY:self.height*0];
    UIImage *image02 = [self createImageArrayWithPosX:self.width*0 posY:self.height*1];
    UIImage *image03 = [self createImageArrayWithPosX:self.width*0 posY:self.height*2];
    UIImage *image04 = [self createImageArrayWithPosX:self.width*0 posY:self.height*3];
    UIImage *image05 = [self createImageArrayWithPosX:self.width*0 posY:self.height*4];
    UIImage *image06 = [self createImageArrayWithPosX:self.width*0 posY:self.height*5];
    UIImage *image07 = [self createImageArrayWithPosX:self.width*0 posY:self.height*6];
    UIImage *image08 = [self createImageArrayWithPosX:self.width*0 posY:self.height*7];
    self.spriteArray = @[image01, image02, image03, image04, image05, image06, image07, image08];
}

@end
