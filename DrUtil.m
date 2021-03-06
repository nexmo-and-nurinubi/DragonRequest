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



- (id)init {
    
    if (self = [super init]) {
        

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath = nil;
        
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:bgFileName01];
        _backgroundImage01 = [UIImage imageWithContentsOfFile:filePath];
        
        if(_backgroundImage01==nil){
            
            _backgroundImage01 =[UIImage imageNamed:@"mapbg01.png"];
            
        }
        
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:bgFileName02];
        _backgroundImage02 = [UIImage imageWithContentsOfFile:filePath];
        
        if(_backgroundImage02==nil){
            
            _backgroundImage02 =[UIImage imageNamed:@"mapbg02.png"];
            
        }
        
        filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:bgFileName03];
        _backgroundImage03 = [UIImage imageWithContentsOfFile:filePath];
        
        if(_backgroundImage03==nil){
            
            _backgroundImage03 =[UIImage imageNamed:@"mapbg04.png"];
            
        }
        
    }
    
    return self;
}

- (NSArray *)animArray:(UIImage *)originalAnimationImage
                    countX:(NSInteger)countX
                    countY:(NSInteger)countY
            charactarWidth:(NSInteger)charactarWidth
           charactarHeight:(NSInteger)charactarHeiht{
    
    NSMutableArray *oneSceanAnimArray = [NSMutableArray array];

    @try{
        
        
        charactarWidth = (NSInteger)originalAnimationImage.size.width/countX*originalAnimationImage.scale;
        charactarHeiht = (NSInteger)originalAnimationImage.size.height/countY*originalAnimationImage.scale;
        
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
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
    return [oneSceanAnimArray mutableCopy];
    
    
}

- (NSMutableArray *)animArrayList:(UIImage *)originalAnimationImage
                    countX:(NSInteger)countX
                    countY:(NSInteger)countY
            charactarWidth:(NSInteger)charactarWidth
           charactarHeight:(NSInteger)charactarHeiht{
    
    NSMutableArray *multiSceanAnimArray = [NSMutableArray array];
    
    @try{
        
        charactarWidth = (NSInteger)originalAnimationImage.size.width/countX*originalAnimationImage.scale;
        charactarHeiht = (NSInteger)originalAnimationImage.size.height/countY*originalAnimationImage.scale;
        
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
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
    
    return [multiSceanAnimArray mutableCopy];
    
}

@end
