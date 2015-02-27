//
//  PEBWireframe.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBWireframe.h"
#import "PEBKeyboardViewController.h"
#import "PEBKeyboardPresenter.h"

@implementation PEBWireframe

- (PEBKeyboardViewController *)presentEmotionBoardToViewController:(UIViewController *)viewController
                                                     withTextField:(UITextField *)textField{
    PEBKeyboardViewController *keyboardViewController = [self keyboardViewController];
    [viewController addChildViewController:keyboardViewController];
    [viewController.view addSubview:keyboardViewController.view];
    [keyboardViewController configureViewLayouts];
    keyboardViewController.textField = textField;
    return keyboardViewController;
}

#pragma mark - Getter

- (PEBKeyboardViewController *)keyboardViewController {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"PEBStoryBoard" bundle:nil];
    PEBKeyboardViewController *keyboardViewController = [storyBoard instantiateViewControllerWithIdentifier:@"PEBKeyboardViewController"];
    keyboardViewController.eventHandler = [[PEBKeyboardPresenter alloc] init];
    keyboardViewController.eventHandler.userInterface = keyboardViewController;
    return keyboardViewController;
}

@end
