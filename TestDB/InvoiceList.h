//
//  InvoiceList.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InvoiceDetail.h"

@class tblInvoice;
@class tblCollection;

@interface InvoiceList : UIViewController
<UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
}
@property (nonatomic, strong) NSString * account_ID;
@property (nonatomic, strong) NSString * plan_ID;
@property (nonatomic, strong) NSMutableArray * muTableData;
@property (nonatomic, strong) tblInvoice * tblinvoice;
@property (nonatomic, strong) tblCollection * tblcollection;
@property (strong, nonatomic) IBOutlet UILabel *lbTotalAmount;
@property (strong, nonatomic) IBOutlet UILabel *lbPayTotal;
@property (strong, nonatomic) IBOutlet UITableView * tableData;
@property (strong, nonatomic) IBOutlet InvoiceDetail * invoiceDetail;

@property (strong, nonatomic) NSString * payType;
// ปุ่ม Pay / Cancel และข้อมูลการชำระเงินด้านล่าง

@property (strong, nonatomic) IBOutlet UIButton *btnPayInvoice;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelAmount;
@property (strong, nonatomic) IBOutlet UILabel *part2lbMoney;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBaht;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelReceive;
@property (strong, nonatomic) IBOutlet UITextField *part2TxtReceive;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBahtRcv;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelCheck;
@property (strong, nonatomic) IBOutlet UITextField *part2TxtCheckNo;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelTransfNo;
@property (strong, nonatomic) IBOutlet UITextField *part2TxtTransfNo;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBank;
@property (strong, nonatomic) IBOutlet UIButton *part2BtnBank;
@property (strong, nonatomic) IBOutlet UILabel *part2LabelBranch;
@property (strong, nonatomic) IBOutlet UIButton *part2BtnBranch;
@property (strong, nonatomic) IBOutlet UISegmentedControl *part2SegmentPay;







- (IBAction)touchPayInvoice:(id)sender;
- (IBAction)enterReceive:(UITextField *)sender;



- (IBAction)segmentChanged:(UISegmentedControl *)sender;




@end
