//
//  UITextView+PEBCursor.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (PEBCursor)

- (void)peb_setCursorPosition:(NSInteger)position;

- (NSInteger)peb_cursorPosition;

@end
