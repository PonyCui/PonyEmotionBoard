//
//  PEBEmotionItemPresenter.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-25.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionItemPresenter.h"
#import "PEBEmotionItemCollectionViewCell.h"
#import "PEBEmotionItemInteractor.h"
#import "UITextView+PEBCursor.h"
#import "UITextField+PEBCursor.h"

@implementation PEBEmotionItemPresenter

- (void)updateView {
    self.userInterface.hidden = self.itemInteractor == nil;
    self.userInterface.iconImageView.image = self.itemInteractor.iconImage;
    self.userInterface.iconTitleLabel.text = self.itemInteractor.collectionText;
}

- (void)setItemInteractor:(PEBEmotionItemInteractor *)itemInteractor {
    _itemInteractor = itemInteractor;
    [self updateView];
}

- (void)insertTextToTextField:(UITextField *)textField {
    if (self.itemInteractor.emotionText != nil) {
        NSString *text = [textField text];
        NSInteger insertPosition = [textField peb_cursorPosition];
        if (insertPosition <= text.length) {
            NSMutableString *mutableText = [text mutableCopy];
            [mutableText insertString:self.itemInteractor.emotionText
                              atIndex:insertPosition];
            textField.text = [mutableText copy];
        }
        else {
            text = [text stringByAppendingString:self.itemInteractor.emotionText];
            textField.text = text;
        }
    }
    else if(self.itemInteractor.emotionURLString != nil) {
        
    }
}

@end
