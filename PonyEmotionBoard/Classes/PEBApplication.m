//
//  PEBApplication.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBApplication.h"
#import "PEBCore.h"
#import "PEBWireframe.h"
#import "PEBKeyboardViewController.h"
#import "PEBEmotionManager.h"

@interface PEBApplication ()

@property (nonatomic, strong) PEBCore *core;

@end

@implementation PEBApplication

+ (void)load {
    [self sharedInstance];
}

+ (PEBApplication *)sharedInstance {
    static PEBApplication *application;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        application = [[PEBApplication alloc] init];
    });
    return application;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.core = [[PEBCore alloc] init];
    }
    return self;
}

- (PEBKeyboardViewController *)addKeyboardViewControllerToViewController:(UIViewController *)viewController
                                                           withTextField:(UITextField *)textField {
    return [self.core.wireframe presentEmotionBoardToViewController:viewController withTextField:textField];
}

- (NSAttributedString *)emotionAttributedStringWithString:(NSString *)argString {
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:argString];
    return [self emotionAttributedStringWithAttributedString:attributedString];
}

- (NSAttributedString *)emotionAttributedStringWithAttributedString:(NSAttributedString *)argAttributedString {
    return [self.core.emotionManager addEmotionsToAttributedString:argAttributedString];
}


@end
