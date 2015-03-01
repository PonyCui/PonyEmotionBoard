//
//  PEBKeyboardDelegateObject.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/26.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBKeyboardDelegateObject.h"
#import "PEBKeyboardPresenter.h"
#import "PEBKeyboardInteractor.h"
#import "PEBEmotionGroupCollectionViewCell.h"
#import "PEBEmotionGroupPresenter.h"
#import "PEBEmotionGroupInteractor.h"
#import "PEBEmotionItemCollectionViewCell.h"
#import "PEBEmotionItemPresenter.h"

@interface PEBKeyboardDelegateObject ()

@property (weak, nonatomic) IBOutlet UICollectionView *groupCollectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *itemCollectionView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, assign) NSInteger totalSections;

/**
 *  Key:indexPath.section
 *  Value:rowCount
 */
@property (nonatomic, copy) NSArray *numberOfItems;

/**
 *  Key:indexPath.section
 *  Value:groupInteractor[->indexPath.section<-]
 */
@property (nonatomic, copy) NSArray *groupIndexes;

/**
 *  Key:groupIndex
 *  Value:sectionCount
 */
@property (nonatomic, copy) NSArray *groupSections;

@end

@implementation PEBKeyboardDelegateObject

#pragma mark - Calculations

- (void)updateView {
    [self calculates];
    [self.itemCollectionView reloadData];
    [self.groupCollectionView reloadData];
    [self updateGroupSelection];
    [self updatePageControl];
}

/**
 *  各种计算
 */
- (void)calculates {
    __block NSUInteger totalSections = 0;
    NSMutableArray *numberOfItemsArray = [NSMutableArray array];
    NSMutableArray *groupIndexes = [NSMutableArray array];
    NSMutableArray *groupSections = [NSMutableArray array];
    [self.eventHandler.keyboardInteractor.emotionGroupInteractors
     enumerateObjectsUsingBlock:^(PEBEmotionGroupInteractor *obj, NSUInteger idx, BOOL *stop) {
         NSUInteger numberOfItems = [obj.emotionItemInteractors count];
         NSUInteger itemsPerSection = [self numberOfItemsPerSectionForGroupType:obj.type];
         NSUInteger numberOfSections = (NSUInteger)ceil((CGFloat)numberOfItems / (CGFloat)itemsPerSection);
         {
             totalSections += numberOfSections;
         }
         {
             for (NSInteger i = 0; i < numberOfSections; i++) {
                 [numberOfItemsArray addObject:@(itemsPerSection)];
             }
         }
         {
             for (NSInteger i = 0; i < numberOfSections; i++) {
                 [groupIndexes addObject:@(idx)];
             }
         }
         {
             [groupSections addObject:@(numberOfSections)];
         }
     }];
    self.totalSections = totalSections;
    self.numberOfItems = numberOfItemsArray;
    self.groupIndexes = groupIndexes;
    self.groupSections = groupSections;
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
        return self.totalSections;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.groupCollectionView) {
        return [self.eventHandler.keyboardInteractor.emotionGroupInteractors count];
    }
    else {
        if (section < [self.numberOfItems count]) {
            return [self.numberOfItems[section] integerValue];
        }
        else {
            return 0;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.groupCollectionView) {
        __block NSInteger itemPage = 0;
        NSInteger groupIndex = indexPath.row;
        [self.groupSections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx >= groupIndex) {
                *stop = YES;
            }
            else {
                itemPage += [obj integerValue];
            }
        }];
        if (itemPage < NSIntegerMax && itemPage >= 0) {
            [self.itemCollectionView
             setContentOffset:CGPointMake(CGRectGetWidth(self.itemCollectionView.bounds) * itemPage, 0)
             animated:YES];
        }
    }
    else if (collectionView == self.itemCollectionView) {
        PEBEmotionItemCollectionViewCell *cell =
        (PEBEmotionItemCollectionViewCell *)[self collectionView:collectionView
                                          cellForItemAtIndexPath:indexPath];
        [cell.eventHandler insertTextToTextField:self.textField];
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
    if (indexPath.section < [self.groupIndexes count]) {
        NSInteger groupInteractorIndex = [self.groupIndexes[indexPath.section] integerValue];
        if (groupInteractorIndex < [self.eventHandler.keyboardInteractor.emotionGroupInteractors count]) {
            return self.eventHandler.keyboardInteractor.emotionGroupInteractors[groupInteractorIndex];
        }
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

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == self.itemCollectionView) {
        CGFloat insetWidth = (NSInteger)CGRectGetWidth(self.itemCollectionView.bounds) % 40 / 2.0 + 20;
        return UIEdgeInsetsMake(20, insetWidth, 26, insetWidth);
    }
    else {
        return UIEdgeInsetsZero;
    }
}

#pragma mark - PageControl

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.itemCollectionView) {
        [self updateGroupSelection];
        [self updatePageControl];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.itemCollectionView) {
        [self updateGroupSelection];
        [self updatePageControl];
    }
}

- (void)updatePageControl {
    NSInteger numberOfPages = 0, currentPage = 0;
    NSInteger sectionIndex = (NSInteger)(self.itemCollectionView.contentOffset.x / CGRectGetWidth(self.itemCollectionView.bounds));
    if (sectionIndex < [self.groupIndexes count]) {
        NSInteger groupIndex = [self.groupIndexes[sectionIndex] integerValue];
        if (groupIndex < [self.groupSections count]) {
            numberOfPages = [self.groupSections[groupIndex] integerValue];
        }
    }
    NSInteger currentIndex = sectionIndex - 1;
    if (sectionIndex < [self.groupIndexes count]) {
        NSInteger groupIndex = [self.groupIndexes[sectionIndex] integerValue];
        while (currentIndex >= 0 && currentIndex < [self.groupIndexes count]) {
            if ([self.groupIndexes[currentIndex] integerValue] != groupIndex) {
                break;
            }
            else {
                currentPage++;
                currentIndex--;
            }
        }
    }
    self.pageControl.numberOfPages = numberOfPages;
    self.pageControl.currentPage = currentPage;
    self.pageControl.hidden = numberOfPages <= 1;
}

- (void)updateGroupSelection {
    NSInteger sectionIndex = (NSInteger)(self.itemCollectionView.contentOffset.x / CGRectGetWidth(self.itemCollectionView.bounds));
    if (sectionIndex < [self.groupIndexes count]) {
        NSInteger groupIndex = [self.groupIndexes[sectionIndex] integerValue];
        [self.groupCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:groupIndex inSection:0]
                                               animated:YES
                                         scrollPosition:UICollectionViewScrollPositionNone];
    }
}

@end
