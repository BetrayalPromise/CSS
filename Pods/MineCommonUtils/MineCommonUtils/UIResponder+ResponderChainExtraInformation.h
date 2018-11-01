//
//  UIResponder+EventTransferChain.h
//  Footstone
//
//  Created by LiChunYang on 8/3/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (ResponderChainExtraInformation)

- (void)transferObject:(id _Nullable)object selector:(SEL _Nullable)selector userInfo:(id _Nullable)userInfo;

@end
