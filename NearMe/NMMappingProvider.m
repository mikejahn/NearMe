//
//  NMMappingProvider.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMMappingProvider.h"
#import "NMBusiness.h"
#import "NMBusinessReviewSearch.h"
#import "NMCategory.h"
#import "NMReview.h"

@implementation NMMappingProvider

+ (RKMapping *)businessMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NMBusiness class]];
    NSDictionary *mappingDictionary = @{@"name": @"name",
                                        @"photo_url": @"photo_url",
                                        @"distance": @"distance",
                                        @"is_closed": @"is_closed",
                                        @"latitude" : @"latitude",
                                        @"longitude" : @"longitude",
                                        @"address1" : @"address1",
                                        @"state" : @"state",
                                        @"city" : @"city",
                                        @"phone" : @"phone",
                                        @"rating_img_url" : @"rating_img_url"
                                        };
    [mapping addAttributeMappingsFromDictionary:mappingDictionary];
     [mapping addRelationshipMappingWithSourceKeyPath:@"categories" mapping:[self categoryMapping]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"reviews" mapping:[self reviewMapping]];

    return mapping;
}

+ (RKMapping *)categoryMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NMCategory class]];
    NSDictionary *mappingDictionary = @{@"name": @"name",
                                        @"category_filter" : @"category_filter"
                                        };
    [mapping addAttributeMappingsFromDictionary:mappingDictionary];
    return mapping;
}

+ (RKMapping *)reviewMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NMReview class]];
    NSDictionary *mappingDictionary = @{@"rating" : @"rating",
                                        @"rating_img_url" : @"rating_img_url",
                                        @"rating_img_url_small" : @"rating_img_url_small",
                                        @"user_name" : @"user_name",
                                        @"user_photo_url" : @"user_photo_url",
                                        @"user_photo_url_small" : @"user_photo_url_small",
                                        @"user_url" : @"user_url",
                                        @"text_excerpt" : @"text_excerpt",
                                        @"mobile_uri" : @"mobile_uri"
                                        };
    [mapping addAttributeMappingsFromDictionary:mappingDictionary];
    return mapping;
}

+ (RKMapping *) reviewSearchMapping {
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[NMBusinessReviewSearch class]];
    [mapping addRelationshipMappingWithSourceKeyPath:@"businesses" mapping:[self businessMapping]];
    return mapping;
}


@end
