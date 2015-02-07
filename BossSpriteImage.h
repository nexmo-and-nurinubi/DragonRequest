//
//  BossSpriteImage.h
//  DragonRequest
//
//  Created by 長沢　遼 on 2015/01/17.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BossSpriteImage: NSObject


@property (nonatomic) UIImage *image;

@property (nonatomic) int width;
@property (nonatomic) int height;


//@property (nonatomic) NSString *imageName;

@property (nonatomic) NSArray *frontArray;
@property (nonatomic) NSArray *backArray;
@property (nonatomic) NSArray *leftArray;
@property (nonatomic) NSArray *rightArray;

- (id)initWithImageName:(NSString *)imageName
         charactarWidth:(int)charactarWidth
        charactarHeight:(int)charactarHeiht;



@end
