//
//  CallCard.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "CallCard.h"
#import "tblCallCard.h"
#import "tblCallcard_Stock.h"
#import "ProductInAction.h"

#import "Merchandise.h"

@interface CallCard ()

@end

@implementation CallCard

@synthesize account_ID;
@synthesize plan_ID;
@synthesize tblcallCard = _tblcallCard;
@synthesize tblcallcard_Stock = _tblcallcard_Stock;

@synthesize arrData1,arrData2,arrData3;
@synthesize muTableStock,muTableCallcard;

@synthesize searchProduct = _searchProduct;
@synthesize productDataDetail = _productDataDetail;

@synthesize tmpProduct;
@synthesize tableData;

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
    
    [self setTitle:@"Ovaltine(CC)"];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToMerchaindise)];
    [self.navigationItem setRightBarButtonItem:barButton animated:YES];
    
    muTableStock = [[NSMutableArray alloc]init];
    muTableCallcard = [[NSMutableArray alloc]init];
    _tblcallCard = [[tblCallCard alloc]init];
    _tblcallcard_Stock = [tblCallcard_Stock alloc];
    [_tblcallCard OpenConnection];
    [_tblcallcard_Stock OpenConnection];
    
    arrData1 = [[NSArray alloc]initWithObjects:@"BPโอวัลตินUHTไฮไนน์225ML.P36(M)",@"โอวัลติน300กรัม(ถุง)(M)"
                ,@"โอวัลติน3IN1 210 กรัม",@"โอวัลติน3IN1 700G(M)",@"โอวัลติน800กรัมถุง"
                ,@"โอวัลตินUHTรสชอคไขมันต่ำ180มลP4(M)",@"โอวัลตินคลาสิค 150 กรัมถุง(M)"
                ,@"โอวัลตินชอยส์525กรัมถุง",@"โอวัลตินซอยย์สูตรผสมงาดำ490 กรัมแพ็ค14"
                ,@"โอวัลตินยูเอชทีสมาร์ท125มล.แพค4รสชอคโกแลต",@"โอวัลตินยูเอชทีไฮไนน์180มล.M"
                ,@"โอวัลตินยูเอชทีไฮไนน์225มลแพค6(M)",@"โอวัลตินเย็น3IN1ครั้นซ์ชี่630Gถุง"
                ,@"โอวัลตินเย็นครั้นซ์ชี่175กรัม ถุง(M)", nil ];
    
    arrData2 = [[NSArray alloc]initWithObjects:@"22",@"15",@"42",@"10",@"10",@"4",@"3",@"9",@"90",@"32",@"40",@"7",@"14",@"38", nil ];
    
    arrData3 = [[NSArray alloc]initWithObjects:@"100434182",@"100498051",@"100425481",@"100425108",@"100493479",@"100457578",@"100426619",@"100438515",@"100517093",@"100591916",@"100544444",@"100573942",@"100546553",@"100540341",@"100670740",@"100673714",@"100630613",@"100613035",@"100620515",@"100659488",@"100636211",@"100674679",@"100678777",@"100691215",@"100647033",@"100660592",@"100628551", nil ];
    
    [self setCallCardPageWithPlan:plan_ID Account:account_ID];
    
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableData:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return muTableStock.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductInAction * product = [muTableStock objectAtIndex:indexPath.row];
    
    NSInteger tableWidth = tableView.frame.size.width - 400;
    static NSString * iden = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
    }
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*1/5, 0, 50, 21)];
    textField.placeholder = @"0";  
    if (product.cc_Quantity1 < 1) {
        textField.text = @"";
    }else { 
        textField.text = [NSString stringWithFormat:@"%ld", product.cc_Quantity1];
    }
    
    textField.delegate = nil;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textAlignment = UITextAlignmentRight;
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [textField addTarget:self action:@selector(inputNumber1:) forControlEvents:UIControlEventEditingDidEnd];
    
    UIButton * btnInfo = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btnInfo.frame = CGRectMake(20, 0, 18, 19);
    [btnInfo addTarget:self action:@selector(touchInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*1/5+55, 0, 50, 21)];
    textField2.placeholder = @"0"; 
    if (product.cc_quantity2 < 1) {
        textField2.text = @"";
    }else { 
        textField2.text = [NSString stringWithFormat:@"%ld", product.cc_quantity2];
    }
    textField2.text = @"";
    textField2.delegate = nil;
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.textAlignment = UITextAlignmentRight;
    [textField2 setKeyboardType:UIKeyboardTypePhonePad];
    [textField2 addTarget:self action:@selector(inputNumber2:) forControlEvents:UIControlEventEditingDidEnd];
    
    UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*4/5, 0, 50, 21)];
    textField3.placeholder = @"0"; 
    if (product.cc_quantity3 < 1) {
        textField3.text = @"";
    }else { 
        textField3.text = [NSString stringWithFormat:@"%ld", product.cc_quantity3];
    }
    textField3.delegate = nil;
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.textAlignment = UITextAlignmentRight;
    [textField3 setKeyboardType:UIKeyboardTypeNumberPad];
    [textField3 addTarget:self action:@selector(inputNumber3:) forControlEvents:UIControlEventEditingDidEnd];
    
    UILabel * productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25,0,300,20)];
    productNameLabel.text = product.pd_Name;
    [productNameLabel setTextAlignment:UITextAlignmentLeft];
    
    //cell.accessoryView = textField;
    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableWidth,21)];
    myView.backgroundColor = [UIColor clearColor];
    //[myView addSubview:productNameLabel];
    [myView addSubview:btnInfo];
    [myView addSubview:textField];
    [myView addSubview:textField2];
    [myView addSubview:textField3];
    cell.accessoryView = myView;
    
    cell.textLabel.text = product.pd_Name;
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    [cell.detailTextLabel sizeThatFits:CGSizeMake(200, 18)];
    NSString * detail = product.pd_ID;
    cell.detailTextLabel.text = detail;
    //cell.detailTextLabel.text = [arrData2 objectAtIndex:indexPath.row];
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
    headLabel2.text = @"หลังร้าน(กล่อง)";
    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    myView.backgroundColor = [UIColor clearColor];
    
    headLabel0.backgroundColor = [UIColor clearColor];
    headLabel1.backgroundColor = [UIColor clearColor];
    headLabel2.backgroundColor = [UIColor clearColor];
    
    [headLabel0 setTextAlignment:UITextAlignmentCenter];
    [headLabel1 setTextAlignment:UITextAlignmentCenter];
    [headLabel2 setTextAlignment:UITextAlignmentCenter];
    
    [myView addSubview:headLabel0];
    [myView addSubview:headLabel1];
    [myView addSubview:headLabel2];
    
    [headerView addSubview:myView];
    
    return headerView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) touchInfo:(UIButton *)btnInfo
{
    NSInteger rowIndex = [self getRowIndex:btnInfo];
    [self.view.superview addSubview:_productDataDetail.view];
//    [_productDataDetail setProductDetail:[arrData1 objectAtIndex:rowIndex]];
}

-(void) inputNumber1:(UITextField *)textField
{
    [self checkTextField:textField];
    NSInteger rowIndex = [self getRowIndex:textField];
    //Update Into Array
    ProductInAction * product = [muTableStock objectAtIndex:rowIndex];
    [product setCc_Quantity1:[textField.text intValue]];
}

-(void) inputNumber2:(UITextField *)textField
{
    [self checkTextField:textField];
    NSInteger rowIndex = [self getRowIndex:textField];
    //Update Into Array
    ProductInAction * product = [muTableStock objectAtIndex:rowIndex];
    [product setCc_quantity2:[textField.text intValue]];

}
-(void) inputNumber3:(UITextField *)textField
{
    [self checkTextField:textField];
    NSInteger rowIndex = [self getRowIndex:textField];
    //Update Into Array
    ProductInAction * product = [muTableStock objectAtIndex:rowIndex];
    [product setCc_quantity3:[textField.text intValue]];
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    //cellOfText = cellOfText;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}

/////////////////////////////////////////////////////////////////////



-(void) setCallCardPageWithPlan:(NSString *)planID Account:(NSString *)accountID
{
    account_ID = accountID;
    plan_ID = planID;
    [muTableCallcard removeAllObjects];
    [muTableStock removeAllObjects];
    [self loadDataProduct];
}

-(void) saveCallCardPage
{
    NSString * callCardID = [NSString stringWithFormat:@"%@",[self SaveCallCard]];
    [self SaveCallCardStockOfCallCardPK:callCardID];
}

-(void) loadDataProduct
{
    //NSString * sql = [NSString stringWithFormat:@"Select * From CallCard Where Plan_ID=%@",plan_ID];
    //muTableCallcard = [_tblcallCard QueryData:sql];
    
    
    NSString *tableField = [_tblcallCard DB_Field] ;
    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from CallCard Where Plan_ID=%@",tableField ,plan_ID]; 
    muTableCallcard = [[NSMutableArray alloc] init];
    muTableCallcard = [_tblcallCard QueryData:searchString];
    
    
    if (muTableCallcard.count < 1) {
        // LoadDataFromProductMaster
        int ii = 0;
        for (ii=0; ii<arrData1.count; ii++) {
            ProductInAction * product = [[ProductInAction alloc]init];
            product.pd_ID = [arrData3 objectAtIndex:ii];
            product.pd_Name = [arrData1 objectAtIndex:ii];
            [muTableStock addObject:product];
        }
    }else {
        tableField = [_tblcallcard_Stock DB_Field];    
        tblCallCard * callcardPK = [muTableCallcard objectAtIndex:0];
        NSString * sql = [NSString stringWithFormat:@"Select %@ From CallCard_Stock Where CallCard_PK=%@",tableField,callcardPK.PK];
        NSMutableArray * tempTable = [_tblcallcard_Stock QueryData:sql];
        int ii = 0;
        for (ii=0; ii<tempTable.count; ii++) {
            ProductInAction * product = [[ProductInAction alloc]init];
            tblCallcard_Stock * stock =[[tblCallcard_Stock alloc]init];
            stock = [tempTable objectAtIndex:ii];
            product.pd_Name = stock.product_Name;
            product.cc_Quantity1 = [stock.onShelf integerValue];
            product.cc_quantity3 = [stock.inStock integerValue];
            [muTableStock addObject:product];
        }
    }
    [tableData reloadData];
}

-(NSString *) SaveCallCard
{
    NSDate *now = [NSDate date];
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:plan_ID, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From CallCard Where Plan_ID = ?"];
    [_tblcallCard ExecSQL:sql parameterArray:paramArray];
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblcallCard GetMaxRnNo] intValue] +1];
    paramArray = [NSArray arrayWithObjects:plan_ID,newPK,account_ID,strDate,strTime, nil];
    sql = [NSString stringWithFormat:@"Insert Into CallCard (Plan_ID,PK,Account_ID,CS_Date,CS_Time) Values (?,?,?,?,?)"];
    [_tblcallCard ExecSQL:sql parameterArray:paramArray];
    return newPK;
}

-(void) SaveCallCardStockOfCallCardPK:(NSString *)callCardPK
{
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:callCardPK, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From CallCard_Stock Where Callcard_PK = ?"];
    [_tblcallCard ExecSQL:sql parameterArray:paramArray];
    
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblcallcard_Stock GetMaxRnNo] intValue]] ;//] +1];
    
    NSInteger ii = 0 ;
    for (ii=0; ii<muTableStock.count; ii++) {
        newPK = [NSString stringWithFormat:@"%i",[newPK intValue]+1];
        ProductInAction * product = [muTableStock objectAtIndex:ii];
        NSString *q1 = [NSString stringWithFormat:@"%i",product.cc_Quantity1];
        NSString *q2 = [NSString stringWithFormat:@"%i",(product.cc_quantity2+product.cc_quantity3)];
        paramArray = [NSArray arrayWithObjects:callCardPK,newPK,product.pd_Name,q1,q2, nil];
    
        sql = [NSString stringWithFormat:@"Insert Into CallCard_Stock (CallCard_PK,PK,Product_Name,OnShelf,InStock) Values (?,?,?,?,?)"];
        [_tblcallCard ExecSQL:sql parameterArray:paramArray];
    }
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
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound || textField.text==@"") {
        //show alert view here
        textField.text=@"0";
    }
}

-(void) nextToMerchaindise
{
    [self saveCallCardPage];
    Merchandise * nextView = [[Merchandise alloc]initWithNibName:@"Merchandise" bundle:nil];
    nextView.plan_ID = plan_ID;
    nextView.account_ID = account_ID;
    [self.navigationController pushViewController:nextView animated:YES];
}

@end
