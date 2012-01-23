//
//  interfaceOfMmseg.h
//  RunMmsegCPlus
//
//  Created by Gavin on 12-1-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "algor.h"

@interface interfaceOfMmseg : NSObject
- (NSArray *)run: (NSString *)text;
- (void)loadDictionary;
@end
