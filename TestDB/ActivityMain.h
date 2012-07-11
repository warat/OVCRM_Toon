//
//  ActivityMain.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallCard.h"
#import "Merchandise.h"
#import "SalesNote.h"
#import "GoodsReturn.h"
#import "InvoiceList.h"
#import "Collection.h"
#import "TakeOrder.h"
#import "Delivery.h"
#import "DeliverySummary.h"
//#import "TakePhoto.h"
#import "SearchProduct.h"

@interface ActivityMain : UIViewController


@property NSInteger stepActivity;
@property (strong, nonatomic) NSMutableArray * currentArray;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;
@property (strong, nonatomic) IBOutlet CallCard *callCard; 
@property (strong, nonatomic) IBOutlet Merchandise * merchaindise;
@property (strong, nonatomic) IBOutlet SalesNote * salesNote;
@property (strong, nonatomic) IBOutlet GoodsReturn * goodsReturn;
@property (strong, nonatomic) IBOutlet InvoiceList * invoiceList;
@property (strong, nonatomic) IBOutlet Collection * collection;
@property (strong, nonatomic) IBOutlet TakeOrder * takeOrder;
@property (strong, nonatomic) IBOutlet Delivery * delivery;
@property (strong, nonatomic) IBOutlet DeliverySummary * deliverySummary;
//@property (strong, nonatomic) IBOutlet SearchProduct * searchProduct;
@property (strong, nonatomic) IBOutlet UIButton *btnCamera;
@property (strong, nonatomic) IBOutlet TakePhoto * takePhoto;

- (IBAction)btnBackClick:(id)sender;
- (IBAction)btnNextClick:(id)sender;
- (void) showCallCard;
- (void) removeAllSubView;
- (IBAction)startCamera:(id)sender;




@end
