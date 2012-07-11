//
//  DeliverySummary.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/25/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "DeliverySummary.h"

@interface DeliverySummary ()

@end

@implementation DeliverySummary
@synthesize arrData0,arrData1,arrData2;
@synthesize invoiceDetail = _invoiceDetail;
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
    arrData0 = [[NSArray alloc]initWithObjects:@"S065DN2804",@"S065DN2805",@"S065DN2806",@"S065DN2807", nil ];
    
    arrData1 = [[NSArray alloc]initWithObjects:@"25 มิ.ย. 12",@"26 มิ.ย. 12",@"27 มิ.ย. 12",@"28 มิ.ย. 12", nil ];
    
    arrData2 = [[NSArray alloc]initWithObjects:@"3423.00",@"5500.50",@"4200.50",@"1180.00", nil ];
    
//    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrData1.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tableWidth = (tableView.frame.size.width);
    static NSString * iden = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(20,0,200,20)];
        label1.text = [arrData0 objectAtIndex:indexPath.row];
        [label1 setTextAlignment:UITextAlignmentLeft];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/5,0,100,20)];
        label2.text = [arrData1 objectAtIndex:indexPath.row];
        [label2 setTextAlignment:UITextAlignmentCenter];
        
        UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/5,0,100,20)];
        label3.text = [arrData2 objectAtIndex:indexPath.row];
        [label3 setTextAlignment:UITextAlignmentRight];
        
        UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(tableWidth,0,tableWidth,21)];
        myView.backgroundColor = [UIColor clearColor];
        
        [myView addSubview:label1];
        [myView addSubview:label2];
        [myView addSubview:label3];
        
        cell.accessoryView = myView;
    }
    
    cell.textLabel.text = [arrData0 objectAtIndex:indexPath.row];
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    //    [cell.detailTextLabel sizeThatFits:CGSizeMake(200, 18)];
    //NSString * detail = [[NSString alloc]initWithFormat:@"%@ \t %@",[arrData3 objectAtIndex:indexPath.row],[arrData3 objectAtIndex:indexPath.row]];
    //cell.detailTextLabel.text = detail;
    //cell.detailTextLabel.text = [arrData2 objectAtIndex:indexPath.row];
    return  cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSInteger tableWidth = tableView.frame.size.width;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,100,tableWidth,100)];
    headerView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel * headLabel0 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,120,20)];
    headLabel0.text = @"Delivery No";
    
    UILabel * headLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/5,0,100,20)];
    headLabel1.text = @"กำหนดส่ง";
    
    UILabel * headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*4/5,0,100,20)];
    headLabel2.text = @"มูลค่าสินค้า";
//    
//    UILabel * headLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*6/5,0,100,20)];
//    headLabel3.text = @"รวม";
//    
//    UILabel * headLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*7/9,0,100,20)];
//    headLabel4.text = @"ส่วนลด";
//    
//    UILabel * headLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*8/9,0,100,20)];
//    headLabel5.text = @"ยอดรวม";
//    
    UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,100)];
    myView.backgroundColor = [UIColor clearColor];
    
    headLabel0.backgroundColor = [UIColor clearColor];
    headLabel1.backgroundColor = [UIColor clearColor];
    headLabel2.backgroundColor = [UIColor clearColor];
//    headLabel3.backgroundColor = [UIColor clearColor];
//    headLabel4.backgroundColor = [UIColor clearColor];
//    headLabel5.backgroundColor = [UIColor clearColor];
    
    [headLabel0 setTextAlignment:UITextAlignmentCenter];
    [headLabel1 setTextAlignment:UITextAlignmentCenter];
    [headLabel2 setTextAlignment:UITextAlignmentCenter];
//    [headLabel3 setTextAlignment:UITextAlignmentCenter];
//    [headLabel4 setTextAlignment:UITextAlignmentCenter];
//    [headLabel5 setTextAlignment:UITextAlignmentCenter];
    
    [myView addSubview:headLabel0];
    [myView addSubview:headLabel1];
    [myView addSubview:headLabel2];
//    [myView addSubview:headLabel3];
//    [myView addSubview:headLabel4];
//    [myView addSubview:headLabel5];
    
    [headerView addSubview:myView];
    
    return headerView ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self showInvoiceDetail];
}

-(void) showInvoiceDetail{
    [self.view.superview addSubview:_invoiceDetail.view];
}

@end
