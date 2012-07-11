//
//  DeliverySummary.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/25/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceDetail.h"

@interface DeliverySummary : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSArray * arrData0;
@property (strong, nonatomic) NSArray * arrData1;
@property (strong, nonatomic) NSArray * arrData2;
@property (strong, nonatomic) IBOutlet InvoiceDetail * invoiceDetail;
@end
