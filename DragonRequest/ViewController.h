//
//  ViewController.h
//  DragonRequest
//
//  Created by Apple on 2014/12/06.
//  Copyright (c) 2014年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EnemyBoss.h"
#import "EnemyMarine.h"
#import "MyHero.h"

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextView *positionTextField;

@property (weak, nonatomic) IBOutlet UIButton *resetBtn;
@property (weak, nonatomic) IBOutlet UIImageView *fieldView;

@property (nonatomic) int xPos;
@property (nonatomic) int yPos;

- (IBAction)moveAction:(id)sender;

- (IBAction)resetAction:(id)sender;


@end

