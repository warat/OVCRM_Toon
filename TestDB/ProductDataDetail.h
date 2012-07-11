//
//  ProductDataDetail.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class tblProduct;
@class SearchProduct;

@interface ProductDataDetail : UIViewController

@property(nonatomic,strong) SearchProduct *searchMyProduct;
@property(nonatomic,strong) NSString *productID;
@property(strong,nonatomic)NSMutableArray *productList;

//****** Label of Product Detail ********
@property(strong,nonatomic)IBOutlet UILabel *lblProductName;
@property(strong,nonatomic)IBOutlet UILabel *lblProductCode;
@property(strong,nonatomic)IBOutlet UILabel *lblProductCategory;
@property(strong,nonatomic)IBOutlet UILabel *lblBrand;
@property(strong,nonatomic)IBOutlet UILabel *lblProductFamily;
@property(strong,nonatomic)IBOutlet UILabel *lblPackSize;
@property(strong,nonatomic)IBOutlet UILabel *lblPackaging;
@property(strong,nonatomic)IBOutlet UILabel *lblWeight;
@property(strong,nonatomic)IBOutlet UILabel *lblWidth;
@property(strong,nonatomic)IBOutlet UILabel *lblHeight;
@property(strong,nonatomic)IBOutlet UILabel *lblLong;
@property(strong,nonatomic)IBOutlet UILabel *lblCost;
//****************************************
  

-(void)ShowProductID:(NSString *)prodID;

@end
