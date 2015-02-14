//
//  SpriteImage.m
//  DragonRequest
//
//  Created by apple on 2015/02/14.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "SpriteImage.h"

@implementation SpriteImage

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

}

- (UIImage *)createImageArrayWithPosX:(int)posX posY:(int)posY {
    
    CGRect trimArea = CGRectMake(posX, posY, self.width, self.height);
    CGImageRef imageRef = [self.image CGImage];
    CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
    UIImage *trimeImage = [UIImage imageWithCGImage:trimeImageRef];
    
    return trimeImage;
}


@end
