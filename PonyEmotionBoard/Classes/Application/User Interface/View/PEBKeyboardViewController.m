//
//  PEBKeyboardViewController.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBKeyboardViewController.h"

@interface PEBKeyboardViewController ()

@property (nonatomic, weak) NSLayoutConstraint *viewBottomSpaceConstraint;

@end

@implementation PEBKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureViewLayouts {
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *views = @{@"view": self.view};
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[view]-0-|"
                                                                       options:kNilOptions
                                                                       metrics:nil
                                                                         views:views];
        [self.view.superview addConstraints:constraints];
    }
    {
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[view(216)]-(-216)-|"
                                                                       options:kNilOptions
                                                                       metrics:nil
                                                                         views:views];
        self.viewBottomSpaceConstraint = [constraints lastObject];
        [self.view.superview addConstraints:constraints];
    }
}

#pragma mark - 

- (void)setIsPresented:(BOOL)isPresented {
    _isPresented = isPresented;
    isPresented ?
    [self performSelector:@selector(present) withObject:nil afterDelay:0.001] :
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.001];
}

- (void)present {
    self.viewBottomSpaceConstraint.constant = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dismiss {
    self.viewBottomSpaceConstraint.constant = -216.0;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
