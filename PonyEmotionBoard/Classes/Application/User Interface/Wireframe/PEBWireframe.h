//
//  PEBWireframe.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PEBWireframe : NSObject

- (void)presentEmotionBoardToViewController:(UIViewController *)viewController
                         textInputContainer:(id<UITextInput>)textInputContainer;

- (void)dismissEmotionBoardFromViewController:(UIViewController *)viewController;

@end
