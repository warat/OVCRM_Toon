//
//  InvoiceDetail.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvoiceDetail : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSArray * arrData0;
@property (strong, nonatomic) NSArray * arrData1;
@property (strong, nonatomic) NSArray * arrData2;
@property (strong, nonatomic) NSArray * arrData3;

- (IBAction)buttonBack:(id)sender;

@end
