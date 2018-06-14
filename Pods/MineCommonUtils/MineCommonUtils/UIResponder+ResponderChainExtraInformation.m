//
//  UIResponder+EventTransferChain.m
//  Footstone
//
//  Created by LiChunYang on 8/3/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UIResponder+ResponderChainExtraInformation.h"

@implementation UIResponder (ResponderChainExtraInformation)

- (void)transferObject:(id _Nullable)object selector:(SEL _Nullable)selector userInfo:(NSDictionary *_Nullable)userInfo {
    [[self nextResponder] transferObject:object selector:selector userInfo:userInfo];
}

@end
