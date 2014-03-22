//
//  NMReviewHeaderCell.h
//  NearMe
//
//  Created by Mike Jahn on 3/14/14.
//  Copyright (c) 2014 Mike Jahn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMBusiness.h"

@interface NMReviewHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *businessImage;
@property (weak, nonatomic) IBOutlet UILabel *address1Label;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImageView;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

-(void)configureBusinessImagewithBusiness:(NMBusiness *)business;
-(void)configureRatingImagewithBusiness:(NMBusiness *)business;
-(void)configureAddresswithBusiness:(NMBusiness *)business;
-(void)configureStatewithBusiness:(NMBusiness *)business;
-(void)configureCitywithBusiness:(NMBusiness *)business;
-(void)configureCategorywithBusiness:(NMBusiness *)business;
-(void)configurePhoneNumberwithBusiness:(NMBusiness *)business;
@end
