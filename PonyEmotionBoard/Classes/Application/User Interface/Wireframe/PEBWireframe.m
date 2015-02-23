//
//  PEBWireframe.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBWireframe.h"
#import "PEBKeyboardViewController.h"

@implementation PEBWireframe

- (void)presentEmotionBoardToViewController:(UIViewController *)viewController
                               forTextField:(UITextField *)textField{
    __block PEBKeyboardViewController *keyboardViewController;
    [viewController.childViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[PEBKeyboardViewController class]]) {
            keyboardViewController = obj;
        }
    }];
    if (keyboardViewController == nil) {
        keyboardViewController = [self keyboardViewController];
        [viewController addChildViewController:keyboardViewController];
        [viewController.view addSubview:keyboardViewController.view];
        [keyboardViewController configureViewLayouts];
    }
    [keyboardViewController setIsPresented:YES];
}

#pragma mark - Getter

- (PEBKeyboardViewController *)keyboardViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PEBStoryBoard" bundle:nil];
    PEBKeyboardViewController *keyboardViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PEBKeyboardViewController"];
    return keyboardViewController;
}

@end
