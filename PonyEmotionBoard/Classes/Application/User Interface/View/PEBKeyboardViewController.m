//
//  PEBKeyboardViewController.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "PEBKeyboardViewController.h"
#import "PEBKeyboardPresenter.h"
#import "PEBKeyboardInteractor.h"
#import "PEBKeyboardDelegateObject.h"

@interface PEBKeyboardViewController ()

@property (nonatomic, weak) NSLayoutConstraint *viewBottomSpaceConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *groupCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@property (nonatomic, assign) BOOL wasEditing;

@property (strong, nonatomic) IBOutlet PEBKeyboardDelegateObject *keyboardDelegates;

@end

@implementation PEBKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSendButtonReactiveCocoa];
    [self.eventHandler updateView];
    [self setSendButtonEnabled:YES];//Fix me:Should Remove
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureItemCollectitonViewInsets];
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

- (void)configureItemCollectitonViewInsets {
    CGFloat insetWidth = (NSInteger)CGRectGetWidth(self.view.bounds) % 40 / 2.0 + 20;
    [(UICollectionViewFlowLayout *)self.itemCollectionView.collectionViewLayout
     setSectionInset:UIEdgeInsetsMake(20, insetWidth, 26, insetWidth)];
}

#pragma mark - isPresented

- (void)setIsPresented:(BOOL)isPresented {
    _isPresented = isPresented;
    isPresented ?
    [self performSelector:@selector(present) withObject:nil afterDelay:0.001] :
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:0.001];
}

- (void)present {
    if ([(UIView *)self.textInputContainer isFirstResponder]) {
        self.wasEditing = YES;
        [(UIView *)self.textInputContainer resignFirstResponder];
    }
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
    if (self.wasEditing) {
        self.wasEditing = NO;
        [(UIView *)self.textInputContainer becomeFirstResponder];
    }
}

#pragma mark - Update View

- (void)updateGroupCollectionView {
    [self.keyboardDelegates calculates];
    [self.groupCollectionView reloadData];
    [self.keyboardDelegates updateGroupSelection];
    [self.keyboardDelegates updatePageControl];
}

- (void)updateItemCollectionView {
    [self.keyboardDelegates calculates];
    [self.itemCollectionView reloadData];
    [self.keyboardDelegates updateGroupSelection];
    [self.keyboardDelegates updatePageControl];
}

#pragma mark - Setter 

- (void)setEventHandler:(PEBKeyboardPresenter *)eventHandler {
    _eventHandler = eventHandler;
    self.keyboardDelegates.eventHandler = _eventHandler;
}

- (void)setTextInputContainer:(UITextField<UITextInput> *)textInputContainer {
    _textInputContainer = textInputContainer;
    self.keyboardDelegates.textInputContainer = textInputContainer;
}

#pragma mark - Send Button

- (void)configureSendButtonReactiveCocoa {
    [RACObserve(self, textInputContainer.text) subscribeNext:^(NSString *x) {
        [self setSendButtonEnabled:x.length];
    }];
}

- (IBAction)handleSendButtonTapped:(id)sender {
    if ([self.textInputContainer isKindOfClass:[UITextField class]]) {
        [[(UITextField *)self.textInputContainer delegate]
         textFieldShouldReturn:(UITextField *)self.textInputContainer];
    }
}

- (void)setSendButtonEnabled:(BOOL)enabled {
    if (enabled) {
        self.sendButton.enabled = YES;
        self.sendButton.backgroundColor = [UIColor colorWithRed:0.0
                                                          green:122.0/255.0
                                                           blue:255.0/255.0
                                                          alpha:1.0];
    }
    else {
        self.sendButton.enabled = NO;
        self.sendButton.backgroundColor = [UIColor clearColor];
    }
}


@end
