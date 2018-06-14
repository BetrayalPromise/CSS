//
//  FastCoder.h
//  FastCoder
//
//  Created by 李阳 on 3/11/15.
//  Copyright © 2015 LiChunYang. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for FastCoder.
FOUNDATION_EXPORT double FastCoderVersionNumber;

//! Project version string for FastCoder.
FOUNDATION_EXPORT const unsigned char FastCoderVersionString[];


#import <Foundation/Foundation.h>


extern NSString *const FastCodingException;


@interface NSObject (FastCoding)

+ (NSArray *)fastCodingKeys;
- (id)awakeAfterFastCoding;
- (Class)classForFastCoding;
- (BOOL)preferFastCoding;

@end


@interface FastCoder : NSObject

+ (id)objectWithData:(NSData *)data;
+ (id)propertyListWithData:(NSData *)data;
+ (NSData *)dataWithRootObject:(id)object;

@end
