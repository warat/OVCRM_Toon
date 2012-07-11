//
//  TakeOrder.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "TakeOrder.h"
#import "tblOrderMaster.h"
#import "tblOrderDetail.h"
#import "Delivery.h"
#import "ProductInAction.h"

@interface TakeOrder ()

@end

@implementation TakeOrder
@synthesize account_ID,plan_ID;
@synthesize arrData0,arrData1,arrData2,arrData3;

@synthesize tableData,muTableMaster,muTableDetail;
@synthesize tblorderDetail = _tblorderDetail;
@synthesize tblorderMaster = _tblorderMaster;
@synthesize searchProduct = _searchProduct;
@synthesize lbOrderTotal;
@synthesize productDataDetail = _productDataDetail;
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
    [self setTitle:@"Ovaltine(TO)"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToDelivery)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    _tblorderMaster = [[tblOrderMaster alloc]init];
    [_tblorderMaster OpenConnection];
    _tblorderDetail = [[tblOrderDetail alloc]init];
    [_tblorderDetail OpenConnection];
    muTableMaster = [[NSMutableArray alloc]init];
    muTableDetail = [[NSMutableArray alloc]init];
    
    arrData0 = [[NSArray alloc]initWithObjects:@"BPโอวัลตินUHTไฮไนน์225ML.P36(M)",@"โอวัลติน300กรัม(ถุง)(M)"
                ,@"โอวัลติน3IN1 210 กรัม",@"โอวัลติน3IN1 700G(M)",@"โอวัลติน800กรัมถุง"
                ,@"โอวัลตินUHTรสชอคไขมันต่ำ180มลP4(M)",@"โอวัลตินคลาสิค 150 กรัมถุง(M)"
                ,@"โอวัลตินชอยส์525กรัมถุง",@"โอวัลตินซอยย์สูตรผสมงาดำ490 กรัมแพ็ค14"
                ,@"โอวัลตินยูเอชทีสมาร์ท125มล.แพค4รสชอคโกแลต",@"โอวัลตินยูเอชทีไฮไนน์180มล.M"
                ,@"โอวัลตินยูเอชทีไฮไนน์225มลแพค6(M)",@"โอวัลตินเย็น3IN1ครั้นซ์ชี่630Gถุง"
                ,@"โอวัลตินเย็นครั้นซ์ชี่175กรัม ถุง(M)", nil ];
    
    arrData1 = [[NSArray alloc]initWithObjects:@"2",@"6",@"5",@"9",@"3",@"0",@"3",@"2",@"1",@"3",@"2",@"9",@"9",@"9", nil ];
    
    arrData2 = [[NSArray alloc]initWithObjects:@"423.00",@"55.50",@"42.50",@"118.00",@"118.00",@"43.50",@"30.00",@"98.00",@"98.00",@"32.00",@"43.50",@"71.50",@"114.00",@"38.50", nil ];
    
    arrData3 = [[NSArray alloc]initWithObjects:@"100434182",@"100498051",@"100425481",@"100425108",@"100493479",@"100457578",@"100426619",@"100438515",@"100517093",@"100591916",@"100544444",@"100573942",@"100546553",@"100540341",@"100670740",@"100673714",@"100630613",@"100613035",@"100620515",@"100659488",@"100636211",@"100674679",@"100678777",@"100691215",@"100647033",@"100660592",@"100628551", nil ];

    [self setTakeOrderPageWithPlan:plan_ID Account:account_ID];
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLbOrderTotal:nil];
    //[super viewDidUnload];
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
    NSInteger tableWidth = (tableView.frame.size.width)/2;
    static NSString * iden = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*2/10, 0, 40, 21)];
        textField.placeholder = @"0";
        textField.text = @"";
        textField.delegate = nil;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.textAlignment = UITextAlignmentRight;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        
        
        UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*7/10-20, 0, 40, 21)];
        textField2.placeholder = @"0";
        textField2.text = @"";
        textField2.delegate = nil;
        textField2.borderStyle = UITextBorderStyleRoundedRect;
        textField2.textAlignment = UITextAlignmentRight;
        [textField2 setKeyboardType:UIKeyboardTypePhonePad];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,30,20)];
        label1.text = [arrData1 objectAtIndex:indexPath.row];
        [label1 setTextAlignment:UITextAlignmentRight];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/10-20,0,90,20)];
        label2.text = [arrData2 objectAtIndex:indexPath.row];
        [label2 setTextAlignment:UITextAlignmentRight];
        
        UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*8/10-10,0,90,20)];
        label3.text = [arrData2 objectAtIndex:indexPath.row];
        [label3 setTextAlignment:UITextAlignmentRight];
        
        UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(tableWidth,0,tableWidth,21)];
        myView.backgroundColor = [UIColor clearColor];
        
        [myView addSubview:textField];
        [myView addSubview:textField2];
        [myView addSubview:label1];
        [myView addSubview:label2];
        [myView addSubview:label3];
        
        cell.accessoryView = myView;
    }
    
    cell.textLabel.text = [arrData0 objectAtIndex:indexPath.row];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
//    [cell.detailTextLabel sizeThatFits:CGSizeMake(200, 18)];
    NSString * detail = [[NSString alloc]initWithFormat:@"%@ \t %@",[arrData3 objectAtIndex:indexPath.row],[arrData3 objectAtIndex:indexPath.row]];
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
    
    UILabel * headLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/9,0,100,20)];
    headLabel1.text = @"แนะนำ";
    
    UILabel * headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*5/9,0,100,20)];
    headLabel2.text = @"สั่งซื้อ";
    
    UILabel * headLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*6/9,0,100,20)];
    headLabel3.text = @"รวม";
    
    UILabel * headLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*7/9,0,100,20)];
    headLabel4.text = @"ส่วนลด";
    
    UILabel * headLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*8/9,0,100,20)];
    headLabel5.text = @"ยอดรวม";
    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    myView.backgroundColor = [UIColor clearColor];
    
    headLabel0.backgroundColor = [UIColor clearColor];
    headLabel1.backgroundColor = [UIColor clearColor];
    headLabel2.backgroundColor = [UIColor clearColor];
    headLabel3.backgroundColor = [UIColor clearColor];
    headLabel4.backgroundColor = [UIColor clearColor];
    headLabel5.backgroundColor = [UIColor clearColor];
    
    [headLabel0 setTextAlignment:UITextAlignmentCenter];
    [headLabel1 setTextAlignment:UITextAlignmentCenter];
    [headLabel2 setTextAlignment:UITextAlignmentCenter];
    [headLabel3 setTextAlignment:UITextAlignmentCenter];
    [headLabel4 setTextAlignment:UITextAlignmentCenter];
    [headLabel5 setTextAlignment:UITextAlignmentCenter];
    
    [myView addSubview:headLabel0];
    [myView addSubview:headLabel1];
    [myView addSubview:headLabel2];
    [myView addSubview:headLabel3];
    [myView addSubview:headLabel4];
    [myView addSubview:headLabel5];
    
    [headerView addSubview:myView];
    
    return headerView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view.superview addSubview:_productDataDetail.view];
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
    [self changeQuantityTextField:textField AtRow:rowIndex];
//    ProductInAction * product = [muTableDetail objectAtIndex:rowIndex];
//    [product setTo_quantity1:[textField.text intValue]];
}

-(void) changeQuantityTextField:(UITextField *) txtField AtRow:(NSInteger) rowIndex {
    ProductInAction * product = [muTableDetail objectAtIndex:rowIndex];
    [product setTo_Quantity:[[NSDecimalNumber alloc]initWithString:txtField.text]]; 
    //[txtField.text intValue]];
    
    

}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}

/////////////////////////////////////////////////////////////////////



-(void) setTakeOrderPageWithPlan:(NSString *)planID Account:(NSString *)accountID
{
    [muTableMaster removeAllObjects];
    [muTableDetail removeAllObjects];
    [self loadDataProduct];
}

-(void) loadDataProduct
{
    NSString *tableField = [_tblorderMaster DB_Field] ;
    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from OrderMaster Where Plan_ID=%@",tableField ,plan_ID]; 
    muTableMaster = [[NSMutableArray alloc] init];
    muTableMaster = [_tblorderMaster QueryData:searchString];
    NSString * plugSqlSuggest = [NSString stringWithFormat:@" (Select Quantity / count(Quantity)  as G From Plan P Inner join OrderMaster OM On P.Plan_ID = OM.Plan_ID Inner join OrderDetail OD On OM.PK = OD.OrderMaster_PK Where P.Account_ID = 12 AND OD.Product_ID = OrderDetail.Product_ID Group by Quantity) as Suggest "];
    
    if (muTableMaster.count < 1) {
        // LoadDataProduct
        int ii = 0;
        for (ii=0; ii<arrData1.count; ii++) {
            ProductInAction * product = [[ProductInAction alloc]init];
            product.pd_ID = [arrData3 objectAtIndex:ii];
            product.pd_Name = [arrData1 objectAtIndex:ii];
            [muTableDetail addObject:product];
        }
    }else {
        tableField = [_tblorderDetail DB_Field];    
        tblOrderMaster * orderPK = [muTableMaster objectAtIndex:0];
        
        NSString * sql = [NSString stringWithFormat:@"Select %@ , %@ From Orderdetail Where OrderMaster_PK=%@",tableField ,plugSqlSuggest ,orderPK.pK];
        NSLog(@"%@",sql);
        NSMutableArray * tempTable = [_tblorderDetail QueryData2:sql];
        int ii = 0;
        for (ii=0; ii<tempTable.count; ii++) {
            ProductInAction * product = [[ProductInAction alloc]init];
            tblOrderDetail * order =[[tblOrderDetail alloc]init];
            order = [tempTable objectAtIndex:ii];
            product.pd_ID = order.product_ID;
            product.pd_Price = order.price;
            product.to_Suggest = [self calcSuggestOfProductID:order.product_ID];
            [muTableDetail addObject:product];
        }
    }
    [tableData reloadData];
        
}

-(NSDecimalNumber *) calcSuggestOfProductID:(NSString *) product_ID{
    NSString * sql = [NSString stringWithFormat:@"Select * From "];
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

-(void) nextToDelivery
{
    [self SaveTakeOrder];
    Delivery * nextView = [[Delivery alloc]initWithNibName:@"Delivery" bundle:nil];
    nextView.account_ID = account_ID;
    nextView.plan_ID = plan_ID;
    [self.navigationController pushViewController:nextView animated:YES];
}


-(void) SaveTakeOrder
{
    NSString * orderID = [NSString stringWithFormat:@"%@",[self SaveOrderMaster]];
    [self SaveOrderDetailWithPK:orderID];
}


-(NSString *) SaveOrderMaster
{
    NSDate *now = [NSDate date];
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:plan_ID, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From OrderMaster Where Plan_ID = ?"];
    [_tblorderMaster ExecSQL:sql parameterArray:paramArray];
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblorderMaster GetMaxRnNo] intValue] +1];
    paramArray = [NSArray arrayWithObjects:plan_ID,newPK,strDate,strTime,lbOrderTotal.text, nil];
    sql = [NSString stringWithFormat:@"Insert Into OrderMaster (Plan_ID,PK,Order_Date,Order_Time,Order_Total) Values (?,?,?,?,?)"];
    [_tblorderMaster ExecSQL:sql parameterArray:paramArray];
    return newPK;
}

-(void) SaveOrderDetailWithPK:(NSString *)orderMasterPK
{
    NSArray *paramArray ;
    paramArray = [NSArray arrayWithObjects:orderMasterPK, nil];
    
    NSString * sql = [NSString stringWithFormat:@"Delete From OrderDetail Where OrderMaster_PK = ?"];
    [_tblorderDetail ExecSQL:sql parameterArray:paramArray];
    
    NSString * newPK = [NSString stringWithFormat:@"%i",[[_tblorderDetail GetMaxRnNo] intValue]] ;//] +1];
    
    NSInteger ii = 0 ;
    for (ii=0; ii<muTableDetail.count; ii++) {
        newPK = [NSString stringWithFormat:@"%i",[newPK intValue]+1];
        ProductInAction * product = [muTableDetail objectAtIndex:ii];
        
        paramArray = [NSArray arrayWithObjects:newPK,product.to_Total,product.to_TotalDiscount,product.to_Discount,product.to_DiscountRate,product.pd_ID,product.to_TotalPrice,product.to_Price,product.to_Quantity,product,orderMasterPK, nil];
        sql = [NSString stringWithFormat:@"Insert Into OrderDetail (PK ,Total ,TotalDiscount ,Discount ,DiscountRate ,Product_ID ,Price ,TotalPrice , Quantity ,OrderMaster_PK ) Values (?,?,?,?,?)"];
        [_tblorderMaster ExecSQL:sql parameterArray:paramArray];
    }
}


@end
