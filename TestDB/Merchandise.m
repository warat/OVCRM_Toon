//
//  Merchandise.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "Merchandise.h"
#import "tblMerchandize.h"
#import "SalesNote.h"
#import "ProductInAction.h"

@interface Merchandise ()

@end

@implementation Merchandise

@synthesize plan_ID;
@synthesize account_ID;
@synthesize arrData1,arrData2,arrData3;
@synthesize tableData;
@synthesize muTableData;
@synthesize searchProduct = _searchProduct;
@synthesize productDataDetail = _productDataDetail;
@synthesize tblmerchandize = _tblmerchandize;
@synthesize selectedProduct;
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
    [self setTitle:@"Ovaltine(MCD)"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToSalesTalk)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    _tblmerchandize = [[tblMerchandize alloc]init];
    muTableData = [[NSMutableArray alloc]init];
    [_tblmerchandize OpenConnection];
    
    arrData1 = [[NSArray alloc]initWithObjects:@"BPโอวัลตินUHTไฮไนน์225ML.P36(M)",@"โอวัลติน300กรัม(ถุง)(M)"
                ,@"โอวัลติน3IN1 210 กรัม",@"โอวัลติน3IN1 700G(M)",@"โอวัลติน800กรัมถุง"
                ,@"โอวัลตินUHTรสชอคไขมันต่ำ180มลP4(M)",@"โอวัลตินคลาสิค 150 กรัมถุง(M)"
                ,@"โอวัลตินชอยส์525กรัมถุง",@"โอวัลตินซอยย์สูตรผสมงาดำ490 กรัมแพ็ค14"
                ,@"โอวัลตินยูเอชทีสมาร์ท125มล.แพค4รสชอคโกแลต",@"โอวัลตินยูเอชทีไฮไนน์180มล.M"
                ,@"โอวัลตินยูเอชทีไฮไนน์225มลแพค6(M)",@"โอวัลตินเย็น3IN1ครั้นซ์ชี่630Gถุง"
                ,@"โอวัลตินเย็นครั้นซ์ชี่175กรัม ถุง(M)", nil ];
    
    arrData2 = [[NSArray alloc]initWithObjects:@"423.00",@"55.50",@"42.50",@"118.00",@"118.00",@"43.50",@"30.00",@"98.00",@"98.00",@"32.00",@"43.50",@"71.50",@"114.00",@"38.50", nil ];
    
    arrData3 = [[NSArray alloc]initWithObjects:@"100434182",@"100498051",@"100425481",@"100425108",@"100493479",@"100457578",@"100426619",@"100438515",@"100517093",@"100591916",@"100544444",@"100573942",@"100546553",@"100540341",@"100670740",@"100673714",@"100630613",@"100613035",@"100620515",@"100659488",@"100636211",@"100674679",@"100678777",@"100691215",@"100647033",@"100660592",@"100628551", nil ];
    
    [self setMerchandizePageWithPlan:plan_ID Account:account_ID];
//    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTableData:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrData1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductInAction * product = [muTableData objectAtIndex:indexPath.row];
    
    NSInteger tableWidth = tableView.frame.size.width - 400;
    static NSString * iden = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    UIButton * btnInfo = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btnInfo.frame = CGRectMake(20, 0, 18, 19);
    [btnInfo addTarget:self action:@selector(touchInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*1/5+15, 0, 60, 21)];
    textField2.placeholder = @"0";
    if (product.mcd_Price.length < 1) {
        textField2.text = @"";
    }else { 
        textField2.text = [NSString stringWithFormat:@"%@", product.mcd_Price];
    }
    textField2.delegate = nil;
    textField2.borderStyle = UITextBorderStyleRoundedRect;
    textField2.textAlignment = UITextAlignmentRight;
    [textField2 setKeyboardType:UIKeyboardTypePhonePad];
    [textField2 addTarget:self action:@selector(inputNumber1:) forControlEvents:UIControlEventEditingDidEnd];
    
    UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*4/5-25, 0, 75, 21)];
    textField3.placeholder = @"0";
    if (product.mcd_Share.length < 1) {
        textField3.text = @"";
    }else { 
        textField3.text = [NSString stringWithFormat:@"%@", product.mcd_Share];
    }
    textField3.delegate = nil;
    textField3.borderStyle = UITextBorderStyleRoundedRect;
    textField3.textAlignment = UITextAlignmentRight;
    [textField3 setKeyboardType:UIKeyboardTypeNumberPad];
    [textField3 addTarget:self action:@selector(inputNumber2:) forControlEvents:UIControlEventEditingDidEnd];
    
    UILabel * productNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(25,0,300,20)];
    productNameLabel.text = [arrData1 objectAtIndex:indexPath.row];
    [productNameLabel setTextAlignment:UITextAlignmentLeft];
    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableWidth,21)];
    myView.backgroundColor = [UIColor clearColor];
    [myView addSubview:btnInfo];
    [myView addSubview:textField2];
    [myView addSubview:textField3];
    cell.accessoryView = myView;
    
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
    headLabel1.text = @"ราคาขาย(บาท)";
    
    UILabel * headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/5+30,0,120,20)];
    headLabel2.text = @"ชั้นวาง(cm.)";
    
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

-(void) touchInfo:(UIButton *)btnInfo
{
    [self lookProductInfo];
//    NSInteger rowIndex = [self getRowIndex:btnInfo];
//    [self.view.superview addSubview:_productDataDetail.view];
//    [_productDataDetail setProductDetail:[arrData1 objectAtIndex:rowIndex]];
}

-(void) inputNumber1:(UITextField *)textField
{
    [self checkTextField:textField];
    NSInteger rowIndex = [self getRowIndex:textField];
    ProductInAction * product = [muTableData objectAtIndex:rowIndex];
    [product setMcd_Price:textField.text];
}

-(void) inputNumber2:(UITextField *)textField
{
    [self checkTextField:textField];
    NSInteger rowIndex = [self getRowIndex:textField];
    ProductInAction * product = [muTableData objectAtIndex:rowIndex];
    [product setMcd_Share:textField.text];    
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}

/////////////////////////////////////////////////////////////////////



-(void) setMerchandizePageWithPlan:(NSString *)planID Account:(NSString *)accountID
{
//    account_ID = accountID;
//    plan_ID = planID;
    [muTableData removeAllObjects];
    [self loadDataProduct];
}

-(void) loadDataProduct
{
    NSMutableArray * tempTable = [[NSMutableArray alloc]init];
    NSString *tableField = [_tblmerchandize DB_Field] ;
    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from Merchandize Where Plan_ID=%@",tableField ,plan_ID]; 
    tempTable = [_tblmerchandize QueryData:searchString];
    
    if (tempTable.count < 1) {
        int ii = 0;
        for (ii=0; ii<arrData1.count; ii++) {
            ProductInAction * product = [[ProductInAction alloc]init];
            product.pd_ID = [arrData3 objectAtIndex:ii];
            product.pd_Name = [arrData1 objectAtIndex:ii];
            product.mcd_Price = [NSString stringWithFormat:@""];
            product.mcd_Share = [NSString stringWithFormat:@""];
            [muTableData addObject:product];
        }
    }else {
        int ii = 0;
        for (ii=0; ii<tempTable.count; ii++) {
            ProductInAction * product = [[ProductInAction alloc]init];
            tblMerchandize * stock =[[tblMerchandize alloc]init];
            stock = [tempTable objectAtIndex:ii];
            product.pd_Name = stock.product_Name;
            product.mcd_Price = stock.mcd_Price;
            product.mcd_Share = stock.mCD_Share;
            [muTableData addObject:product];
        }
    }
    
    [tableData reloadData];
}

-(void) SaveMerchandise
{
    NSDate *now = [NSDate date];
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:plan_ID, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From Merchandize Where Plan_ID = ?"];
    [_tblmerchandize ExecSQL:sql parameterArray:paramArray];
    
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblmerchandize GetMaxRnNo] intValue]] ;//] +1];
    
    NSInteger ii = 0 ;
    for (ii=0; ii<muTableData.count; ii++) {
        newPK = [NSString stringWithFormat:@"%i",[newPK intValue]+1];
        ProductInAction * product = [muTableData objectAtIndex:ii];
        paramArray = [NSArray arrayWithObjects:plan_ID,newPK,account_ID,product.pd_Name,product.mcd_Price,product.mcd_Share,strDate,strTime,nil];
        
        sql = [NSString stringWithFormat:@"Insert Into Merchandize (Plan_ID, PK, Account_ID, Product_Name, MCD_Price, MCD_Share, MCD_Date, MCD_Time ) Values (?,?,?,?,?,?,?,?)"];
        [_tblmerchandize ExecSQL:sql parameterArray:paramArray];
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
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound || textField.text==@"") {
        //show alert view here
        textField.text=@"0";
    }
    NSArray * tmp = [textField.text componentsSeparatedByString:@"."];
    if (tmp.count >2) {
        textField.text = [NSString stringWithFormat:@"%@,%@",[tmp objectAtIndex:0],[tmp objectAtIndex:1]];
    }
}

-(void) nextToSalesTalk
{
    [self SaveMerchandise];
    SalesNote * nextView = [[SalesNote alloc]initWithNibName:@"SalesNote" bundle:nil];
    nextView.account_ID = account_ID;
    nextView.plan_ID = plan_ID;
    [self.navigationController pushViewController:nextView animated:YES];
}

-(void) lookProductInfo
{
//    [self SaveMerchandise];
    ProductDataDetail * nextView = [[ProductDataDetail alloc]initWithNibName:@"ProductDataDetail" bundle:nil];
    [self.navigationController pushViewController:nextView animated:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
