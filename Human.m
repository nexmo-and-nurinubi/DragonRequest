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
    

    NSArray *_effectFileNameArray;
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

- (id)init :(CGPoint)initPos
        tag:(NSInteger)tag
{

    self = [super init];
    
    if (self) {
        
        self.name = @"human";
        
        [self setPower:0 defaultPower:0];
        self.minusPower = 0;
        
        _level = 0;
        
        _tag = tag;
        
        _stepX = humanStepX;
        _stepY = humanStepY;
        
        _reach = humanReach;
        
        _imageWidth = humanImageSizeWidth;
        _imageHeight = humanImageSizeHeight;
        
        _imageCutSizeWidth = humanImageCutSizeWidth;
        _imageCutSizeHeight= humanImageCutSizeHeight;
        
        _countComma = humanCountAnimComma;
        
        _animationImageView = nil;
        
        _humanTimer = nil;
        
        _moveRestCount = 0;
        
        _currentComma = 0;
        
        // デフォルトでは透明度を１にしておく
        _alpha = 1;
        
        srand((unsigned)time(NULL));

        [self posInitWithPoint:initPos];
    }
    
    return self;
   
}

- (void)posInitWithPoint:(CGPoint)point
{
    if (point.x == 0 &&  point.y == 0) {
        if (self.myHumanType == HumanTypeEnemy ) {
            point = CGPointMake([common screenSizeWidth] / 2, [common screenSizeHeight] / 2);
        } else {
            CGFloat x = arc4random() % [common screenSizeWidth];
            CGFloat y = arc4random() % [common screenSizeHeight];
            point = CGPointMake(x, y);
        }
    }
    self.position = CGPointMake(point.x, point.y);
    
    _toPoint = CGPointMake(point.x, point.y);
    
}

- (NSString *)whoAreYou {
    
    NSString *str = [NSString stringWithFormat:@"%@[ p:%zd : %zd ]",
                     self.name, self.power, self.myHumanType];
    
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

-(void)setImage:(UIView *)parentView belowSubview:(UIView *)siblingSubview
{
    UIImage *img = [UIImage imageNamed:@"powerBg.png"];
    
    if(_powerBgImageView == nil){
        _powerBgImageView = [[UIImageView alloc]initWithImage:img];
        _powerBgImageView.userInteractionEnabled = YES;
    }
    
    img = [UIImage imageNamed:@"powerImg.png"];
    
    if(_powerImageView == nil){
        _powerImageView = [[UIImageView alloc]initWithImage:img];
        _powerImageView.userInteractionEnabled = YES;
    }

    [self setPowerImage];
    
    [parentView insertSubview:_powerBgImageView belowSubview:siblingSubview];
    [parentView insertSubview:_powerImageView belowSubview:siblingSubview];

    
    self.fightAnimationImageView = [[UIImageView alloc] init];
    self.fightAnimationImageView.tag = _tag;

    [parentView insertSubview:self.fightAnimationImageView belowSubview:siblingSubview];
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

-(void)setPower:(float)power defaultPower:(float)defaultPower {
    _defaultPower = defaultPower;
    
    // powerがdefaultPowerを上回るのを防ぐため
    if (power > defaultPower) {
        _power = defaultPower;
    } else {
        _power = power;
    }
}

-(void)addPower:(float)power defaultPower:(float)defaultPower {
    _power += power;
    _defaultPower += defaultPower;
    [self setPower:_power defaultPower:_defaultPower];
}

-(void)setPowerImage:(NSInteger)power
{
    
    self.power = power;
    
    [self setPowerImage];
    
    
}

-(void)setPowerImage
{
    NSInteger xx = self.position.x + _imageWidth/4.0;
    
    _powerBgImageView.frame = CGRectMake(xx,self.position.y-humanPowerImgGapY,_imageWidth/2.0,humanPowerImgHeight);
    
    float bgImageWidth = _powerBgImageView.frame.size.width;
    
    NSInteger powerWidth = (float)(self.power/self.defaultPower)*bgImageWidth;
    _powerImageView.frame = CGRectMake(xx,self.position.y-humanPowerImgGapY,powerWidth,humanPowerImgHeight);
    
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
    [_powerBgImageView removeFromSuperview];
    [_powerImageView removeFromSuperview];
}

-(BOOL)moveRand:(Human *)target
{
    BOOL ret = NO;
    
    //敵が近くにいるか
    NSInteger xGap = ABS(self.animationImageView.center.x - _target.animationImageView.center.x);
    NSInteger yGap = ABS(self.animationImageView.center.y - _target.animationImageView.center.y);
    
    //視野外ならランダムで移動
    if (_moveRestCount % 3) {
        
        _direction = (DirectionType)arc4random() % 4;
        _moveRestCount = arc4random() % maxMoveCount + 1;
        
    }
    else{
        
        if (xGap <= _radarRange && yGap <= _radarRange ) {
            
            [self moveToPoint:_target.position];
            [self fight:target];
            
        }
        
        
    }
    
    _moveRestCount--;
    
    [self move:_direction];

    return ret;
    
}

-(void)stopToWalk
{
   
}

/** アニメーションの設定、開始 */
- (void)gotoToPoint:(CGPoint)toPoint
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

/** アニメーションの設定、開始 */
- (void)moveToPoint:(CGPoint)toPoint
{
    CGPoint fromPoint = self.position;
    
    float deltaX = toPoint.x - fromPoint.x;
    float deltaY = toPoint.y - fromPoint.y;
    
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
    
    position.x = MIN(MAX(0,position.x),[common screenSizeWidth]-_imageWidth);   //限界地点判別
    position.y = MIN(MAX(0,position.y),[common screenSizeHeight]-_imageHeight);  //限界地点判別
    
    self.position = position;
    
    [self setAnimation:direction];
    
}

- (void)moveToFront:(UIView *)superview
{
    [superview bringSubviewToFront:self.animationImageView];
    [superview bringSubviewToFront:_powerBgImageView];
    [superview bringSubviewToFront:_powerImageView];
    
}

- (BOOL)setEnemy:(Human *)target {
    
    @try{
        _target = target;
    }
    @catch(NSException *exception){
        
        NSLog(@"%@",exception);
    }
    @finally{
        
    }
    
    return NO;
}


- (BOOL)fight:(Human *)target {
    
    @try{
        
        if([self enemyIsNear:target]==YES){
            
            if(target.power > 0){
                
                // バトルアニメーション
                self.fightAnimationImageView.frame = CGRectMake(0, 0, humanFightImageSizeWidth, humanFightImageSizeHeight);
                self.fightAnimationImageView.center = target.animationImageView.center;
                self.fightAnimationImageView.animationImages = _fightAnimArray[0][_level];
                self.fightAnimationImageView.animationDuration = 1.0;
                self.fightAnimationImageView.animationRepeatCount = 1.0;
                [self.fightAnimationImageView startAnimating];
                
                [UIView animateWithDuration:fightDuration
                                      delay:0.0
                                    options:UIViewAnimationOptionAutoreverse
                                 animations:^{
                                     target.animationImageView.alpha = 0;
                                 } completion:^(BOOL finished) {
                                     target.animationImageView.alpha = 1;
                                 }];
                
                // 体力を減らす
                target.power -= self.minusPower;
                if (target.power <= 0) {
                    return YES;
                }
                
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

- (BOOL)enemyIsNear:(Human *)target
{
    //敵が近くにいるか
//    NSInteger xGap = ABS(self.animationImageView.center.x - _target.animationImageView.center.x);
//    NSInteger yGap = ABS(self.animationImageView.center.y - _target.animationImageView.center.y);

    NSLog(@"(%zd,%zd)(%zd,%zd)",self.position.x,self.position.y,
          _target.position.x,_target.position.y);
    
    NSInteger xGap = ABS(self.position.x - _target.position.x);
    NSInteger yGap = ABS(self.position.y - _target.position.y);
    
    if (xGap <= _reach && yGap <= _reach ) {
        
        return YES;
        
    }
    
    return NO;
}


@end
