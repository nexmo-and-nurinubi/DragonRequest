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
    
    NSInteger _currentComma;
    //タイマー
    NSTimer *_humanTimer;
    

}


- (void)posInitWithPoint:(CGPoint)point
{
    if (point.x == 0 &&  point.y == 0) {
        if (_myHumanType == HumanTypeEnemy ) {
            point = CGPointMake(screenSizeX / 2, screenSizeY / 2);
        } else {
            CGFloat x = arc4random() % screenSizeX;
            CGFloat y = arc4random() % screenSizeY;
            point = CGPointMake(x, y);
        }
    }
    self.position = CGPointMake(point.x, point.y);
    
    _toPoint = CGPointMake(point.x, point.y);
    
    self.name = @"human";
    
    _power = 0;
    _level = 0;
    
    _stepX = humanStepX;
    _stepY = humanStepY;
    
    _reach = humanReach;
    
    _screenSizeX = screenSizeX;
    _screenSizeY = screenSizeY;
    
    _imageWidth = humanImageSizeWidth;
    _imageHeight = humanImageSizeHeight;
    
    _imageCutSizeWidth = humanImageCutSizeWidth;
    _imageCutSizeHeight= humanImageCutSizeHeight;
    
    _countComma = humanCountAnimComma;
    
    _animationImageView = nil;
    
    _humanTimer = nil;
    
    _currentComma = 0;
    
    // デフォルトでは透明度を１にしておく
    _alpha = 1;
    
    srand((unsigned)time(NULL));
}


- (id)init {
    
    self = [super init];
    
    if(self){
    
        _walkingSceanAnimArray = nil;

        _frontSceanAnimArray = nil;
        _backSceanAnimArray = nil;
        _leftSceanAnimArray = nil;
        _rightSceanAnimArray = nil;
        
        //_fightMultiSceanAnimArray = nil;
        
    }
    
    return self;
}

- (id)init :(CGPoint)initPos{

    self = [super init];
    
    if (self) {
        
        [self posInitWithPoint:initPos];
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
    UIImage *img = [UIImage imageNamed:@"powerBg.png"];
    
    if(_powerBgImageView == nil){
        _powerBgImageView = [[UIImageView alloc]initWithImage:img];
        _powerBgImageView.tag = HumanTypeBoss;
        _powerBgImageView.userInteractionEnabled = YES;
    }
    
    img = [UIImage imageNamed:@"powerImg.png"];
    
    if(_powerImageView == nil){
        _powerImageView = [[UIImageView alloc]initWithImage:img];
        _powerImageView.tag = HumanTypeBoss;
        _powerImageView.userInteractionEnabled = YES;
    }
    
    _powerBgImageView.frame = CGRectMake(self.position.x,self.position.y-humanPowerImgGapY,_imageWidth,humanPowerImgHeight);
    _powerImageView.frame = CGRectMake(self.position.x,self.position.y-humanPowerImgGapY,_imageWidth,humanPowerImgHeight);
    
    [parentView addSubview:_powerBgImageView];
    [parentView addSubview:_powerImageView];

    
    self.fightAnimationImageView = [[UIImageView alloc] init];
    [parentView addSubview:self.fightAnimationImageView];
    
}

-(void)setMoveAnimImage:(NSString *)originalImageName
                 countX:(int)countX
                 countY:(int)countY
{
    @try{
        
        UIImage *originalAnimationImage = [UIImage imageNamed:originalImageName];
        
        _walkingSceanAnimArray = [[DrUtil sharedInstance] animArrayList:originalAnimationImage
                                                               countX:countX
                                                               countY:countY
                                                       charactarWidth:_imageCutSizeWidth
                                                      charactarHeight:_imageCutSizeHeight];
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
}

-(void)setPowerImage:(NSInteger)power
{
    
    self.power = power;
    
    [self setPowerImage];
    
    
}

-(void)setPowerImage
{
    _powerBgImageView.frame = CGRectMake(self.position.x,self.position.y-humanPowerImgGapY,_imageWidth,humanPowerImgHeight);
    
    NSInteger powerWidth = (float)(_power/_defaultPower)*(_imageWidth/10.0);
    _powerImageView.frame = CGRectMake(self.position.x,self.position.y-humanPowerImgGapY,powerWidth,humanPowerImgHeight);
    
}

-(void)setFightAnimImage
{
    
}

-(void)setAnimation:(DirectionType)direction
{
    [self setPowerImage];
    
    NSArray *sceanAnimArray = nil;
    
    if (direction == DirectionTypeFromRightToLeft) {
        
        sceanAnimArray = _leftSceanAnimArray;
        
        
    }
    if (direction == DirectionTypeFromLeftToRight) {
        sceanAnimArray = _rightSceanAnimArray;
        
        
        
        
    }
    if (direction == DirectionTypeFromBottomToTop) {
        sceanAnimArray = _backSceanAnimArray;
        
        
        
    }
    if (direction == DirectionTypeFromTopToBottom) {
        sceanAnimArray = _frontSceanAnimArray;
        
        
    }
    
    if(_currentComma>=_countComma)_currentComma=0;
    
    _animationImageView.image = sceanAnimArray[_currentComma];

    _currentComma++;
    
    _animationImageView.frame = CGRectMake(self.position.x,
                                           self.position.y,
                                           _imageWidth,
                                           _imageHeight);
    
}

- (void)removeImage
{
    [_animationImageView removeFromSuperview];
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
    
}

- (BOOL)fight:(Human *)target {
    
    @try{
        
        if (ABS(self.animationImageView.center.x - target.animationImageView.center.x) <= _reach && ABS(self.animationImageView.center.y - target.animationImageView.center.y) <= _reach) {
            // バトルアニメーション
            self.fightAnimationImageView.frame = CGRectMake(0, 0, 64, 64);
            self.fightAnimationImageView.center = target.animationImageView.center;
            self.fightAnimationImageView.animationImages = _fightAnimArray[_level];
            self.fightAnimationImageView.animationDuration = 1.0;
            self.fightAnimationImageView.animationRepeatCount = 1.0;
            [self.fightAnimationImageView startAnimating];
            
            // 体力を減らす
            target.power -= self.minusPower;
            if (target.power <= 0) {
                return YES;
            }
        }
        
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
    return NO;
}


@end