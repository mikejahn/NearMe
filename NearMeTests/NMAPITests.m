//
//  NMAPITests.m
//  NearMe
//
//  Created by Mike Jahn on 3/16/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Kiwi/Kiwi.h>
#import "NMAPIClient.h"
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "NMBusinessReviewSearch.h"
#import "NMBusiness.h"

SPEC_BEGIN(NMAPISpec)

describe(@"NMAPIClient", ^{
    __block NMAPIClient *apiClient;
    __block CLLocation *location;
    
    __block NSMutableArray *businessReviewSearches;
    __block NMBusinessReviewSearch *businessReviewSearch;

    
    beforeEach(^{
        apiClient = [[NMAPIClient alloc] init];
        businessReviewSearch = nil;
        CLLocationDegrees latitude = 37.788022;
        CLLocationDegrees longitude = -122.399797;
        location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
            return [request.URL.host isEqualToString:@"api.yelp.com"];
        } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
            // Stub it with our "wsresponse.json" stub file
            return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInBundle(@"businesses.json",nil)
                                                    statusCode:200 headers:@{@"Content-Type":@"application/json"}];
        }];
        
        businessReviewSearches = [NSMutableArray array];
        
        void (^successBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);
        successBlock = ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
            [businessReviewSearches addObjectsFromArray:mappingResult.array];
            businessReviewSearch = [businessReviewSearches objectAtIndex:0];
        };
        void (^failureBlock)(RKObjectRequestOperation *operation, NSError *error);
        failureBlock = ^(RKObjectRequestOperation *operation, NSError *error) {
        };
        
        
        [apiClient getBusinesses:location withSuccessBLock:successBlock withFailureBlock:failureBlock];
    });
    
    describe(@"getBusinesses", ^{
        it(@"it should return 1 NMBusinessReviewSearch object", ^{
            [[[businessReviewSearches shouldEventually] have:1] items];
            id businessReviewSearch = [businessReviewSearches objectAtIndex:0];
            [[businessReviewSearch shouldEventually] beKindOfClass:[NMBusinessReviewSearch class]];
        });
        
        it(@"the returned object should contain an array of NMBusiness objects", ^{
            [[expectFutureValue(businessReviewSearch) shouldEventually] beNonNil];
            [[[businessReviewSearch.businesses shouldEventually] have:5] items];
        });
        
        it(@"should perform correct mapping based on mocked out json", ^{
            [[expectFutureValue(businessReviewSearch) shouldEventually] beNonNil];
            NMBusiness *business = [businessReviewSearch.businesses objectAtIndex:0];
            [[expectFutureValue(business.name) shouldEventually] equal:@"Testing 123"];
            [[expectFutureValue(business.address1) shouldEventually] equal:@"140 New Montgomery St"];
        });
    });

});

SPEC_END