//
//  NSObject+DynamicProperty.h
//  LcCategoryPropertySample
//
//  Created by 李阳 on 15/8/2016.
//  Copyright © 2016 jiangliancheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (DynamicProperty)

/**
 *  为类目添加址类型属性
 *  @param name   属性的name
 *  @param policy 属性的policy
 */
+ (void)attachAddressProperty:(NSString *)name policy:(objc_AssociationPolicy)policy;

/**
 *  为类目添加值类型属性
 *  @param name 属性的name
 *  @param type 属性的encodingType，如int类型的属性，type为编码类型
 */
+ (void)attachValueProperty:(NSString *)name encodingType:(char *)type policy:(objc_AssociationPolicy)policy;

@end
