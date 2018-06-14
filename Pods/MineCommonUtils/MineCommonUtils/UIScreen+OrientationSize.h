//
//  UIScreen+FunctionExtension.h
//  Custom
//
//  Created by 李阳 on 6/7/2016.
//  Copyright © 2016 TuoErJia. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - OrientationSize
@interface UIScreen (OrientationSize)

/// Home键在下面状态时候的绝对尺寸 该值不跟随设备方向变化而变动
+ (CGSize)currentAbsoluteSize;

/// Home键在不定状态时候的相对尺寸 该值会跟随设备方向变化而变动
+ (CGSize)currentRelativeSize;

@end
