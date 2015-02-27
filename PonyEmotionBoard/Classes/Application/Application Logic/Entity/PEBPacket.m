//
//  PEBPack.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBPacket.h"

@implementation PEBPacket

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.type = [dictionary[@"type"] integerValue];
        self.identifier = dictionary[@"identifier"];
        self.iconURLString = dictionary[@"iconURLString"];
        self.titleString = dictionary[@"titleString"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.type = [coder decodeIntegerForKey:@"type"];
        self.identifier = [coder decodeObjectForKey:@"identifier"];
        self.titleString = [coder decodeObjectForKey:@"titleString"];
        self.iconURLString = [coder decodeObjectForKey:@"iconURLString"];
        self.elements = [coder decodeObjectForKey:@"elements"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeObject:self.titleString forKey:@"titleString"];
    [aCoder encodeObject:self.iconURLString forKey:@"iconURLString"];
    [aCoder encodeObject:self.elements forKey:@"elements"];
}

@end
