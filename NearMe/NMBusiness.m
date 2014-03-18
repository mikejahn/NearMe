//
//  NMBusiness.m
//  NearMe
//
//  Created by Mike Jahn on 2/23/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import "NMBusiness.h"

@implementation NMBusiness

@synthesize name, photo_url, categories, distance, is_closed, latitude, longitude, address1, phone, state, city, reviews, rating_img_url;

-(NSString *)isOpen
{
    BOOL boolValue = [self.is_closed boolValue];    
    return boolValue ? @"Closed" : @"Open";
}

-(NSString *)distanceToString
{
    NSString *shortDistanceString = [self.distance substringWithRange:NSMakeRange(0,3)];
    NSString *milesLabel = @"miles away";
    return [NSString stringWithFormat:@"%@ %@",shortDistanceString, milesLabel];
}



@end
