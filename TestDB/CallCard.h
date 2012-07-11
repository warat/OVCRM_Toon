//
//  CallCard.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchProduct.h"
#import "ProductDataDetail.h"

@class tblCallCard;
@class tblCallcard_Stock;
@class ProductInAction;

@interface CallCard : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSString * account_ID;
@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) tblCallCard * tblcallCard;
@property (strong, nonatomic) tblCallcard_Stock * tblcallcard_Stock;
//@property (strong, nonatomic) ProductInAction * productInAction;

@property (strong, nonatomic) NSArray * arrData1;
@property (strong, nonatomic) NSArray * arrData2;
@property (strong, nonatomic) NSArray * arrData3;
@property (strong, nonatomic) NSMutableArray * muTableStock;
@property (strong, nonatomic) NSMutableArray * muTableCallcard;

//@property (strong, nonatomic) IBOutlet UITableView *tableCallCard;
@property (strong, nonatomic) IBOutlet SearchProduct * searchProduct;
@property (strong, nonatomic) IBOutlet ProductDataDetail * productDataDetail;
@property (strong, nonatomic) NSString * tmpProduct;

@property (strong, nonatomic) IBOutlet UITableView *tableData;

-(void) setCallCardPageWithPlan:(NSString *)planID Account:(NSString *)accountID;
-(void) saveCallCardPage;

@end
