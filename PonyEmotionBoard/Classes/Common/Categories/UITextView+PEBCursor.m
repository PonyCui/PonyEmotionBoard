//
//  UITextView+PEBCursor.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/28.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "UITextView+PEBCursor.h"

static NSInteger peb_cursorPosition = 0;

@implementation UITextView (PEBCursor)

- (void)peb_setCursorPosition:(NSInteger)position {
    peb_cursorPosition = position;
}

- (NSInteger)peb_cursorPosition {
    return peb_cursorPosition;
}

@end
