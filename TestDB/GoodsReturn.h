//
//  GoodsReturn.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductDataDetail;
@class SearchProduct;
@class tblReturnDetail;
@class tblProduct;
@class GoodReturnTBViewCell;
#define k_RETURN_AMT_TAG 2

@interface GoodsReturn : UIViewController
<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSString * account_ID;
@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString *addProductCode;
@property (strong, nonatomic) NSMutableArray *returnList;
@property (strong,nonatomic) NSMutableArray *productList;

@property(strong,nonatomic) IBOutlet UITextView *noteTextView;
@property(strong,nonatomic) IBOutlet UITableView *myTableView;

@property(strong,nonatomic) NSMutableArray *arrReturnData;

@property (nonatomic, retain) IBOutlet UIView *headerView;

@property (strong, nonatomic)  ProductDataDetail * productDataDetail;
@property (strong, nonatomic)  SearchProduct * searchProduct;
@property (strong, nonatomic) tblProduct *tblProduct;
@property (strong, nonatomic) tblReturnDetail *tblReturnDetail;

@property(strong, nonatomic) NSString *LoadState;

- (IBAction)searchProduct:(id)sender;
- (IBAction)backgroungTab;
@end
