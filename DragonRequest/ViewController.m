//
//  ViewController.m
//  NurinubiGame
//
//  Created by 柴田　義也 on 2014/11/24.
//  Copyright (c) 2014年 y.shibata. All rights reserved.


//背景画像取得ページ
//  http://piposozai.wiki.fc2.com

#import "ViewController.h"
#import "DropItemController.h"
#import "DropItemImageView.h"

#import <AVFoundation/AVFoundation.h>

#define MARGIN 8
#define BUTTON_WIDTH 20
#define ENEMY_MARINE_MAX 200
#define ENEMY_MARINE_FIREST 0
#define ENEMY_BOSS_MAX 200
#define ENEMY_BOSS_FIREST 0

@interface ViewController ()

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
    int createCnt;
    NSTimer * _storyTimer;
    NSTimer * _createTimer;
    
    BOOL clearflag;
    BOOL heroaliveflag;
    
    int stagenumber;
    
    NSInteger score;
    NSInteger topScore;
    
    __weak IBOutlet UILabel *topScoreLabel;
    __weak IBOutlet UILabel *scoreLabel;
    __weak IBOutlet UILabel *playerNameLabel;
    __weak IBOutlet UIImageView *gcPlayerPictureImage;
    
    NSString *clearmes;
    
    DrUtil *_utilManager;
    
    AVAudioPlayer *deadSound;
    
    NSUserDefaults* defaults;
    NSMutableArray *scoreArray;
    
}

//ここからアプリスタート
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _utilManager = [DrUtil sharedInstance];
    
    defaults = [NSUserDefaults standardUserDefaults];
    topScore = [defaults integerForKey:@"TOPSCORE"];
    
    topScoreLabel.text = [@(topScore) stringValue];
    score = initMainScore;
    scoreLabel.text = [@(score) stringValue];
    
    // Set GameCenter Manager Delegate
    [[GameCenterManager sharedManager] setDelegate:self];

    stagenumber = 1;
    
    [self reset];
    
    //タッチイベントから座標を取得
    CGPoint point = CGPointMake(_hero.position.x, _hero.position.y);
    //画像(UIImageView)の中心座標とタッチイベントから取得した座標を同期
    [_hero gotoToPoint:point];

    // AudioPlayerの生成
    NSString *path = [[NSBundle mainBundle] pathForResource : @"07" ofType :@"wav"];
    deadSound = [[AVAudioPlayer alloc ] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [deadSound prepareToPlay];
    
}


// オブジェクトの並べ替え
- (void)bringObject
{
    for (int y = 0; y < self.view.bounds.size.height; y++) {
        for (int i = 0; i < ENEMY_MARINE_MAX; i++) {
            if (_enemyMarine[i].animationImageView.frame.origin.y == y && _enemyMarine[i])
                [self.view bringSubviewToFront:_enemyMarine[i].animationImageView];
        }
        if (_hero.animationImageView.frame.origin.y == y && _hero)
            [self.view bringSubviewToFront:_hero.animationImageView];
    }
    
    for (int y = 0; y < self.view.bounds.size.height; y++) {
        for (int i = 0; i < ENEMY_BOSS_MAX; i++) {
            if (_enemyBoss[i].animationImageView.frame.origin.y == y && _enemyBoss[i])
                [self.view bringSubviewToFront:_enemyBoss[i].animationImageView];
        }
    }
    
    // ToDo. 必要に応じて、DropItemImageViewも追加
    
    [self.view bringSubviewToFront:_weaponCollectionView];
    [self.view bringSubviewToFront:topScoreLabel];
    [self.view bringSubviewToFront:scoreLabel];
    [self.view bringSubviewToFront:playerNameLabel];
    [self.view bringSubviewToFront:gcPlayerPictureImage];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    BOOL available = [[GameCenterManager sharedManager] checkGameCenterAvailability];
    if (available) {
        gcPlayerPictureImage.image = [UIImage imageNamed:@"gamecenter"];
    } else {
        gcPlayerPictureImage.image = nil;
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    if (player) {
        if ([player isUnderage] == NO) {
//            actionBarLabel.title = [NSString stringWithFormat:@"%@ signed in.", player.displayName];
//            playerStatus.text = @"Player is not underage";
            playerNameLabel.text = player.displayName;
            [[GameCenterManager sharedManager] localPlayerPhoto:^(UIImage *playerPhoto) {
                gcPlayerPictureImage.image = playerPhoto;
            }];
        } else {
//            playerStatus.text = @"Player is underage";
//            actionBarLabel.title = [NSString stringWithFormat:@"Underage player, %@, signed in.", player.displayName];
            playerNameLabel.text = player.displayName;
        }
    } else {
        playerNameLabel.text = [NSString stringWithFormat:@"Please login"];
    }
}


// 敵を倒した時の処理
- (void)deadWithCharactor:(Human *)enemy type:(int)type
{
    int point = 0;
    if (type == HumanTypeBoss) {
        point = bossDeadScore;
    } else if (type == HumanTypeEnemy) {
        point = marineDeadScore;
    }
    
    // DropItemの生成
    DropItemType dropItemType = [DropItemController randDropItemType];
    if ([DropItemController isCreateDropItem:dropItemType]) {
        DropItemImageView *dropItemImageView = [[DropItemImageView alloc] initWithPoint:enemy.animationImageView.center dropItemType:dropItemType];
        [self.view addSubview:dropItemImageView];
    }
    
    [enemy removeImage];
    enemy = nil;
    score += point;
    scoreLabel.text = [@(score) stringValue];
    
    
    // 敵を倒した時の音を再生
    [deadSound stop];
    deadSound.currentTime = 0;
    [deadSound play];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches count : %lu (touchesBegan:withEvent:)", (unsigned long)[touches count]);
    //タッチイベントとタグを取り出す
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    NSInteger tag = view.tag;
    
    //タッチイベントから座標を取得
    CGPoint point = [touch locationInView:self.view];
    //画像(UIImageView)の中心座標とタッチイベントから取得した座標を同期
    
    //for(int i=0;i<ENEMY_BOSS_MAX;i++)[_enemyBoss[i] moveRand];
    //for(int i=0;i<ENEMY_MARINE_MAX;i++)[_enemyMarine[i] moveRand];
    
    [_hero gotoToPoint:point];
    
    //タッチしたのがDropItemなら拾う
    if ([view isKindOfClass:[DropItemImageView class]]) {
        DropItemType dropItemType = (DropItemType)tag;
        switch (dropItemType) {
            case DropItemTypeNone:
                DLog(@"Error: DropItemType is DropItemTypeNone.");
                break;
            case DropItemTypeStatusUp:
                // ToDo
                break;
            case DropItemTypeMagic:
                // ToDo
                break;
            case DropItemTypeWeapon:
                // ToDo
                break;
        }
    }
    
    //タッチしたのが敵なら攻撃する
    switch (tag) {
        case HumanTypeEnemy: {
            BOOL dead[ENEMY_MARINE_MAX];
            for(int i=0;i<ENEMY_MARINE_MAX;i++)
                dead[i] = NO;
            for(int i=0;i<ENEMY_MARINE_MAX;i++)
                dead[i] = [_hero fight:_enemyMarine[i]];
            for(int i=0;i<ENEMY_MARINE_MAX;i++) {
                if (dead[i]) {
                    [self deadWithCharactor:_enemyMarine[i] type:HumanTypeEnemy];
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
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
                dead[i] = NO;
            for(int i=0;i<ENEMY_BOSS_MAX;i++)
                dead[i] = [_hero fight:_enemyBoss[i]];
            for(int i=0;i<ENEMY_BOSS_MAX;i++) {
                if (dead[i]) {
                    [self deadWithCharactor:_enemyBoss[i] type:HumanTypeBoss];
                }
            }
            break;
        }
        default:
            break;
    }
    

}

- (void)checkGameStory{
    
    [self bringObject];
    
    for(int i=0;i<ENEMY_MARINE_MAX;i++){
        
        [_enemyMarine[i]  moveRand];
        
    }
    for(int i=0;i<ENEMY_BOSS_MAX;i++){
        
        [_enemyBoss[i]  moveRand];

    }
    
    if(_hero.power<=0.0){

        [_storyTimer invalidate];
        [_createTimer invalidate];
        
        // Here we need to pass a full frame
        CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
        
        // Add some custom content to the alert view
        [alertView setContainerView:[self createDemoView]];
        
        // Modify the parameters
        [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Continue", @"Menu", nil]];
        [alertView setDelegate:self];
        
        // You may use a Block, rather than a delegate.
        [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
            NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
            [alertView close];
        }];
        
        [alertView setUseMotionEffects:true];
        
        // And launch the dialog
        [alertView show];
        
        if(score>=topScore){
            topScore = score;
            scoreLabel.text = [@(score) stringValue];
            topScoreLabel.text = [@(topScore) stringValue];
            
            
        }
        
    }

/*
    // 敵が殲滅したか確認する
    BOOL annihilate = YES;
    if (annihilate) {
        for (int i = 0; i<ENEMY_MARINE_MAX; i++) {
            if (_enemyMarine[i]) {
                annihilate = NO;
                break;
            }
        }
    }
    if (annihilate) {
        for (int i = 0; i<ENEMY_BOSS_MAX; i++) {
            if (_enemyBoss[i]) {
                annihilate = NO;
                break;
            }
        }
    }
    
    // ステージクリア
    if(annihilate) {
        UIAlertView *alart = [[UIAlertView alloc] initWithTitle:@"Stage Clear"
                                                        message:clearmes delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"YES", nil];
        
        // スコアをNSUserDefaultsに配列で保存
        [scoreArray addObject:[NSString stringWithFormat:@"%ld", (long)score]];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:scoreArray];
        [defaults setObject:data forKey:@"SCORE_ARRAY"];
        [defaults synchronize];
        
        if(score>=topScore){
            topScore = score;
            scoreLabel.text = [@(score) stringValue];
            topScoreLabel.text = [@(topScore) stringValue];
            
            [[GameCenterManager sharedManager] saveAndReportScore:topScore leaderboard:@"dragonRequest"  sortOrder:GameCenterSortOrderHighToLow];
            
            
            // Integerの保存
            [defaults setInteger:topScore forKey:@"TOPSCORE"];
            
        }
        scoreLabel.text = [@(score) stringValue];
        
        [alart show];
        [_hero removeImage];
        clearflag = true;
        stagenumber++;
        if(stagenumber >= 4)
        {
            stagenumber = 1;
        }
    }
    

    if(heroaliveflag == false)
    {
 
        if(cnt % 10 == 0){
 
            if([_enemyBoss[i]  fight:_hero]){
 
                // Here we need to pass a full frame
                CustomIOS7AlertView *alertView = [[CustomIOS7AlertView alloc] init];
                
                // Add some custom content to the alert view
                [alertView setContainerView:[self createDemoView]];
                
                // Modify the parameters
                [alertView setButtonTitles:[NSMutableArray arrayWithObjects:@"Continue", @"Menu", nil]];
                [alertView setDelegate:self];
                
                // You may use a Block, rather than a delegate.
                [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
                    NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, (int)[alertView tag]);
                    [alertView close];
                }];
                
                [alertView setUseMotionEffects:true];
                
                // And launch the dialog
                [alertView show];
                
                if(score>=topScore){
                    topScore = score;
                    scoreLabel.text = [@(score) stringValue];
                    topScoreLabel.text = [@(topScore) stringValue];
                    
                    
                }
                score = initMainScore;
                scoreLabel.text = [@(score) stringValue];
                
                stagenumber = 1;
                [_hero removeImage];
                heroaliveflag = true;
                break;
            }
        }
    }
    
    cnt++;
    
*/
    
}

//タイマーで設定した時間ごとにボスを生成
- (void)createBoss{
    
    
    //[self bringObject];
    
    if (clearflag) {
//        NSLog(@"リターン");
        return;
    }
    
    for(int i=0;i<ENEMY_MARINE_MAX;i++){
        if(_enemyMarine[i] == nil){
            //Bossのインスタンス作成
            _enemyMarine[i] = [[EnemyMarine alloc] init:CGPointZero];
            _enemyMarine[i].alpha = 1.0;
            //Bossのイメージを設定
            [_enemyMarine[i] setImage:self.view belowSubview:self.weaponCollectionView];
            [_enemyMarine[i] setEnemy:_hero];

            createCnt++;
            break;
            
        }
    }
//    NSLog(@"雑魚生成");
    
    if(createCnt % 10 == 0){
        for(int i=0;i<ENEMY_BOSS_MAX;i++){
            if(_enemyBoss[i] == nil){
                //Bossのインスタンス作成
                _enemyBoss[i] = [[EnemyBoss alloc] init:CGPointZero];
                _enemyBoss[i].alpha = 1.0;
                //Bossのイメージを設定
                [_enemyBoss[i] setImage:self.view belowSubview:self.weaponCollectionView];
                [_enemyBoss[i] setEnemy:_hero];

                break;
            }
        }
//        NSLog(@"ボス生成");
    }
}


/** リセット */
- (void)reset {
    
    clearflag = false;
    heroaliveflag = false;
    
    clearmes = @"次のステージに進みます";

    int createtime = 0;
    switch (stagenumber) {
        case 1:
            _fieldView.image = _utilManager.backgroundImage01;
            createtime = bossCreatetime1;
            break;
        case 2:
            _fieldView.image = _utilManager.backgroundImage02;
            createtime = bossCreatetime2;
            break;
        case 3:
            _fieldView.image = _utilManager.backgroundImage03;
            createtime = bossCreatetime3;
            clearmes = @"すべてのステージをクリアしました";
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
    for (int i=0;i<ENEMY_MARINE_MAX;i++){
        if(_enemyMarine[i] != nil){
            [_enemyMarine[i] removeImage];
            _enemyMarine[i] = nil;
        }
    }
    
    //hero インスタンス作成
    CGPoint heroPos = CGPointMake([common screenSizeWidth]/2, [common screenSizeHeight]/2);
    _hero = [[MyHero alloc]init:heroPos];
    
    //hero イメージを設定
    [_hero setImage:self.view belowSubview:self.weaponCollectionView];

    //heroのx、y座標
    _xPos = _hero.position.x;
    _yPos = _hero.position.y;
    
    if(_storyTimer == nil){
        _storyTimer  = [NSTimer scheduledTimerWithTimeInterval:bossMoveTimeInterval target:self selector:@selector(checkGameStory) userInfo:nil repeats:YES];
        [_storyTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:bossMoveTimeInterval]];
        
    }
    if(_createTimer == nil){
        _createTimer = [NSTimer scheduledTimerWithTimeInterval:bossCreatetime1 target:self selector:@selector(createBoss) userInfo:nil repeats:YES];
        [_createTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:createtime]];
    
    }
    
    [_storyTimer fire];
    [_createTimer fire];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//------------------------------------------------------------------------------------------------------------//
//------- GameKit Delegate -----------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameKit Delegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (gameCenterViewController.viewState == GKGameCenterViewControllerStateAchievements) {
//        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter achievements."];
    } else if (gameCenterViewController.viewState == GKGameCenterViewControllerStateLeaderboards) {
//        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter leaderboard."];
    } else {
//        actionBarLabel.title = [NSString stringWithFormat:@"Displayed GameCenter controller."];
    }
}

//------------------------------------------------------------------------------------------------------------//
//------- GameCenter Manager Delegate ------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
#pragma mark - GameCenter Manager Delegate

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
    [self presentViewController:gameCenterLoginController animated:YES completion:^{
        NSLog(@"Finished Presenting Authentication Controller");
    }];
}

- (void)gameCenterManager:(GameCenterManager *)manager availabilityChanged:(NSDictionary *)availabilityInformation {
    NSLog(@"GC Availabilty: %@", availabilityInformation);
    if ([[availabilityInformation objectForKey:@"status"] isEqualToString:@"GameCenter Available"]) {
        [self.navigationController.navigationBar setValue:@"GameCenter Available" forKeyPath:@"prompt"];
//        statusDetailLabel.text = @"Game Center is online, the current player is logged in, and this app is setup.";
    } else {
        [self.navigationController.navigationBar setValue:@"GameCenter Unavailable" forKeyPath:@"prompt"];
//        statusDetailLabel.text = [availabilityInformation objectForKey:@"error"];
    }
    
    GKLocalPlayer *player = [[GameCenterManager sharedManager] localPlayerData];
    if (player) {
        if ([player isUnderage] == NO) {
//            actionBarLabel.title = [NSString stringWithFormat:@"%@ signed in.", player.displayName];
            playerNameLabel.text = player.displayName;
//            playerStatus.text = @"Player is not underage and is signed-in";
            [[GameCenterManager sharedManager] localPlayerPhoto:^(UIImage *playerPhoto) {
                gcPlayerPictureImage.image = playerPhoto;
            }];
        } else {
            playerNameLabel.text = player.displayName;
//            playerStatus.text = @"Player is underage";
//            actionBarLabel.title = [NSString stringWithFormat:@"Underage player, %@, signed in.", player.displayName];
        }
    } else {
//        actionBarLabel.title = [NSString stringWithFormat:@"No GameCenter player found."];
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager error:(NSError *)error {
    NSLog(@"GCM Error: %@", error);
    //topScoreLabel.text = error.domain;
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedAchievement:(GKAchievement *)achievement withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Achievement: %@", achievement);
//        actionBarLabel.title = [NSString stringWithFormat:@"Reported achievement with %.1f percent completed", achievement.percentComplete];
    } else {
        NSLog(@"GCM Error while reporting achievement: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager reportedScore:(GKScore *)score withError:(NSError *)error {
    if (!error) {
        NSLog(@"GCM Reported Score: %@", score);
//        actionBarLabel.title = [NSString stringWithFormat:@"Reported leaderboard score: %lld", score.value];
    } else {
        NSLog(@"GCM Error while reporting score: %@", error);
    }
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveScore:(GKScore *)score {
    NSLog(@"Saved GCM Score with value: %lld", score.value);
//    actionBarLabel.title = [NSString stringWithFormat:@"Score saved for upload to GameCenter."];
}

- (void)gameCenterManager:(GameCenterManager *)manager didSaveAchievement:(GKAchievement *)achievement {
    NSLog(@"Saved GCM Achievement: %@", achievement);
//    actionBarLabel.title = [NSString stringWithFormat:@"Achievement saved for upload to GameCenter."];
}

//------------------------------------------------------------------------------------------------------------//
//------- CustomIOS7AlertView Delegate ------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------------//
- (void)customIOS7dialogButtonTouchUpInside: (CustomIOS7AlertView *)alertView clickedButtonAtIndex: (NSInteger)buttonIndex
{
    NSLog(@"Delegate: Button at position %d is clicked on alertView %d.", (int)buttonIndex, (int)[alertView tag]);
    
    if(buttonIndex==0){

        [self reset];
        
        [alertView close];

    }
    else{
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 200)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 270, 180)];
    [imageView setImage:[UIImage imageNamed:@"gamecenter.png"]];
    [demoView addSubview:imageView];
    
    return demoView;
}

@end
