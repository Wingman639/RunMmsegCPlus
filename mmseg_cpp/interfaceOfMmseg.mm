//
//  interfaceOfMmseg.m
//  RunMmsegCPlus
//
//  Created by Gavin on 12-1-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "interfaceOfMmseg.h"
#import "token.h"
#import <ctype.h>

@implementation interfaceOfMmseg

- (NSArray *)run: (NSString *)text {
    rmmseg::Algorithm *algorithm = new rmmseg::Algorithm([text UTF8String], [text length]);
    
    NSMutableArray *wordList = [NSMutableArray new];
    while (YES) {
        rmmseg::Token tk = algorithm->next_token();
        if (tk.length == 0) {
            break;
        }
        
        NSStringEncoding encoding = NSASCIIStringEncoding;
        if (!isascii(tk.text[0])) {
            encoding = NSUTF8StringEncoding;
        }
        NSString *word = [[NSString alloc]initWithBytes:tk.text length:tk.length encoding:encoding];
        [wordList addObject:word];  
    }
    return wordList;
}

- (void)loadDictionary{
    if (rmmseg::dict::load_chars("/share_svn/mmseg-cpp/RunMmsegCPlus/data/chars.dic")){
        
    }
    else
        NSLog(@"Load chars.dic error.");
    
    if (rmmseg::dict::load_words("/share_svn/mmseg-cpp/RunMmsegCPlus/data/words.dic")){
        
    }
    else
        NSLog(@"Load words.dic error.");
}

@end
