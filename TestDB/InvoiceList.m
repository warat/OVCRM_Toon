//
//  InvoiceList.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "InvoiceList.h"

#import "tblInvoice.h"
#import "tblCollection.h"
#import "TakeOrder.h"

@interface InvoiceList ()

@end

@implementation InvoiceList
@synthesize btnPayInvoice;
@synthesize part2LabelAmount;
@synthesize part2lbMoney;
@synthesize part2LabelBaht;
@synthesize part2LabelReceive;
@synthesize part2TxtReceive;
@synthesize part2LabelBahtRcv;
@synthesize part2LabelCheck;
@synthesize part2TxtCheckNo;
@synthesize part2LabelTransfNo;
@synthesize part2TxtTransfNo;
@synthesize part2LabelBank;
@synthesize part2BtnBank;
@synthesize part2LabelBranch;
@synthesize part2BtnBranch;
@synthesize part2SegmentPay;

@synthesize account_ID,plan_ID;
@synthesize tableData;
@synthesize tblinvoice = _tblinvoice;
@synthesize tblcollection = _tblcollection;
@synthesize lbTotalAmount;
@synthesize lbPayTotal;
@synthesize invoiceDetail = _invoiceDetail;
@synthesize muTableData;
@synthesize payType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self setTitle:@"Ovaltine(CLT)"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToTakeOrder)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    payType = [[NSString alloc]initWithFormat:@"Cash"];
    _tblinvoice = [[tblInvoice alloc]init];
    _tblcollection = [[tblCollection alloc]init];
    muTableData = [[NSMutableArray alloc]init];
    [_tblinvoice OpenConnection];
    [_tblcollection OpenConnection];
    part2TxtReceive.text = [[NSString alloc]initWithFormat:@"0"];
    [self loadDataProduct];
    
    [self setPart2Hidden:YES];
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableData:nil];
    [self setLbTotalAmount:nil];
    [self setLbPayTotal:nil];
    [self setBtnPayInvoice:nil];
    [self setPart2LabelAmount:nil];
    [self setPart2lbMoney:nil];
    [self setPart2LabelBaht:nil];
    [self setPart2LabelReceive:nil];
    [self setPart2TxtReceive:nil];
    [self setPart2LabelBahtRcv:nil];
    [self setPart2LabelCheck:nil];
    [self setPart2TxtCheckNo:nil];
    [self setPart2LabelTransfNo:nil];
    [self setPart2TxtTransfNo:nil];
    [self setPart2LabelBank:nil];
    [self setPart2BtnBank:nil];
    [self setPart2LabelBranch:nil];
    [self setPart2BtnBranch:nil];
    [self setPart2SegmentPay:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return muTableData.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tblInvoice * invoice = [muTableData objectAtIndex:indexPath.row];
    NSInteger tableWidth = tableView.frame.size.width;
    static NSString * iden = @"AAA";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*3/8, 0, 50, 21)];
        textField.placeholder = @"0";
        textField.text = @"";
        textField.delegate = nil;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        
        
        UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*4/8, 0, 50, 21)];
        textField2.placeholder = @"0";
        textField2.text = @"";
        textField2.delegate = nil;
        textField2.borderStyle = UITextBorderStyleRoundedRect;
        [textField2 setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
        
        UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*6/8, 0, 50, 21)];
        textField3.placeholder = @"0";
        textField3.text = @"";
        textField3.delegate = nil;
        textField3.borderStyle = UITextBorderStyleRoundedRect;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        
        UISwitch * switchTable = [[UISwitch alloc]initWithFrame:CGRectMake(15,0,50,10)];
        [switchTable addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventValueChanged];
        
        UILabel * productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105,0,150,20)];
        productNameLabel.text = invoice.invoice_No;
        [productNameLabel setTextAlignment:UITextAlignmentLeft];
        
        UILabel * tableLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/7, 0, 100, 21)];
        tableLabel1.text = invoice.inv_DueDate;
        [tableLabel1 setTextAlignment:UITextAlignmentRight];
        
        UILabel * tableLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*5/7-30, 0, 100, 21)];
        tableLabel2.text = invoice.inv_Total;
        [tableLabel2 setTextAlignment:UITextAlignmentRight];
        
        UIButton * btnInfo = [UIButton buttonWithType:UIButtonTypeInfoDark];
        btnInfo.frame = CGRectMake(tableWidth*3/7-60, 0, 18, 19);
        [btnInfo addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventValueChanged];
         //addTarget:self 
         //           action:@selector(touchSwitch:) 
         // forControlEvents:UIControlEventValueChanged];
        
        UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableWidth,21)];
        myView.backgroundColor = [UIColor clearColor];
        [myView addSubview:productNameLabel];
        [myView addSubview:tableLabel1];
        [myView addSubview:tableLabel2];
        [myView addSubview:btnInfo];
        [myView addSubview:switchTable];   

        cell.accessoryView = myView;
    }
    
    cell.textLabel.text = invoice.invoice_No;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    [cell.detailTextLabel sizeThatFits:CGSizeMake(200, 18)];
    //NSString * detail = [[NSString alloc]initWithFormat:@"%@ \t %@",[arrData3 objectAtIndex:indexPath.row],[arrData3 objectAtIndex:indexPath.row]];
//    cell.detailTextLabel.text = detail;
    return  cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSInteger tableWidth = tableView.frame.size.width;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,-50,tableWidth,100)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * headLabel0 = [[UILabel alloc]initWithFrame:CGRectMake(100,0,80,20)];
    headLabel0.text = @"เลขที่บิล";
    
    UILabel * headLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/7,0,100,20)];
    headLabel1.text = @"วันที่ออกบิล";
    
//    UILabel * headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/7,0,100,20)];
//    headLabel2.text = @"วันครบกำหนด";
    
    UILabel * headLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*5/7,0,100,20)];
    headLabel3.text = @"จำนวนเงิน";
    
    UILabel * headLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*6/7,0,100,20)];
    headLabel4.text = @"ประเภท";
    
    UILabel * headLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*7/8,0,100,20)];
    headLabel5.text = @"ยอดรวม";
    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    myView.backgroundColor = [UIColor clearColor];
    
    headLabel0.backgroundColor = [UIColor clearColor];
    headLabel1.backgroundColor = [UIColor clearColor];
//    headLabel2.backgroundColor = [UIColor clearColor];
    headLabel3.backgroundColor = [UIColor clearColor];
    headLabel4.backgroundColor = [UIColor clearColor];
    
    [headLabel0 setTextAlignment:UITextAlignmentCenter];
    [headLabel1 setTextAlignment:UITextAlignmentCenter];
//    [headLabel2 setTextAlignment:UITextAlignmentCenter];
    [headLabel3 setTextAlignment:UITextAlignmentCenter];
    [headLabel4 setTextAlignment:UITextAlignmentCenter];
    
    [myView addSubview:headLabel0];
    [myView addSubview:headLabel1];
//    [myView addSubview:headLabel2];
    [myView addSubview:headLabel3];
    [myView addSubview:headLabel4];
    
    [headerView addSubview:myView];
    
    return headerView ;
}

/////////////////////////////////////////////////////////////////////
-(NSString *)dateToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];//@"en_US"];
    [dateFormatter setLocale:usLocale];
    return [dateFormatter stringFromDate:sDate];
}

-(NSString *)timeToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];//@"en_US"];
    [dateFormatter setLocale:usLocale];
    return [dateFormatter stringFromDate:sDate];
}

- (void)checkTextField:(UITextField *)textField {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound || [textField.text isEqualToString:@""]) {
        textField.text=@"0";
    }
    NSArray * tmp = [textField.text componentsSeparatedByString:@"."];
    if (tmp.count >2) {
        textField.text = [NSString stringWithFormat:@"%@,%@",[tmp objectAtIndex:0],[tmp objectAtIndex:1]];
    }
    textField.text = [NSString stringWithFormat:@"%g",[textField.text doubleValue]];
}

-(void) nextToTakeOrder
{
    [self saveCollect];
    TakeOrder * nextView = [[TakeOrder alloc]initWithNibName:@"TakeOrder" bundle:nil];
    nextView.account_ID = account_ID;
    nextView.plan_ID = plan_ID;
    [self.navigationController pushViewController:nextView animated:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(void) touchSwitch:(UISwitch *)switchInvoice
{
    NSInteger rowIndex = [self getRowIndex:switchInvoice];
    tblInvoice * invoice = [muTableData objectAtIndex:rowIndex];
    if ([switchInvoice isOn]) {
        invoice.paid = [NSString stringWithFormat:@"Y"]; 
        double payAmount = [lbPayTotal.text doubleValue];
        payAmount = payAmount + [invoice.inv_Total doubleValue];
        lbPayTotal.text = [NSString stringWithFormat:@"%g",payAmount];
        part2lbMoney.text = [NSString stringWithFormat:@"%g",payAmount];
    }else {
        invoice.paid = [NSString stringWithFormat:@"N"]; 
        double payAmount = [lbPayTotal.text doubleValue];
        payAmount = payAmount - [invoice.inv_Total doubleValue];
        lbPayTotal.text = [NSString stringWithFormat:@"%g",payAmount];
        part2lbMoney.text = [NSString stringWithFormat:@"%g",payAmount];
    }
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}



-(void) loadDataProduct
{
    NSString *tableField = [_tblinvoice DB_Field] ;
    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from Invoice Where Account_ID=%@ AND Paid='%@'",tableField ,account_ID,@"N"]; 
    muTableData = [_tblinvoice QueryData:searchString];
    
    double sum = 0.0;
    int ii = 0 ;
    for (ii=0; ii<muTableData.count; ii++) {
        tblInvoice * invoice = [muTableData objectAtIndex:ii];
        sum += [invoice.inv_Total doubleValue];
    }
    lbTotalAmount.text = [[NSString alloc] initWithFormat:@"%g",sum];
    [tableData reloadData];
}

-(void) setPart2Hidden:(BOOL)hidden
{
    [tableData setAlpha:1.0];
    [tableData setUserInteractionEnabled:hidden];
    [self.navigationItem.rightBarButtonItem setEnabled:!hidden];
    [part2LabelAmount setHidden:hidden];
    [part2lbMoney setHidden:hidden];
    [part2LabelBaht setHidden:hidden];
    [part2LabelReceive setHidden:hidden];
    [part2TxtReceive setHidden:hidden];
    [part2LabelBahtRcv setHidden:hidden];
    [part2LabelCheck setHidden:hidden];
    [part2TxtCheckNo setHidden:hidden];
    [part2LabelTransfNo setHidden:hidden];
    [part2TxtTransfNo setHidden:hidden];
    [part2LabelBank setHidden:hidden];
    [part2BtnBank setHidden:hidden];
    [part2LabelBranch setHidden:hidden];
    [part2BtnBranch setHidden:hidden];
    [part2SegmentPay setHidden:hidden];
    if ([part2SegmentPay isHidden]==NO) {
        [tableData setAlpha:0.7];
        switch ([part2SegmentPay selectedSegmentIndex]) {
            case 0:
                [part2LabelCheck setHidden:YES]; 
                [part2TxtCheckNo setHidden:YES]; 
                [part2LabelTransfNo setHidden:YES];
                [part2TxtTransfNo setHidden:YES];
                [part2LabelBank setHidden:YES];
                [part2BtnBank setHidden:YES];
                [part2LabelBranch setHidden:YES];
                [part2BtnBranch setHidden:YES];
                break;
                
            case 1:
                [part2LabelCheck setHidden:NO];
                [part2TxtCheckNo setHidden:NO];
                [part2LabelTransfNo setHidden:YES];
                [part2TxtTransfNo setHidden:YES];
                [part2LabelBank setHidden:YES];
                [part2BtnBank setHidden:YES];
                [part2LabelBranch setHidden:YES];
                [part2BtnBranch setHidden:YES];
                break;
                
            case 2:
                [part2LabelCheck setHidden:YES];
                [part2TxtCheckNo setHidden:YES];
                [part2LabelTransfNo setHidden:NO];
                [part2TxtTransfNo setHidden:NO];
                [part2LabelBank setHidden:NO];
                [part2BtnBank setHidden:NO];
                [part2LabelBranch setHidden:NO];
                [part2BtnBranch setHidden:NO];
                break;
                
            default:
                break;
        }    
    }
}

- (IBAction)touchPayInvoice:(id)sender {
    if ([part2SegmentPay isHidden]) {
        [self setPart2Hidden:NO];
    }else {
        [self setPart2Hidden:YES];
    }
}

- (IBAction)enterReceive:(UITextField *)sender {
    [self checkTextField:sender];
}

- (IBAction)segmentChanged:(UISegmentedControl *)sender {
    [self setPart2Hidden:NO];
    NSInteger segIndex = part2SegmentPay.selectedSegmentIndex;
    payType = [part2SegmentPay titleForSegmentAtIndex:segIndex];
}

-(void) saveCollect{
    if ([lbTotalAmount.text doubleValue] <= [part2TxtReceive.text doubleValue]) {
        [self updateInvoicePaid];
        [self InsertCollect];
    }else {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" 
                                                        message:@"ค่าเงินรับเกิน" 
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil ];
        [alert show];
    }
}

-(void) updateInvoicePaid{
    // ไม่ต้องอัพเดต
}
-(void) InsertCollect{
    NSDate *now = [NSDate date];
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    NSString * sql ;
    NSArray *paramArray ;
    
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblcollection GetMaxRnNo] intValue]] ;
    
    NSInteger ii = 0 ;
    double balance = [part2TxtReceive.text doubleValue];
    double pay = 0.0;
    for (ii=0; ii<muTableData.count; ii++) {
        newPK = [NSString stringWithFormat:@"%i",[newPK intValue]+1];
        tblInvoice * invoice = [muTableData objectAtIndex:ii];
        NSString * myPay = [NSString stringWithFormat:@"0"];
        if ([invoice.paid isEqualToString:@"Y"]) {
            if ([invoice.inv_Total rangeOfString:@"-"].length < 1) {
                if ([invoice.inv_Total doubleValue]<balance) {
                    pay = [invoice.inv_Total doubleValue];
                }else {
                    pay = balance;
                }
                balance = balance - pay;
                myPay = [NSString stringWithFormat:@"%g",pay];
            }
            paramArray = [NSArray arrayWithObjects:plan_ID,newPK,strDate,strTime,invoice.invoice_No,myPay,payType,nil];
            sql = [NSString stringWithFormat:@"Insert Into Collection (Plan_ID, PK, Collect_Date, Collect_Time, Invoice_No, Amount, PayType) Values (?,?,?,?,?,?,?)"];
            [_tblcollection ExecSQL:sql parameterArray:paramArray];
        }
    }
}


@end
