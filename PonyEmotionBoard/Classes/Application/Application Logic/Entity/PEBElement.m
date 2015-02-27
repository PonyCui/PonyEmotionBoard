//
//  PEBElement.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15/2/27.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBElement.h"

@implementation PEBElement

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.identifier = dictionary[@"identifier"];
        self.type = [dictionary[@"type"] integerValue];
        self.titleString = dictionary[@"titleString"];
        self.localURLString = dictionary[@"localURLString"];
        self.remoteURLString = dictionary[@"remoteURLString"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.identifier = [coder decodeObjectForKey:@"identifier"];
        self.type = [coder decodeIntegerForKey:@"type"];
        self.titleString = [coder decodeObjectForKey:@"titleString"];
        self.localURLString = [coder decodeObjectForKey:@"localURLString"];
        self.remoteURLString = [coder decodeObjectForKey:@"remoteURLString"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
    [aCoder encodeInteger:self.type forKey:@"type"];
    [aCoder encodeObject:self.titleString forKey:@"titleString"];
    [aCoder encodeObject:self.localURLString forKey:@"localURLString"];
    [aCoder encodeObject:self.remoteURLString forKey:@"remoteURLString"];
}

@end
