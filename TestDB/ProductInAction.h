//
//  ProductInAction.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/3/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductInAction : UIViewController

@property (strong, nonatomic) NSString * pd_ID;
@property (strong, nonatomic) NSString * pd_Name;
@property (strong,nonatomic) NSDecimalNumber * pd_Price;
@property (strong, nonatomic) NSString * mcd_Price;
@property (strong, nonatomic) NSString * mcd_Share;

@property NSInteger cc_Quantity1;
@property NSInteger cc_quantity2;
@property NSInteger cc_quantity3;
@property NSInteger gr_quantity1;
@property NSInteger dl_quantity1;

@property (strong, nonatomic) NSDecimalNumber * to_Suggest;
@property (strong, nonatomic) NSDecimalNumber * to_Total;
@property (strong, nonatomic) NSDecimalNumber * to_TotalDiscount;
@property (strong, nonatomic) NSDecimalNumber * to_Discount;
@property (strong, nonatomic) NSDecimalNumber * to_Price;
@property (strong, nonatomic) NSDecimalNumber * to_TotalPrice;
@property (strong, nonatomic) NSDecimalNumber * to_Quantity;
@property (strong, nonatomic) NSString * to_DiscountRate;

@end
