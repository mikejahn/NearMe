//
//  NMBusinessTests.m
//  NearMe
//
//  Created by Mike Jahn on 3/16/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>
#import "NMBusiness.h"

SPEC_BEGIN(NMBusinesspec)

describe(@"NMBusiness", ^{
    __block NMBusiness *business;
    beforeEach(^{
        business = [[NMBusiness alloc] init];
    });
    
    describe(@"isOpen", ^{
        it(@"should return 'Open' when is_closed is set to false", ^{
            [business setIs_closed:@"false"];
            [[business.isOpen should] equal:@"OPEN"];
        });
        
        it(@"should return 'Closed' when is_closed is set to true", ^{
            [business setIs_closed:@"true"];
            [[business.isOpen should] equal:@"CLOSED"];
        });
        
    });
    
    describe(@"distanceToString", ^{
        it(@"should return truncated string with extra label", ^{
            [business setDistance:@"5.5556426"];
            [[business.distanceToString should] equal:@"5.5 miles away"];
        });
        
        
    });
  
});

SPEC_END
