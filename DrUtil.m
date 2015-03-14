//
//  BossSpriteImage.m
//  DragonRequest
//
//  Created by 長沢　遼 on 2015/01/17.
//  Copyright (c) 2015年 Apple. All rights reserved.
//


#import "DrUtil.h"

//インスターンスを１個しか作らないようにsharedInstanceにインスターンスを保存
static DrUtil* sharedInstance;

@implementation  DrUtil

/** 処理概要:ビジネスロジッククラスのシングルトンインスタンス取得
 * @param  :なし
 * @return :シングルトンインスタンス
 */
+ (DrUtil *)sharedInstance{
    
    @synchronized(self){
        
        if (!sharedInstance){
            sharedInstance = [[DrUtil alloc] init];
        }
        
    }
    
    return sharedInstance;
    
}

- (id)init{
    
    if (self = [super init]) {
        
        
    }
    
    return self;
}

- (NSArray *)animArray:(UIImage *)originalAnimationImage
                    countX:(NSInteger)countX
                    countY:(NSInteger)countY
            charactarWidth:(NSInteger)charactarWidth
           charactarHeight:(NSInteger)charactarHeiht{
    
    NSMutableArray *oneSceanAnimArray = [NSMutableArray array];
    
    for(int indexY=0;indexY<countY;indexY++){
        
        for(int indexX=0;indexX<countX;indexX++){
            
            CGRect trimArea = CGRectMake(charactarWidth*indexX,
                                         charactarHeiht*indexY,
                                         charactarWidth,
                                         charactarHeiht);
            
            CGImageRef imageRef = [originalAnimationImage CGImage];
            CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
            UIImage *oneImage = [UIImage imageWithCGImage:trimeImageRef];
            
            //エラーの場合リターン
            if(oneImage==nil)return nil;
            
            [oneSceanAnimArray addObject:oneImage];
            
        }
        
    }
    return [oneSceanAnimArray mutableCopy];
    
    
}

- (NSArray *)animArray:(UIImage *)originalAnimationImage
                countX:(NSInteger)countX
                countY:(NSInteger)countY
        charactarWidth:(NSInteger)charactarWidth
       charactarHeight:(NSInteger)charactarHeiht
            imageScale:(BOOL)imageScale {
    
    NSMutableArray *oneSceanAnimArray = [NSMutableArray array];
    CGFloat scale = imageScale ? originalAnimationImage.scale : 1;
    
    for(int indexY=0;indexY<countY;indexY++){
        
        for(int indexX=0;indexX<countX;indexX++){
            
            CGRect trimArea = CGRectMake(charactarWidth*scale*indexX,
                                         charactarHeiht*scale*indexY,
                                         charactarWidth*scale,
                                         charactarHeiht*scale);
            
            CGImageRef imageRef = [originalAnimationImage CGImage];
            CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
            UIImage *oneImage = [UIImage imageWithCGImage:trimeImageRef];
            
            //エラーの場合リターン
            if(oneImage==nil)return nil;
            
            [oneSceanAnimArray addObject:oneImage];
            
        }
        
    }
    return [oneSceanAnimArray mutableCopy];
}

- (NSMutableArray *)animArrayList:(UIImage *)originalAnimationImage
                    countX:(NSInteger)countX
                    countY:(NSInteger)countY
            charactarWidth:(NSInteger)charactarWidth
           charactarHeight:(NSInteger)charactarHeiht{
    
    NSMutableArray *multiSceanAnimArray = [NSMutableArray array];
    
    for(int indexY=0;indexY<countY;indexY++){
        
        NSMutableArray *oneSceanAnimArray = [NSMutableArray array];
        
        for(int indexX=0;indexX<countX;indexX++){
            
            CGRect trimArea = CGRectMake(charactarWidth*indexX,
                                         charactarHeiht*indexY,
                                         charactarWidth,
                                         charactarHeiht);
            
            CGImageRef imageRef = [originalAnimationImage CGImage];
            CGImageRef trimeImageRef = CGImageCreateWithImageInRect(imageRef, trimArea);
            UIImage *oneImage = [UIImage imageWithCGImage:trimeImageRef];
            
            //エラーの場合リターン
            if(oneImage==nil)return nil;
            
            [oneSceanAnimArray addObject:oneImage];
            
        }
        
        [multiSceanAnimArray addObject:oneSceanAnimArray];
        
    }
    
    return [multiSceanAnimArray mutableCopy];
    
}

@end
