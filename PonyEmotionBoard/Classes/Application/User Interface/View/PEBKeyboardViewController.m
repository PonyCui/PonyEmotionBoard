//
//  PEBKeyboardViewController.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBKeyboardViewController.h"
#import "PEBKeyboardPresenter.h"
#import "PEBKeyboardInteractor.h"
#import "PEBEmotionGroupCollectionViewCell.h"
#import "PEBEmotionGroupPresenter.h"

@interface PEBKeyboardViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) NSLayoutConstraint *viewBottomSpaceConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *groupCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;

@end

@implementation PEBKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.groupCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    });
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

#pragma mark - isPresented

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

#pragma mark - UICollectionViewDataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.groupCollectionView) {
        PEBEmotionGroupCollectionViewCell *cell = [collectionView
                                                   dequeueReusableCellWithReuseIdentifier:@"GroupCell"
                                                   forIndexPath:indexPath];
        if (indexPath.row < [self.eventHandler.keyboardInteractor.emotionGroupInteractors count]) {
            cell.eventHandler.groupInteractor = self.eventHandler.keyboardInteractor.emotionGroupInteractors[indexPath.row];
        }
        else {
            cell.eventHandler.groupInteractor = nil;
        }
        return cell;
    }
    else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.groupCollectionView) {
        return 1;
    }
    else {
        return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.groupCollectionView) {
        return [self.eventHandler.keyboardInteractor.emotionGroupInteractors count];
    }
    else {
        return 0;
    }
}

@end
