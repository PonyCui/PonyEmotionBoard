//
//  PEBEmotionItemCollectionViewCell.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-25.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PEBEmotionItemPresenter;

@interface PEBEmotionItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) PEBEmotionItemPresenter *eventHandler;

#pragma mark - IBOutlet

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *iconTitleLabel;

@end
