//
//  SpriteImage.h
//  DragonRequest
//
//  Created by apple on 2015/02/14.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SpriteImage : NSObject

@property (nonatomic) UIImage *image;

@property (nonatomic) int width;
@property (nonatomic) int height;

//@property (nonatomic) NSString *imageName;

@property (nonatomic) NSArray *spriteArray;

- (id)initWithImageName:(NSString *)imageName
         charactarWidth:(int)charactarWidth
        charactarHeight:(int)charactarHeiht;
- (UIImage *)createImageArrayWithPosX:(int)posX posY:(int)posY;

@end
