//
//  UINetworkImageView.m
//  CSS
//
//  Created by 李阳 on 19/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UINetworkImageView.h"

@implementation UINetworkImageView

- (void)setUrlPath:(NSString *)urlPath {
    _urlPath = urlPath;
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlPath]];
    self.image = [UIImage imageWithData:imageData];
}

@end
