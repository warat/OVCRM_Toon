//
//  Merchandise.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchProduct.h"
#import "ProductDataDetail.h"

@class ProductInAction;
@class tblMerchandize;

@interface Merchandise : UIViewController
<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString * account_ID;

@property (strong, nonatomic) NSArray * arrData1;
@property (strong, nonatomic) NSArray * arrData2;
@property (strong, nonatomic) NSArray * arrData3;
@property (strong, nonatomic) IBOutlet UITableView *tableData;
@property (strong, nonatomic) NSMutableArray * muTableData;
@property (strong, nonatomic) NSString * selectedProduct;
@property (strong, nonatomic) tblMerchandize * tblmerchandize;

@property (strong, nonatomic) IBOutlet SearchProduct * searchProduct;
@property (strong, nonatomic) IBOutlet ProductDataDetail * productDataDetail;

@end
