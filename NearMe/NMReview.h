//
//  NMReview.h
//  NearMe
//
//  Created by Mike Jahn on 3/14/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NMReview : NSObject
@property (nonatomic, strong) NSString *rating_img_url_small;
@property (nonatomic, strong) NSString *user_photo_url_small;
@property (nonatomic, strong) NSString *rating_img_url;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *user_url;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *user_photo_url;
@property (nonatomic, strong) NSString *text_excerpt;
@property (nonatomic, strong) NSString *mobile_uri;
@end
