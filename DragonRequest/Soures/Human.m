//
//  Human.m
//  textgame
//
//  Created by masato_arai2 on 2014/11/05.
//  Copyright (c) 2014年 masato_arai2. All rights reserved.
//

#import "Human.h"

@implementation Human{

    CGPoint _toPoint;
    
    //タイマー
    NSTimer *_humanTimer;
    

}


- (void)posInitWithPoint:(CGPoint)point
{
    self.position = CGPointMake(point.x, point.y);
    
    _toPoint = CGPointMake(point.x, point.y);
    
    self.name = @"human";
    self.power = 0;
    
    _stepX = humanStepX;
    _stepY = humanStepY;
    
    _reach = humanReach;
    
    _screenSizeX = screenSizeX;
    _screenSizeY = screenSizeY;
    
    _imageWidth = humanImageSizeWidth;
    _imageHeight = humanImageSizeHeight;
    
    _animationImage = nil;
    
    _humanTimer = nil;
    
    // デフォルトでは透明度を１にしておく
    alphaFloat = 1;
    
    srand((unsigned)time(NULL));
}


- (id)init {
    
    self = [super init];
    
    return self;
}


- (id)init :(CGPoint)initPos{

    self = [super init];
    
    if (self) {
        
        [self posInitWithPoint:initPos];
    }
    
    return self;
   
}


/** 透明度を設定したい！！ */
- (id)init :(CGPoint)initPos
      alpha:(float)alpha {
    
    self = [super init];
    
    if (self) {
        
        [self posInitWithPoint:initPos];
        
        
        // 透明度を設定
        alphaFloat = alpha;
    }
    
    return self;
    
}



- (NSString *)whoAreYou {
    
    NSString *str = [NSString stringWithFormat:@"%@[ p:%zd : %zd ]",
                     self.name, self.power, _myHumanType];
    
    return str;
    
}

- (NSString *)whereAreYou{
    
    NSString *str = [NSString stringWithFormat:@" %@ [ %.0f : %.0f ]",self.name,self.position.x,self.position.y];
    
    return str;
}

- (BOOL)fight:(Human *)target {
    
    //human super class
    if (ABS(self.position.x - target.position.x) <= _reach && ABS(self.position.y - target.position.y) <= _reach) {
        target.power -= self.minusPower;
        if (target.power <= 0) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)sayToWin:(NSInteger)power {
    
    NSString *str = [NSString stringWithFormat:@"%@勝利! [ %ld ]",self.name,(long)power];
    
    return str;
    
}

- (NSString *)sayToDefeat:(NSInteger)power {
    
    NSString *str = [NSString stringWithFormat:@"%@敗北... [ %ld ]",self.name,(long)power];
    
    return str;
    
}
-(void)setImage:(UIView *)parentView
{
    
}

-(void)setAnimation:(DirectionType)direction
{
    
}

- (void)removeImage
{
    [_animationImage removeFromSuperview];
}

-(void)moveRand
{
    if (_moveRestCount == 0) {
        _direction = (DirectionType)arc4random() % 4;
        _moveRestCount = arc4random() % maxMoveCount + 1;
    }
    _moveRestCount--;
    
    [self move:_direction];
    
}
-(void)stopToWalk
{
    [_animationImage stopAnimating];
   
}



/** アニメーションの設定、開始 */
- (void)moveToPoint:(CGPoint)toPoint
{
    @try {

        if(_humanTimer!=nil){
         
            [_humanTimer invalidate];
            _humanTimer = nil;
            
        }
        
        _humanTimer = [NSTimer scheduledTimerWithTimeInterval:heroMoveTimeInterval target:self selector:@selector(moving) userInfo:nil repeats:YES];
        
        _toPoint.x = toPoint.x;
        _toPoint.y = toPoint.y;
        
        [_humanTimer fire];
    }
    @catch (NSException *exception) {
        
        NSLog(@"%@",exception.description);

    }
    @finally {

    }


}
-(void)moving
{
    CGPoint fromPoint = self.position;
    
    NSLog(@"fromPoint: %@",NSStringFromCGPoint(fromPoint));
    NSLog(@"toPoint: %@",NSStringFromCGPoint(_toPoint));
    
    if((abs(fromPoint.x - _toPoint.x)<=_stepX)&&
       (abs(fromPoint.y - _toPoint.y)<=_stepX)){
        
        [_humanTimer invalidate];
        
        return ;
        
    }
    
    float deltaX = _toPoint.x - fromPoint.x;
    float deltaY = _toPoint.y - fromPoint.y;
    
    DirectionType direction = DirectionTypeFromLeftToRight;
    
    if(deltaX>0){
        
        fromPoint.x+=_stepX;
        self.position = fromPoint;
        [self setAnimation:direction];
        
    }
    else if(deltaX<0){
        
        fromPoint.x-=_stepX;
        self.position = fromPoint;
        [self setAnimation:direction];
    }
    
    if(deltaY>0){
        
        fromPoint.y+=_stepY;
        self.position = fromPoint;
        [self setAnimation:direction];
        
    }
    else if(deltaY<0){
        
        fromPoint.y-=_stepY;
        self.position = fromPoint;
        [self setAnimation:direction];
    }
    
    if(abs(deltaX)>=abs(deltaY)){
        
        if(deltaX> 0)
            direction = DirectionTypeFromLeftToRight;
        else
            direction = DirectionTypeFromRightToLeft;
        
    }else{
        
        if(deltaY > 0)
            direction = DirectionTypeFromTopToBottom;
        else
            direction = DirectionTypeFromBottomToTop;
        
    }
    
    [self setAnimation:direction];
    [_animationImage startAnimating];
    
}

- (void)move:(DirectionType) direction
{
    
    //NSLog(@"position: %@",NSStringFromCGPoint(self.position));
    
    CGPoint position = self.position;
    
    switch (direction) {
            
        case DirectionTypeFromLeftToRight:
            //右
            position.x+=_stepX;
            
            break;
            
        case DirectionTypeFromRightToLeft:
            //左
            position.x-=_stepX;
            
            break;
            
        case DirectionTypeFromBottomToTop:
            //上
            position.y-=_stepY;
            break;
            
        case DirectionTypeFromTopToBottom:
            //下
            position.y+=_stepY;
            break;
            
        default:
            break;
    }
    
    position.x = MIN(MAX(0,position.x),_screenSizeX-_imageWidth);   //限界地点判別
    position.y = MIN(MAX(0,position.y),_screenSizeY-_imageHeight);  //限界地点判別
    
    self.position = position;
    
    [self setAnimation:direction];
    
    [_animationImage startAnimating];
    
}


@end
