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
#import "tblProduct.h"
#import "GoodReturnTBViewCell.h"

@interface GoodsReturn ()

@end

@implementation GoodsReturn

@synthesize arrReturnData,productList;
@synthesize productDataDetail = _productDataDetail;
@synthesize searchProduct = _searchProduct;
@synthesize tblProduct = _tblProduct;
@synthesize tblReturnDetail = _tblReturnDetail;
@synthesize account_ID,plan_ID;
@synthesize addProductCode;
@synthesize returnList;
@synthesize noteTextView;
@synthesize myTableView;
@synthesize headerView;
@synthesize LoadState;

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
    self.LoadState = @"Y";
    plan_ID = @"P001"; //******* Remove this line, for Testing only ********
    [self setTitle:@"Goods Return"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToInvoiceList)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    _tblProduct = [[tblProduct alloc] init];
    _tblReturnDetail = [[tblReturnDetail alloc] init];
    arrReturnData = [[NSMutableArray alloc] init]; 
    
    if ([_tblProduct OpenConnection] == NO) 
    {
        UIAlertView *alertDialog;
        alertDialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Database Error!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertDialog show];
    }
    else
    {
        if ([_tblReturnDetail OpenConnection] == NO) 
        {
            UIAlertView *alertDialog;
            alertDialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Database Error!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertDialog show];
        }
    }
    
    [self LoadFromDatabase];
//    _tblProduct = [[tblProduct alloc] init];
//    _tblReturnDetail = [[tblReturnDetail alloc] init];
//    arrReturnData = [[NSMutableArray alloc] init]; 
//    
//    if ([_tblProduct OpenConnection] == NO) 
//    {
//        UIAlertView *alertDialog;
//        alertDialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Database Error!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alertDialog show];
//    }
//    else
//    {
//        if ([_tblReturnDetail OpenConnection] == NO) 
//        {
//            UIAlertView *alertDialog;
//            alertDialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Database Error!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//            [alertDialog show];
//        }
//    }
//            
//    [self LoadFromDatabase];   
    
    [super viewDidLoad];
}

-(IBAction)backgroungTab
{
    [self.noteTextView resignFirstResponder];       
}

-(void)viewWillAppear:(BOOL)animated
{       
    if (![self.LoadState isEqualToString: @"Y"]) //เพื่อให้เข้า ViewDidLoad แค่ครั้งเดียว
    {
      self.view = nil; //Fire Event ViewDidLoad            
    }
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

-(void) PrepareArrayData
{
    tblProduct *tempProduct = [[tblProduct alloc] init];
    for (NSInteger ii=0; ii< [arrReturnData count]; ii++)
    {
        UITextField *field = (UITextField *)[self.view viewWithTag:k_RETURN_AMT_TAG + ii];        
                                
        tempProduct = [arrReturnData objectAtIndex:ii];                
        
        tempProduct.returnAmt = field.text;
        [arrReturnData replaceObjectAtIndex:ii withObject:tempProduct] ;
        
        
        //NSLog(@"val222===%@",[(tblProduct *)[arrReturnData objectAtIndex:ii] returnAmt]  );
    }
}

-(void) SaveDatabase
{
    self.addProductCode = NULL; //Reset value before came back to this page again
    [self PrepareArrayData];
    
    tblProduct *tempProduct = [[tblProduct alloc] init];
    
    NSArray *paramArray ;
    
    NSString * sql = [NSString stringWithFormat:@"Delete From ReturnDetail Where Plan_ID = '%@'",plan_ID];
    [_tblProduct ExecSQL:sql parameterArray:nil];    
    
    NSInteger ii = 0 ;
    for (ii=0; ii< arrReturnData.count; ii++) {
        
        tempProduct = [arrReturnData objectAtIndex:ii];
        
        paramArray = [NSArray arrayWithObjects:plan_ID,plan_ID,tempProduct.product_Code ,[NSString stringWithFormat:@"%@", tempProduct.returnAmt],noteTextView.text , nil];                     
        
        //Insert ค่าโดยให้PK เท่ากับPlan_ID ไปก่อน เนื่องจากแผนที่สร้างใหม่ ตอนsync ขึ้นฝั่ง Sale force ไม่ได้มีPKอยู่
        sql = [NSString stringWithFormat:@"Insert Into ReturnDetail (PK,Plan_ID,Product_ID,Quantity,Reason) Values (?,?,?,?,?)"];
       if ([_tblProduct ExecSQL:sql parameterArray:paramArray] == NO)
       {
           UIAlertView *alertDialog;
           alertDialog = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Save Fail!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
           [alertDialog show];
       }
    }
}


-(void)LoadFromDatabase
{
    tblReturnDetail *tempReturn = [[tblReturnDetail alloc] init];
    //arrReturnData = [[NSMutableArray alloc] init]; 

    NSMutableDictionary *mapping = [NSMutableDictionary dictionary];
    NSString *tableField = [_tblReturnDetail DB_Field] ; 
    NSString *cond = [[NSString alloc] initWithFormat:@"select %@ from ReturnDetail where Plan_ID='%@'",tableField,plan_ID];
    NSString *pCodeList = [[NSString alloc] init];
    
    
    //Step 1:หา Product_ID และ Quantity ก่อนจากตาราง ReturnDetail เพื่อมา add ลง class Product อีกที เนื่องจาก arrReturnData เก็บเป็น tblProduct
    returnList=[_tblReturnDetail QueryData:cond];                   
    
    if(returnList.count > 0){
        self.noteTextView.text =  [(tblReturnDetail *)[returnList objectAtIndex:0] reason];
        for (int i=0;i<=returnList.count-1;i++)
        {
            tempReturn = [returnList objectAtIndex:i];
            
            pCodeList = [NSString stringWithFormat:@"%@'%@'",pCodeList,tempReturn.product_ID];
            //Addลง Dictionary ไว้ ตอน กำหนดค่าใส่ arrReturnData ด้านล่าง
            [mapping setObject:tempReturn.quantity forKey:tempReturn.product_ID];        
        }     
        //แปลงให้อยู่ในformat ของ set        
       pCodeList = [pCodeList stringByReplacingOccurrencesOfString:@"''" withString:@"','"];
        
        
         NSString *tableProductField = [_tblProduct DB_Field] ; 
         NSString *cond2 = [[NSString alloc] initWithFormat:@"select %@ from Product where Product_Code in (%@)",tableProductField,pCodeList];
        
        NSLog(@"%@",cond2);
        arrReturnData=[_tblProduct QueryData:cond2]; 
        
         //Step 2 Add ค่า Quantity ลง arrReturnData ก่อน bind ให้ tableView
         if(arrReturnData.count > 0)
         {
           for (int xx=0;xx<=arrReturnData.count-1;xx++)
           {
               tblProduct *tempProduct  = [arrReturnData objectAtIndex:xx];
            
               tempProduct.returnAmt = [mapping objectForKey:tempProduct.product_Code];                              
               
               [arrReturnData replaceObjectAtIndex:xx withObject:tempProduct] ;
           }
         }        
    }    
       
//    NSLog(@"count===%i",arrReturnData.count);
    
    [myTableView reloadData];
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}

//เก็บค่าของจำนวนของที่คืนลง array
-(void) inputReturnAmt:(UITextField *)myTextField
{
    NSInteger rowIndex = [self getRowIndex:myTextField];    
    tblProduct *tempProd = [arrReturnData objectAtIndex:rowIndex];
    
    tempProd.returnAmt = myTextField.text;
    [arrReturnData replaceObjectAtIndex:rowIndex withObject:tempProd] ;                      
}

-(NSString *)CheckDuplicate:(NSString *)sProdCode
{
    NSString *sDup = [[NSString alloc] initWithString:@"N" ];
    tblProduct *tempProd = [[tblProduct alloc] init];
    
    for (int i=0;i<=arrReturnData.count-1;i++)
    {
        tempProd = [arrReturnData objectAtIndex:i];
        if ([tempProd.product_Code isEqualToString:sProdCode]) 
        {
            sDup = @"Y";
        } 
    }
    
    return sDup;
}

//- (IBAction)AddNewProduct
//{    
//    
//    tblProduct *myProduct = [[tblProduct alloc] init];
//    NSMutableArray *retProductList = [[NSMutableArray alloc] init];
//    
//    NSString *tableField = [_tblProduct DB_Field] ; 
//    NSString *cond = [[NSString alloc] initWithFormat:@"select %@ from Product where 1=1",tableField];
//    
//    cond = [NSString stringWithFormat:@"%@ and Product_Code in (%@)",cond , self.addProductCode];        
//    
//    retProductList=[_tblProduct QueryData:cond];               
//    
//    //NSLog(@"count=%i",retProductList.count);
//    
//    if(retProductList.count > 0){
//        for (int i=0;i<=retProductList.count-1;i++)
//        {
//            myProduct = [retProductList objectAtIndex:i]  ;
//            
//            //ต้องเช็คก่อนว่า product นี้มีอยู่ใน tableView เดิมรึยัง
//            if ( [[self CheckDuplicate:myProduct.product_Code] isEqualToString:@"N"])
//            {
//               [arrReturnData addObject:myProduct];                   
//            }
//        }         
//    }
////    [myTableView reloadData];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrReturnData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    tblProduct *tempProduct = [[tblProduct alloc] init];
    
    GoodReturnTBViewCell *cell = (GoodReturnTBViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GoodReturnTBViewCell" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    tempProduct = [arrReturnData objectAtIndex:indexPath.row];
    cell.lblProdCode.text = tempProduct.product_Code;
    cell.lblProdName.text = tempProduct.product_Name;
    cell.txtReturnAmt.text = tempProduct.returnAmt;
    
    UITextField *txtAmount = cell.txtReturnAmt ; 
    txtAmount.delegate = nil;
    [txtAmount setKeyboardType:UIKeyboardTypeNumberPad]; 
//    NSString *tmpTag = indexPath.row;//[NSString stringWithFormat:@"TR,%@", indexPath.row];
    txtAmount.tag = k_RETURN_AMT_TAG + indexPath.row;
//    [txtAmount addTarget:self action:@selector(inputReturnAmt:) forControlEvents:UIControlEventEditingDidEnd];
    
    return cell;    
        
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
  
{
    return self.headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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


- (IBAction)searchProduct:(id)sender 
{
    [self SaveDatabase];
    self.LoadState = @""; //Reset value เพื่อที่เวลากลับมาจากหน้า SearchProduct จะได้เข้า ViewDidLoad ได้    
    
    SearchProduct * nextView = [[SearchProduct alloc]initWithNibName:@"SearchProduct" bundle:nil];
    nextView.previousPage = @"GR";
    nextView.plan_ID = plan_ID;
    
    [self.navigationController pushViewController:nextView animated:YES];
}


-(void) nextToInvoiceList
{
    [self SaveDatabase];
    
    InvoiceList * nextView = [[InvoiceList alloc]initWithNibName:@"InvoiceList" bundle:nil];
    nextView.account_ID = account_ID;
    nextView.plan_ID = plan_ID;
    [self.navigationController pushViewController:nextView animated:YES];
}

@end
