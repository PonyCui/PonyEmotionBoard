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
#import "PEBEmotionGroupInteractor.h"
#import "PEBEmotionItemCollectionViewCell.h"
#import "PEBEmotionItemPresenter.h"

@interface PEBKeyboardViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) NSLayoutConstraint *viewBottomSpaceConstraint;

@property (weak, nonatomic) IBOutlet UICollectionView *groupCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/**
 *  Key:indexPath.section
 *  Value:numberOfRows
 */
@property (nonatomic, copy) NSDictionary *rowCountCacheDictionary;

/**
 *  Key:indexPath.section
 *  Value:groupInteractors[->indexPath.section<-]
 */
@property (nonatomic, copy) NSDictionary *sectionGroupIndexCacheDictionary;

@end

@implementation PEBKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.eventHandler updateView];
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
        NSString *cellIdentifier;
        PEBEmotionGroupInteractor *groupInteractor = [self emotionGroupForIndexPath:indexPath];
        if (groupInteractor.type == PEBEmotionGroupTypeEmoji) {
            cellIdentifier = @"EmojiItemCell";
        }
        else {
            cellIdentifier = @"CustomItemCell";
        }
        PEBEmotionItemCollectionViewCell *cell = [collectionView
                                                  dequeueReusableCellWithReuseIdentifier:cellIdentifier
                                                  forIndexPath:indexPath];
        cell.eventHandler.itemInteractor = [self emotionItemForIndexPath:indexPath];
        return cell;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == self.groupCollectionView) {
        return 1;
    }
    else {
        NSMutableDictionary *rowCountCache = [NSMutableDictionary dictionary];
        NSMutableDictionary *sectionGroupIndexCache = [NSMutableDictionary dictionary];
        __block NSUInteger totalSections = 0;
        [self.eventHandler.keyboardInteractor.emotionGroupInteractors
         enumerateObjectsUsingBlock:^(PEBEmotionGroupInteractor *obj, NSUInteger idx, BOOL *stop) {
             NSUInteger numberOfItems = [obj.emotionItemInteractors count];
             NSUInteger itemsPerSection = [self numberOfItemsPerSectionForGroupType:obj.type];
             NSUInteger numberOfSections = (NSUInteger)ceil((CGFloat)numberOfItems / (CGFloat)itemsPerSection);
             totalSections += numberOfSections;
             {
                 NSInteger position = totalSections-1;
                 do {
                     [rowCountCache setObject:@(itemsPerSection) forKey:@(position)];
                     [sectionGroupIndexCache setObject:@(idx) forKey:@(position)];
                     position--;
                 } while (rowCountCache[@(position)] == nil && position >= 0);
             }
        }];
        self.rowCountCacheDictionary = rowCountCache;
        self.sectionGroupIndexCacheDictionary = sectionGroupIndexCache;
        return totalSections;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.groupCollectionView) {
        return [self.eventHandler.keyboardInteractor.emotionGroupInteractors count];
    }
    else {
        return [self.rowCountCacheDictionary[@(section)] integerValue];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.groupCollectionView) {
        __block NSInteger itemPage = NSIntegerMax;
        PEBEmotionGroupInteractor *groupInteractor;
        if (indexPath.row < [self.eventHandler.keyboardInteractor.emotionGroupInteractors count]) {
            groupInteractor = self.eventHandler.keyboardInteractor.emotionGroupInteractors[indexPath.row];
        }
        [self.sectionGroupIndexCacheDictionary
         enumerateKeysAndObjectsUsingBlock:^(NSNumber *key, NSNumber *obj, BOOL *stop) {
             NSInteger sectionIndex = [key integerValue];
             NSInteger groupIndex = [obj integerValue];
             if (groupIndex < [self.eventHandler.keyboardInteractor.emotionGroupInteractors count] &&
                 self.eventHandler.keyboardInteractor.emotionGroupInteractors[groupIndex] == groupInteractor) {
                 itemPage = MIN(itemPage, sectionIndex);
             }
        }];
        if (itemPage < NSIntegerMax && itemPage >= 0) {
            [self.itemCollectionView
             setContentOffset:CGPointMake(CGRectGetWidth(self.itemCollectionView.bounds) * itemPage, 0)
             animated:NO];
        }
    }
}

#pragma mark - Emotion View Layout Calculations

- (NSUInteger)numberOfRowsPerLineForGroupType:(PEBEmotionGroupType)groupType {
    CGFloat viewWidth = CGRectGetWidth([[[[UIApplication sharedApplication] delegate] window] bounds]);
    UIEdgeInsets viewInset = [(UICollectionViewFlowLayout *)self.itemCollectionView.collectionViewLayout sectionInset];
    CGSize cellSize = [self sizeOfItemForGroupType:groupType];
    NSUInteger numbersOfCellPerLine = (NSUInteger)((viewWidth - viewInset.left - viewInset.right) / cellSize.width);
    return numbersOfCellPerLine;
}

- (NSUInteger)numberOfLinesPerSectionForGroupType:(PEBEmotionGroupType)groupType {
    CGFloat viewHeight = 178.0;
    UIEdgeInsets viewInset = [(UICollectionViewFlowLayout *)self.itemCollectionView.collectionViewLayout sectionInset];
    CGSize cellSize = [self sizeOfItemForGroupType:groupType];
    NSUInteger numbersOfLines = (NSUInteger)((viewHeight - viewInset.top - viewInset.bottom) / cellSize.height);
    return numbersOfLines;
}

- (NSUInteger)numberOfItemsPerSectionForGroupType:(PEBEmotionGroupType)groupType {
    CGFloat viewWidth = CGRectGetWidth([[[[UIApplication sharedApplication] delegate] window] bounds]);
    CGFloat viewHeight = 178.0;
    UIEdgeInsets viewInset = [(UICollectionViewFlowLayout *)self.itemCollectionView.collectionViewLayout sectionInset];
    CGSize cellSize = [self sizeOfItemForGroupType:groupType];
    NSUInteger numbersOfCellPerLine = (NSUInteger)((viewWidth - viewInset.left - viewInset.right) / cellSize.width);
    NSUInteger numbersOfLines = (NSUInteger)((viewHeight - viewInset.top - viewInset.bottom) / cellSize.height);
    return numbersOfCellPerLine * numbersOfLines;
}

- (CGSize)sizeOfItemForGroupType:(PEBEmotionGroupType)groupType {
    if (groupType == PEBEmotionGroupTypeEmoji) {
        return CGSizeMake(40.0, 36.0);
    }
    else {
        return CGSizeZero;
    }
}

- (PEBEmotionGroupInteractor *)emotionGroupForIndexPath:(NSIndexPath *)indexPath {
    NSUInteger groupInteractorIndex = [self.sectionGroupIndexCacheDictionary[@(indexPath.section)]
                                       integerValue];
    if (groupInteractorIndex < [self.eventHandler.keyboardInteractor.emotionGroupInteractors count]) {
        return self.eventHandler.keyboardInteractor.emotionGroupInteractors[groupInteractorIndex];
    }
    return nil;
}

- (PEBEmotionItemInteractor *)emotionItemForIndexPath:(NSIndexPath *)indexPath {
    PEBEmotionGroupInteractor *groupInteractor = [self emotionGroupForIndexPath:indexPath];
    NSUInteger cellIndex = [self cellIndexForIndexPath:indexPath];
    NSInteger currentPosition = indexPath.section - 1;
    while ([self emotionGroupForIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentPosition]]
           == groupInteractor &&
           currentPosition >= 0) {
        cellIndex += [self numberOfItemsPerSectionForGroupType:groupInteractor.type];
        currentPosition--;
    }
    if (cellIndex < [groupInteractor.emotionItemInteractors count]) {
        PEBEmotionItemInteractor *itemIntreactor = groupInteractor.emotionItemInteractors[cellIndex];
        return itemIntreactor;
    }
    return nil;
}

- (NSInteger)cellIndexForIndexPath:(NSIndexPath *)indexPath {
    //纵向有限矩阵 -> 横向有限矩阵
    //1.将m分解为a、b(a < b)，矩阵横向元素个数为r，矩阵纵向元素个数为c，则n=a*r+b/c
    //2.上述m的分解方法为 m%c=j a=j b=m-j
    //3.如果m<c,则n=m*r，如果m%c=0，则n=m/c
    PEBEmotionGroupInteractor *groupInteractor = [self emotionGroupForIndexPath:indexPath];
    NSUInteger r = [self numberOfRowsPerLineForGroupType:groupInteractor.type];
    NSUInteger c = [self numberOfLinesPerSectionForGroupType:groupInteractor.type];
    NSUInteger m = indexPath.row;
    if (m<c) {
        return m*r;
    }
    else if (m%c==0) {
        return m/c;
    }
    else {
        NSUInteger j = m % c;
        NSUInteger a = j;
        NSUInteger b = m-j;
        NSUInteger n = a*r+b/c;
        return n;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.itemCollectionView) {
        return CGSizeMake(40.0, 36.0);
    }
    else if (collectionView == self.groupCollectionView) {
        return CGSizeMake(60.0, 36.0);
    }
    else {
        return CGSizeZero;
    }
}

#pragma mark - Update View

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateGroupSelection];
    [self updatePageControl];
}

- (void)updateGroupCollectionView {
    [self.groupCollectionView reloadData];
    [self updateGroupSelection];
    [self updatePageControl];
}

- (void)updateItemCollectionView {
    [self.itemCollectionView reloadData];
}

- (void)updatePageControl {
    NSInteger numberOfPages = 0, currentPage = 0;
    NSInteger sectionIndex = (NSInteger)(self.itemCollectionView.contentOffset.x / CGRectGetWidth(self.itemCollectionView.bounds));
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectionIndex];
        PEBEmotionGroupInteractor *groupInteractor = [self emotionGroupForIndexPath:indexPath];
        NSInteger numberOfItemsPerPage = [self numberOfItemsPerSectionForGroupType:groupInteractor.type];
        numberOfPages = (NSInteger)ceil((CGFloat)[groupInteractor.emotionItemInteractors count] / (CGFloat)numberOfItemsPerPage);
    }
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectionIndex];
        PEBEmotionGroupInteractor *groupInteractor = [self emotionGroupForIndexPath:indexPath];
        NSIndexPath *previousIndexPath = [NSIndexPath indexPathForRow:0 inSection:sectionIndex-1];
        while ([self emotionGroupForIndexPath:previousIndexPath] == groupInteractor &&
               previousIndexPath.section >= 0) {
            currentPage++;
            previousIndexPath = [NSIndexPath indexPathForRow:0 inSection:previousIndexPath.section-1];
        }
    }
    self.pageControl.numberOfPages = numberOfPages;
    self.pageControl.currentPage = currentPage;
    self.pageControl.hidden = numberOfPages == 0;
}

- (void)updateGroupSelection {
    NSInteger sectionIndex = (NSInteger)(self.itemCollectionView.contentOffset.x / CGRectGetWidth(self.itemCollectionView.bounds));
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:sectionIndex];
    PEBEmotionGroupInteractor *groupInteractor = [self emotionGroupForIndexPath:indexPath];
    NSUInteger groupIndex = [self.eventHandler.keyboardInteractor.emotionGroupInteractors
                             indexOfObject:groupInteractor];
    [self.groupCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:groupIndex inSection:0]
                                           animated:YES
                                     scrollPosition:UICollectionViewScrollPositionNone];
}

@end
