//
//  PEBEmotionManager.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PEBEmotionManager : NSObject

- (void)findAvailabelPackets:(void (^)(NSArray /**PEBPacket**/ *))completionBlock;

- (NSAttributedString *)addEmotionsToAttributedString:(NSAttributedString *)attributedString;

@end
