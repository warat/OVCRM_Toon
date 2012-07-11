//
//  TakeOrder.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchProduct.h"
#import "ProductDataDetail.h"

@class ProductInAction;
@class tblOrderMaster;
@class tblOrderDetail;

@interface TakeOrder : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSArray * arrData0;
@property (strong, nonatomic) NSArray * arrData1;
@property (strong, nonatomic) NSArray * arrData2;
@property (strong, nonatomic) NSArray * arrData3;
@property (strong, nonatomic) NSString * account_ID;
@property (strong, nonatomic) NSString * plan_ID;

@property (strong, nonatomic) NSMutableArray * muTableMaster;
@property (strong, nonatomic) NSMutableArray * muTableDetail;
@property (strong, nonatomic) IBOutlet UITableView *tableData;
@property (strong, nonatomic) tblOrderDetail * tblorderDetail;
@property (strong, nonatomic) tblOrderMaster * tblorderMaster;

@property (strong, nonatomic) IBOutlet SearchProduct * searchProduct;
@property (strong, nonatomic) IBOutlet UILabel *lbOrderTotal;
@property (strong, nonatomic) IBOutlet ProductDataDetail * productDataDetail;


@end
