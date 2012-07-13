//
//  SearchProduct.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDataDetail.h"
#import "MyTableViewCell.h"
#import "SearchProdTBViewCell.h"
#import "GoodsReturn.h"
@class ProductDataDetail;
@class tblProduct;
@class tblParameter;
@class tblReturnDetail;
#define kPICKERCOLUMN 1
#define kBRANDPICKERTAG 0
#define kFAMILYPICKERTAG 1

@interface SearchProduct : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) NSString * plan_ID;
@property(strong,nonatomic)  ProductDataDetail * productDataDetail;
@property(strong,nonatomic)  GoodsReturn * goodsReturn;
@property(strong,nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) IBOutlet UIView *headerView;
@property (nonatomic, retain) IBOutlet UIView *headerViewSelectable;
@property (nonatomic,strong)  UIPickerView *pickerBrand;
@property (nonatomic,strong)  UIPickerView *pickerFamily;
@property (nonatomic,strong)  UIPickerView *activePicker;
@property (nonatomic,strong) IBOutlet  UIPickerView *myPicker;
@property (nonatomic,strong) IBOutlet UIButton *submitButton;
@property(nonatomic,strong) NSArray *pickersArray;
@property(strong,nonatomic)NSMutableArray *productList;
@property(strong,nonatomic)NSMutableArray *parameterList;
@property(strong,nonatomic)NSMutableArray *arrPickerList;

@property (strong, nonatomic) NSMutableArray * arrProdCode; 
@property (strong, nonatomic) NSMutableArray * arrProdName; 
@property (strong, nonatomic) NSMutableArray * arrProdFamily; 
@property (strong, nonatomic) NSMutableArray * arrProdCost; 
@property (strong, nonatomic) NSString * backState;
@property (strong, nonatomic) NSString * previousPage;

@property(strong,nonatomic) IBOutlet UITextField *txtProdCode;
@property(strong,nonatomic) IBOutlet UITextField *txtProdName;
@property(strong,nonatomic) IBOutlet UITextField *txtBrand;
@property(strong,nonatomic) IBOutlet UITextField *txtProdFamily;
@property(strong,nonatomic) IBOutlet UILabel *lblSearchItem;
@property(strong,nonatomic) IBOutlet UITextField *txtSelectProductCode;

@property (strong, nonatomic) NSMutableArray * arrSearchFamily;
@property (strong, nonatomic) NSMutableArray * arrSearchBrand;


@property (strong, nonatomic) NSString * selectedProduct;

- (IBAction)btnSearch:(id)sender;
- (void)assignBackState:(NSString *)state;
- (void)SearchProduct;
- (IBAction)backgroungTab;
- (IBAction)ShowFamilyPicker;
- (IBAction)ShowBrandPicker;
- (IBAction)SubmitSelectProduct;


@end
