//
//  RunMmsegCPlusTests.m
//  RunMmsegCPlusTests
//
//  Created by Gavin on 12-1-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RunMmsegCPlusTests.h"



@implementation RunMmsegCPlusTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.    
    mmseg = [interfaceOfMmseg new];
    [mmseg loadDictionary];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testLatinText
{
    
    NSArray *words = [mmseg run:@"one two three,four;five.six"];
    STAssertEquals(6u, [words count], nil);

    NSString *word1 = [words objectAtIndex:0];
    NSString *word2 = [words objectAtIndex:1];
    NSString *word3 = [words objectAtIndex:2];
    NSString *word4 = [words objectAtIndex:3];
    NSString *word5 = [words objectAtIndex:4];
    NSString *word6 = [words objectAtIndex:5];
    STAssertEquals(NSOrderedSame, [word1 compare:@"one"], nil);
    STAssertEquals(NSOrderedSame, [word2 compare:@"two"], nil);
    STAssertEquals(NSOrderedSame, [word3 compare:@"three"], nil);
    STAssertEquals(NSOrderedSame, [word4 compare:@"four"], nil);
    STAssertEquals(NSOrderedSame, [word5 compare:@"five"], nil);
    STAssertEquals(NSOrderedSame, [word6 compare:@"six"], nil);
}

- (void)testChineseText
{
    NSArray *words = [mmseg run:@"一二三"];
    STAssertEquals(1u, [words count], nil);
    
    NSString *word1 = [words objectAtIndex:0];
    STAssertEquals(NSOrderedSame, [word1 compare:@"一"], nil);
    
}


- (void)testLatinChineseMixText
{
    NSArray *words = [mmseg run:@"一二 one two 三 three."];
    STAssertEquals(4u, [words count], nil);
    
    NSString *word1 = [words objectAtIndex:0];
    NSString *word2 = [words objectAtIndex:1];
    NSString *word3 = [words objectAtIndex:2];
    NSString *word4 = [words objectAtIndex:3];
    STAssertEquals(NSOrderedSame, [word1 compare:@"一二"], nil);
    STAssertEquals(NSOrderedSame, [word2 compare:@"one"], nil);
    STAssertEquals(NSOrderedSame, [word3 compare:@"two"], nil);
    STAssertEquals(NSOrderedSame, [word4 compare:@"三"], nil);
    
}

- (void)testChineseWordText
{
    NSArray *words = [mmseg run:@"我们去吃饭如何？two,three,four"];
    STAssertEquals(4u, [words count], nil);
    
    NSString *word1 = [words objectAtIndex:0];
    NSString *word2 = [words objectAtIndex:1];
    NSString *word3 = [words objectAtIndex:2];
    NSString *word4 = [words objectAtIndex:3];

    
    STAssertEquals(NSOrderedSame, [word1 compare:@"我们"], nil);
    STAssertEquals(NSOrderedSame, [word2 compare:@"去"], nil);
    STAssertEquals(NSOrderedSame, [word3 compare:@"吃饭"], nil);
    STAssertEquals(NSOrderedSame, [word4 compare:@"如何"], nil);
}
@end
