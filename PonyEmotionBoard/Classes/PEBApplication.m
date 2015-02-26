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

- (void)setEditing:(BOOL)isEditing
        parentViewController:(UIViewController *)parentViewController
        textInputContainer:(UIView<UITextInput> *)textInputContainer {
    if (isEditing) {
        [self.core.wireframe
         presentEmotionBoardToViewController:parentViewController
         textInputContainer:textInputContainer];
    }
    else {
        [self.core.wireframe
         dismissEmotionBoardFromViewController:parentViewController];
    }
}

@end
