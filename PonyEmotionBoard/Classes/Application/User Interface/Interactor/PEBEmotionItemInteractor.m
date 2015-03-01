//
//  PEBEmotionItemInteractor.m
//  PonyEmotionBoard
//
//  Created by 崔 明辉 on 15-2-24.
//  Copyright (c) 2015年 崔 明辉. All rights reserved.
//

#import "PEBEmotionItemInteractor.h"
#import "PEBElement.h"
#import <AFNetworking/AFNetworking.h>

@interface PEBEmotionItemInteractor ()

@property (nonatomic, strong) PEBElement *element;

@end

@implementation PEBEmotionItemInteractor

- (instancetype)initWithElement:(PEBElement *)element {
    self = [super init];
    if (self) {
        self.element = element;
        [self sendAsyncIconImageRequest];
    }
    return self;
}

- (void)sendAsyncIconImageRequest {
    if (self.element.remoteURLString != nil) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.element.remoteURLString]
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
    else if(self.element.localURLString != nil) {
        self.iconImage = [UIImage imageNamed:self.element.localURLString];
    }
}

- (NSString *)emotionText {
    if (self.element.type == PEBElementTypeEmojiSimilar) {
        return [NSString stringWithFormat:@"[%@]", self.element.titleString];
    }
    else if (self.element.type == PEBElementTypeEmoji) {
        return self.element.titleString;
    }
    else {
        return nil;
    }
}

- (NSString *)emotionDescription {
    return self.element.titleString;
}

- (NSString *)collectionText {
    if (self.element.type == PEBElementTypeAnimate) {
        return self.element.titleString;
    }
    else if (self.element.type == PEBElementTypeEmoji) {
        return self.element.titleString;
    }
    else {
        return nil;
    }
}

@end
