//
//  DropItemImageView.h
//  DragonRequest
//
//  Created by masato_arai2 on 2015/03/26.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropItemImageView : UIImageView

- (instancetype)initWithPoint:(CGPoint)center dropItemType:(DropItemType)type;

@end
