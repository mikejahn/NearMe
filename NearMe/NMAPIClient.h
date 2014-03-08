//
//  NMAPIClient.h
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <MapKit/MapKit.h>


@interface NMAPIClient : NSObject
@property (nonatomic, strong, readwrite) RKObjectManager *objectManager;
typedef void (^ SuccessBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);
typedef void (^ FailureBlock)(RKObjectRequestOperation *operation, NSError *error);

//API calls
-(void)getBusinesses:(CLLocation *)location withSuccessBLock:(SuccessBlock)succuessBlock withFailureBlock:(FailureBlock)failureBlock;

@end
