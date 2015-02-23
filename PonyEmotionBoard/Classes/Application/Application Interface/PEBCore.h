//
//  PEBCore.h
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-23.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PEBDefines.h"

@class PEBWireframe;

@interface PEBCore : NSObject

@property (nonatomic, readonly) PEBWireframe *wireframe;

@end
