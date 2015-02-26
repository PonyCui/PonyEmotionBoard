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
 *  缩略图下方的文字
 */
@property (nonatomic, copy) NSString *collectionText;

/**
 *  表情描述
 *  长按表情将展示该文字
 */
@property (nonatomic, copy) NSString *emotionDescription;

/**
 *  表情文字
 *  非nil则表示，该文字将替代表情进行数据传输
 */
@property (nonatomic, copy) NSString *emotionText;

/**
 *  表情数据获取地址
 *  非nil则表示，表情使用图片形式进行数据传输
 */
@property (nonatomic, copy) NSString *emotionURLString;

@end
