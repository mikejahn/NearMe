//
//  NMAPIClient.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMAPIClient.h"
#import "NMMappingProvider.h"
#import <MapKit/MapKit.h>

#define YELP_API_URL @"http://api.yelp.com/"
#define YWSID @"9oXivkoaWDl16jLQA3YE9A"
//#define YWSID @"iXUUomsyqBkdXaypz7539"


@implementation NMAPIClient

-(id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(NSURL *)apiURL {
    return [NSURL URLWithString:YELP_API_URL];
}

            
#pragma mark - RestKit Setup
-(void)setup
{
    self.objectManager = [RKObjectManager managerWithBaseURL:self.apiURL];
   



    [self setupBusinessMapping];
}


-(void)setupBusinessMapping
{
    RKMapping *businessMapping = [NMMappingProvider reviewSearchMapping];
    RKResponseDescriptor *businessResponseDescriptors = [RKResponseDescriptor responseDescriptorWithMapping:businessMapping method:RKRequestMethodGET pathPattern:@"business_review_search" keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:businessResponseDescriptors];
}

#pragma mark - API Calls
-(void)getBusinesses:(CLLocation *)location withSuccessBLock:(SuccessBlock)succuessBlock withFailureBlock:(FailureBlock)failureBlock
{
    
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f", location.coordinate.latitude];
      NSString *longitude = [[NSString alloc] initWithFormat:@"%f", location.coordinate.longitude];
    
    //NSString *url = [[NSString alloc] initWithFormat:@"business_review_search?lat=%@&long=%@&radius=10&limit=10&ywsid=9oXivkoaWDl16jLQA3YE9A", latitude, longitude];
    
    NSDictionary *params = @{@"lat" : latitude,
                             @"long" : longitude,
                             @"term" : @"food",
                             @"limit" : @"20",
                             @"ywsid" : YWSID};
//    NSString *latLon = @"37.33,-122.03";
//    
//    NSString *clientID = @"ialZgmmJLY7oJ1lZivEfLw";
//    NSString *clientSecret = @"QCY-lBXOtgcSSqU5qDbRQWRBTLw=";
//    
//    NSDictionary *queryParams;
//    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:latLon, @"ll", clientID, @"oauth_consumer_key", clientSecret, @"client_secret", @"food", @"term", nil];

    
    [self.objectManager getObjectsAtPath:@"business_review_search" parameters:params success:succuessBlock failure:failureBlock];
}

@end
