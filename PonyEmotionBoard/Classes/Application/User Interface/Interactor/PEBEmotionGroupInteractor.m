//
//  PEBEmotionGroupInteractor.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionGroupInteractor.h"
#import "PEBEmotionItemInteractor.h"
#import "PEBPacket.h"
#import <AFNetworking/AFNetworking.h>

@interface PEBEmotionGroupInteractor ()

@property (nonatomic, strong) PEBPacket *packet;

@end

@implementation PEBEmotionGroupInteractor

- (instancetype)initWithPacket:(PEBPacket *)packet {
    self = [super init];
    if (self) {
        self.packet = packet;
        [self sendAsyncIconImageRequest];
    }
    return self;
}

- (PEBEmotionGroupType)type {
    if (self.packet.type == PEBPacketTypeEmoji) {
        return PEBEmotionGroupTypeEmoji;
    }
    else if (self.packet.type == PEBPacketTypeCustom) {
        return PEBEmotionGroupTypeCustom;
    }
    else if (self.packet.type == PEBPacketTypeBand) {
        return PEBEmotionGroupTypeBand;
    }
    else {
        return kNilOptions;
    }
}

- (NSArray *)emotionItemInteractors {
    if (_emotionItemInteractors == nil) {
        NSMutableArray *itemInteractors = [NSMutableArray array];
        [self.packet.elements enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PEBEmotionItemInteractor *itemInteractor = [[PEBEmotionItemInteractor alloc] initWithElement:obj];
            if (itemInteractor != nil) {
                [itemInteractors addObject:itemInteractor];
            }
        }];
        _emotionItemInteractors = [itemInteractors copy];
    }
    return _emotionItemInteractors;
}

- (void)sendAsyncIconImageRequest {
    if ([self.packet.iconURLString hasPrefix:@"http"]) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.packet.iconURLString]
                                                 cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                             timeoutInterval:15.0];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.responseSerializer.acceptableContentTypes = nil;
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                UIImage *image = [UIImage imageWithData:responseObject];
                self.iconImage = image;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        [[[AFHTTPRequestOperationManager manager] operationQueue] addOperation:operation];
    }
    else {
        self.iconImage = [UIImage imageNamed:self.packet.iconURLString];
    }
}

@end
