//
//  PEBEmotionItemInteractor.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PEBEmotionItemInteractor : NSObject

/**
 *  缩略图
 */
@property (nonatomic, strong) UIImage *iconImage;

/**
 *  表情文字
 *  非nil则表示，该表情可以以文字形式呈现
 */
@property (nonatomic, copy) NSString *emotionText;

@end
