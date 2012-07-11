//
//  ViewController.h
//  TestDB
//
//  Created by Warat Agatwipat on 6/28/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CheckInPage;
@class CallCard;
@class Merchandise;
@class SalesNote;
@class GoodsReturn;
@class InvoiceList;
@class Collection;
@class TakeOrder;
@class Delivery;
@class DeliverySummary;
@class tblSaleTalk;
@class SearchProduct;

@interface ViewController : UIViewController

@property NSInteger stepCount;
@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString * account_ID;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

@property (strong, nonatomic) tblSaleTalk * tblsaleTalk;
@property (strong, nonatomic) IBOutlet CheckInPage * checkInPage;
@property (strong, nonatomic) IBOutlet CallCard *callCard; 
@property (strong, nonatomic) IBOutlet Merchandise * merchaindise;
@property (strong, nonatomic) IBOutlet SalesNote * salesNote;
@property (strong, nonatomic) IBOutlet GoodsReturn * goodsReturn;
@property (strong, nonatomic) IBOutlet InvoiceList * invoiceList;
@property (strong, nonatomic) IBOutlet Collection * collection;
@property (strong, nonatomic) IBOutlet TakeOrder * takeOrder;
@property (strong, nonatomic) IBOutlet Delivery * delivery;
@property (strong, nonatomic) IBOutlet DeliverySummary * deliverySummary;
@property (strong, nonatomic) IBOutlet SearchProduct *searchProduct;

- (void) removeAllSubView;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnNextClick:(id)sender;

@end
