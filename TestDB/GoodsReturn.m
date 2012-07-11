//
//  GoodsReturn.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "GoodsReturn.h"
#import "ProductDataDetail.h"
#import "SearchProduct.h"
#import "tblReturnDetail.h"
#import "InvoiceList.h"

@interface GoodsReturn ()

@end

@implementation GoodsReturn

@synthesize arrData1,arrData2,arrData3;
@synthesize productDataDetail = _productDataDetail;
@synthesize searchProduct = _searchProduct;
@synthesize account_ID,plan_ID;
@synthesize addProductCode;
@synthesize arrProdReturn;
@synthesize noteTextView;

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
    [self setTitle:@"Goods Return"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToInvoiceList)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"data===%@",addProductCode);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)AddNewProduct
{
    self.noteTextView.text = self.addProductCode;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrData1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tableWidth = tableView.frame.size.width - 400;
    static NSString * iden = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

        UIButton * btnInfo = [UIButton buttonWithType:UIButtonTypeInfoDark];
        btnInfo.frame = CGRectMake(20, 0, 18, 19);
        
        [btnInfo addTarget:self action:@selector(touchInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*4/5, 0, 50, 21)];
        textField2.placeholder = @"0";
        textField2.text = @"";
        textField2.delegate = nil;
        textField2.borderStyle = UITextBorderStyleRoundedRect;
        textField2.textAlignment = UITextAlignmentRight;
        [textField2 setKeyboardType:UIKeyboardTypePhonePad];
        [textField2 addTarget:self action:@selector(inputNumber2:) forControlEvents:UIControlEventEditingDidEnd];
        
        
        UILabel * productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25,0,300,20)];
        productNameLabel.text = [arrData1 objectAtIndex:indexPath.row];
        [productNameLabel setTextAlignment:UITextAlignmentLeft];
        
        UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableWidth,21)];
        myView.backgroundColor = [UIColor clearColor];
        [myView addSubview:btnInfo];
        [myView addSubview:textField2];
        cell.accessoryView = myView;
    }
    
    cell.textLabel.text = [arrData1 objectAtIndex:indexPath.row];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    [cell.detailTextLabel sizeThatFits:CGSizeMake(200, 18)];
    NSString * detail = [[NSString alloc]initWithFormat:@"%@ \t %@",[arrData3 objectAtIndex:indexPath.row],[arrData3 objectAtIndex:indexPath.row]];
    cell.detailTextLabel.text = detail;
    return  cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSInteger tableWidth = tableView.frame.size.width;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,100,tableWidth,100)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * headLabel0 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,80,20)];
    headLabel0.text = @"สินค้า";
    
    UILabel * headLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/5,0,120,20)];
    headLabel1.text = @"หน้าร้าน(ชิ้น/กล่อง)";
    
    UILabel * headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/5+30,0,120,20)];
    headLabel2.text = @"จำนวน(กล่อง)";//@"หลังร้าน(กล่อง)";
    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    myView.backgroundColor = [UIColor clearColor];
    
    headLabel0.backgroundColor = [UIColor clearColor];
    headLabel1.backgroundColor = [UIColor clearColor];
    headLabel2.backgroundColor = [UIColor clearColor];
    
    [headLabel0 setTextAlignment:UITextAlignmentCenter];
    [headLabel1 setTextAlignment:UITextAlignmentCenter];
    [headLabel2 setTextAlignment:UITextAlignmentCenter];
    
    [myView addSubview:headLabel0];
//    [myView addSubview:headLabel1];
    [myView addSubview:headLabel2];
    
    [headerView addSubview:myView];
    
    return headerView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //[self.view.superview addSubview:_productDataDetail.view];
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


-(void) touchInfo:(UIButton *)btnInfo
{

    //    NSInteger rowIndex = [self getRowIndex:btnInfo];
//    [self.view.superview addSubview:_productDataDetail.view];
//    [_productDataDetail setProductDetail:[arrData1 objectAtIndex:rowIndex]];
}

-(void) inputNumber1:(UITextField *)textField
{
    NSInteger rowIndex = [self getRowIndex:textField];
    //Update Into Array
}
-(void) inputNumber2:(UITextField *)textField
{
    NSInteger rowIndex = [self getRowIndex:textField];
    //Update Into Array
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    //cellOfText = cellOfText;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}


- (IBAction)searchProduct:(id)sender 
{
//    [self.view.superview addSubview:_searchProduct.view];    
    SearchProduct * nextView = [[SearchProduct alloc]initWithNibName:@"SearchProduct" bundle:nil];
    nextView.previousPage = @"GR";
    [self.navigationController pushViewController:nextView animated:YES];
}


-(void) nextToInvoiceList
{
    //[self SaveMerchandise];
    InvoiceList * nextView = [[InvoiceList alloc]initWithNibName:@"InvoiceList" bundle:nil];
    nextView.account_ID = account_ID;
    nextView.plan_ID = plan_ID;
    [self.navigationController pushViewController:nextView animated:YES];
}

@end
