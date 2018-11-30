//
//  OCExtension.c
//  A
//
//  Created by 李阳 on 29/11/2018.
//  Copyright © 2018 BetrayalPromise. All rights reserved.
//

#include "OCExtension.h"

void blockCleanUp(__strong void (^ *block)(void)) {
    (* block)();
}
