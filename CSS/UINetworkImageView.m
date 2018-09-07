//
//  UINetworkImageView.m
//  CSS
//
//  Created by 李阳 on 19/8/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import "UINetworkImageView.h"

@implementation UINetworkImageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initWithVariable];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithVariable];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        [self initWithVariable];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self initWithVariable];
    }
    return self;
}

/// 初始化变量
- (void)initWithVariable {
    _hierarchy = 10;
}

- (void)setUrlPath:(NSString *)urlPath {
    _urlPath = urlPath;
    NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlPath]];
    self.image = [UIImage imageWithData:imageData];
}

//- (NSString *)uniqueneIdentifier {
//
//}


@end
