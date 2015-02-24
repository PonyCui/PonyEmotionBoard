//
//  PEBEmotionGroupCollectionViewCell.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PEBEmotionGroupPresenter;

@interface PEBEmotionGroupCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) PEBEmotionGroupPresenter *eventHandler;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
