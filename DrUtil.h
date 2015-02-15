//
//  BossSpriteImage.h
//  DragonRequest
//
//  Created by 長沢　遼 on 2015/01/17.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrUtil: NSObject

/** データマネージャ取得 */
+ (DrUtil *)sharedInstance;

- (id)init;
- (NSArray *)animArray:(UIImage *)originalAnimationImage
                countX:(NSInteger)countX
                countY:(NSInteger)countY
        charactarWidth:(NSInteger)charactarWidth
       charactarHeight:(NSInteger)charactarHeiht;

@end
