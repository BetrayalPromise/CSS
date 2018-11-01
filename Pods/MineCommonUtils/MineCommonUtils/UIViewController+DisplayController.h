//
//  UIViewController+DisplayController.h
//  Destruct
//
//  Created by LiChunYang on 25/4/2018.
//  Copyright © 2018 com.qmtv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DisplayController)

+ (instancetype _Nullable)displayController;

@end

extern UIViewController * appRootController(void);

