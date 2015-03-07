//
//  ViewController.m
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/11/24.
//  Copyright (c) 2014年 y.shibata. All rights reserved.
//

#import "ViewController.h"

#define MARGIN 8
#define BUTTON_WIDTH 20
#define ENEMY_MARINE_MAX 5
#define ENEMY_BOSS_MAX 200
#define ENEMY_BOSS_FIREST 0

@interface ViewController ()
<UIAlertViewDelegate>

@end

@implementation ViewController
{
    //heroオブジェクト
    MyHero      *_hero;
    //Bossオブジェクト
    EnemyBoss   *_enemyBoss[ENEMY_BOSS_MAX];
    //Marineオブジェクト
    EnemyMarine *_enemyMarine[ENEMY_MARINE_MAX];
    
    int cnt;    //ボスの攻撃頻度調整カウンタ
    NSTimer * timer;
    NSTimer * create;
    
    BOOL clearflag;
    BOOL heroaliveflag;
    
    int stagenumber;
    
    NSInteger score;
    NSInteger maxScore;
    
    __weak IBOutlet UILabel *topScore;
    __weak IBOutlet UILabel *scoreLabel;
    
}

//ここからアプリスタート
- (void)viewDidLoad {
    
    [super viewDidLoad];
    stagenumber = 1;
    
    //変数初期化
    maxScore = highScore;
    NSString *st = [NSString stringWithFormat:@"%zd",maxScore];
    topScore.text = st;
    score = initMainScore;
    NSString *ax = [NSString stringWithFormat:@"%zd",score];
    scoreLabel.text=ax;
    //    timer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(bossMove) userInfo:nil repeats:YES];
    //
    //    create = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(createBoss) userInfo:nil repeats:YES];
    //
    //    [timer fire];
    //    [create fire];
    
    
    //
    //    UILabel *label = [[UILabel alloc] init];
    //    label.frame = CGRectMake(10, 10, 100, 50);
    //    label.textColor = [UIColor colorWithRed:1.000 green:1.000 blue:1.000 alpha:1.0];
    //    label.font = [UIFont fontWithName:@"AppleGothic" size:20];
    //    label.text = ax;
    //    label.textAlignment = NSTextAlignmentCenter;
    //    [self.view addSubview:label];

//    timer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(bossMove) userInfo:nil repeats:YES];
//    
//    create = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(createBoss) userInfo:nil repeats:YES];
//    
//    [timer fire];
//    [create fire];
    [self reset];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches count : %lu (touchesBegan:withEvent:)", (unsigned long)[touches count]);
    //タッチイベントとタグを取り出す
    UITouch *touch = [touches anyObject];
    NSInteger tag = touch.view.tag;
    
    //タッチイベントから座標を取得
    CGPoint point = [touch locationInView:self.view];
    //画像(UIImageView)の中心座標とタッチイベントから取得した座標を同期
    
    for(int i=0;i<ENEMY_BOSS_MAX;i++)[_enemyBoss[i] moveRand];
    
    [_hero moveToPoint:point];
    
    //タッチしたのが敵なら攻撃する
    switch (tag) {
        case HumanTypeEnemy: {
            BOOL dead[ENEMY_MARINE_MAX];
            for(int i=0;i<ENEMY_MARINE_MAX;i++)dead[i] = NO;
            for(int i=0;i<ENEMY_MARINE_MAX;i++)
                dead[i] = [_hero fight:_enemyMarine[i]];
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
            {
                if (dead[i]) {
                    [_enemyMarine[i] removeImage];
                    _enemyMarine[i] = nil;
                }
            }
            break;
        }
        case HumanTypeHero: {
            // 処理なし
            break;
        }
        case HumanTypeBoss: {
            BOOL dead[ENEMY_BOSS_MAX];
            for(int i=0;i<ENEMY_BOSS_MAX;i++)dead[i] = NO;
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
                dead[i] = [_hero fight:_enemyBoss[i]];
            
            BOOL bossdead = true;
            
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
            {
                if (dead[i]) {
                    [_enemyBoss[i] removeImage];
                    _enemyBoss[i] = nil;
                    score +=bossDeadScore;
                    NSString *ax = [NSString stringWithFormat:@"%zd",score];
                    scoreLabel.text = ax;

                }
                
                if(_enemyBoss[i] != nil)
                {
                    bossdead = false;
                }
            }
            if(bossdead == true)
            {
                UIAlertView *alart = [[UIAlertView alloc] initWithTitle:@"Stage Clear"
                                                                message:@"次のステージに進みます" delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"YES", nil];
                if(score>=maxScore){
                    maxScore = score;
                    NSString *ax = [NSString stringWithFormat:@"%zd",score];
                    scoreLabel.text = ax;
                    NSString *st = [NSString stringWithFormat:@"%zd",maxScore];
                    topScore.text = st;
                    
                    
                }
                NSString *ax = [NSString stringWithFormat:@"%zd",score];
                scoreLabel.text=ax;

                [alart show];
                [_hero removeImage];
                clearflag = true;
                stagenumber++;
                if(stagenumber >= 3)
                {
                    stagenumber = 3;
                }
            }
            break;
        }
        default:
            break;
    }
}

- (void)bossMove{
    for(int i=0;i<ENEMY_BOSS_MAX;i++){
        [_enemyBoss[i]  moveRand];
        
        if(heroaliveflag == false)
        {
        
            if(cnt % 10 == 0){
                if([_enemyBoss[i]  fight:_hero]){
        //                [_hero removeImage];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over"
                                                                    message:@"コンティニューします"
                                                                   delegate:self
                                                          cancelButtonTitle:nil
                                                          otherButtonTitles:@"はい", nil];
                    if(score>=maxScore){
                        maxScore = score;
                        NSString *ax = [NSString stringWithFormat:@"%zd",score];
                        scoreLabel.text = ax;
                        NSString *st = [NSString stringWithFormat:@"%zd",maxScore];
                        topScore.text = st;
                        
                        
                    }
                    score = initMainScore;
                    NSString *ax = [NSString stringWithFormat:@"%zd",score];
                    scoreLabel.text=ax;

                    [alert show];
        //                [timer invalidate];
        //                [create invalidate];
                    stagenumber = 1;
                    [_hero removeImage];
                    heroaliveflag = true;
                    break;
                }
            }
        }
    }
    
    cnt++;
    

}

//アラートのボタンを押したとき
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(clearflag == true)
//    {
//        _fieldView.image = [UIImage imageNamed:@"mapbg02.png"];
//    }
//    else
//    {
//        _fieldView.image = [UIImage imageNamed:@"mapbg01.png"];
//    }
    [self reset];
    

}

//タイマーで設定した時間ごとにボスを生成
- (void)createBoss{
    for(int i=0;i<ENEMY_BOSS_MAX;i++){
        if(_enemyBoss[i] == nil){
            //Bossのインスタンス作成
            _enemyBoss[i] = [[EnemyBoss alloc] init:CGPointZero];
            _enemyBoss[i].alpha = 1.0;
            //Bossのイメージを設定
            [_enemyBoss[i] setImage:self.view];
            break;
        }
    }
    NSLog(@"aaaaa");
}


/** リセット */
- (void)reset {
    
    clearflag = false;
    heroaliveflag = false;
    
    
    int createtime = 0;
    switch (stagenumber) {
        case 1:
            _fieldView.image = [UIImage imageNamed:@"mapbg01.png"];
            createtime = bossCreatetime1;
            break;
        case 2:
            _fieldView.image = [UIImage imageNamed:@"mapbg02.png"];
            createtime = bossCreatetime2;
            break;
        case 3:
            _fieldView.image = [UIImage imageNamed:@"mapbg04.png"];
            createtime = bossCreatetime3;
            break;
            
        default:
            break;
    }
    
    
    for (int i=0;i<ENEMY_BOSS_MAX;i++){
        if(_enemyBoss[i] != nil){
            [_enemyBoss[i] removeImage];
            _enemyBoss[i] = nil;
        }
    }
    
    //hero インスタンス作成
    CGPoint heroPos = CGPointMake(screenSizeX/2,screenSizeY/2);
    _hero = [[MyHero alloc]init:heroPos];

    //hero イメージを設定
    [_hero setImage:self.view];
    
    for(int i=0;i<ENEMY_BOSS_FIREST;i++){
        //Bossのインスタンス作成
        _enemyBoss[i] = [[EnemyBoss alloc] init:CGPointZero];
        _enemyBoss[i].alpha = 1.0;
        //Bossのイメージを設定
        [_enemyBoss[i] setImage:self.view];
    }
    
    //heroのx、y座標
    _xPos = _hero.position.x;
    _yPos = _hero.position.y;
    
    _resetBtn.hidden = YES;
    
    if(timer == nil){
        timer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(bossMove) userInfo:nil repeats:YES];

        create = [NSTimer scheduledTimerWithTimeInterval:bossCreatetime1 target:self selector:@selector(createBoss) userInfo:nil repeats:YES];
    }
    
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:bossMoveTimeInterval]];
    [timer fire];
    [create setFireDate:[NSDate dateWithTimeIntervalSinceNow:createtime]];
    [create fire];
}
- (IBAction)resetAction:(id)sender {
    [self reset];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
