//
//  PEBEmotionGroupCollectionViewCell.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionGroupCollectionViewCell.h"
#import "PEBEmotionGroupPresenter.h"

@interface PEBEmotionGroupCollectionViewCell ()

@property (nonatomic, strong) UIView *selectedView;

@end

@implementation PEBEmotionGroupCollectionViewCell

- (PEBEmotionGroupPresenter *)eventHandler {
    if (_eventHandler == nil) {
        _eventHandler = [[PEBEmotionGroupPresenter alloc] init];
        _eventHandler.userInterface = self;
    }
    return _eventHandler;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        [self addSubview:self.selectedView];
        [self sendSubviewToBack:self.selectedView];
    }
    else {
        [self.selectedView removeFromSuperview];
    }
}

- (UIView *)selectedView {
    if (_selectedView == nil) {
        _selectedView = [[UIView alloc] initWithFrame:self.bounds];
        _selectedView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _selectedView.backgroundColor = [UIColor colorWithRed:191.0/255.0
                                                        green:191.0/255.0
                                                         blue:191.0/255.0
                                                        alpha:1.0];
    }
    return _selectedView;
}

@end
