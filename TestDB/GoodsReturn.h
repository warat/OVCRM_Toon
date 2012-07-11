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

@interface GoodsReturn : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSArray * arrData1;
@property (strong, nonatomic) NSArray * arrData2;
@property (strong, nonatomic) NSArray * arrData3;
@property (strong, nonatomic) NSString * account_ID;
@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString *addProductCode;
@property (strong, nonatomic) NSMutableArray *arrProdReturn;

@property(strong,nonatomic) IBOutlet UITextView *noteTextView;

@property (strong, nonatomic) IBOutlet ProductDataDetail * productDataDetail;
@property (strong, nonatomic) IBOutlet SearchProduct * searchProduct;
- (IBAction)searchProduct:(id)sender;
- (void)AddNewProduct;
@end
