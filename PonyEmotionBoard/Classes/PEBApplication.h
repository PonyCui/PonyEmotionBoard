//
//  PEBApplication.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PEBApplication : NSObject

+ (PEBApplication *)sharedInstance;

- (void)setEditing:(BOOL)isEditing forTextField:(UITextField *)textField;

@end
