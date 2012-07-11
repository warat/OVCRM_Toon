//
//  InvoiceDetail.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "InvoiceDetail.h"

@interface InvoiceDetail ()

@end

@implementation InvoiceDetail

@synthesize arrData0,arrData1,arrData2,arrData3;

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
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToInvoiceList)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    arrData0 = [[NSArray alloc]initWithObjects:@"BPโอวัลตินUHTไฮไนน์225ML.P36(M)",@"โอวัลติน300กรัม(ถุง)(M)"
                ,@"โอวัลติน3IN1 210 กรัม",@"โอวัลติน3IN1 700G(M)",@"โอวัลติน800กรัมถุง"
                ,@"โอวัลตินUHTรสชอคไขมันต่ำ180มลP4(M)",@"โอวัลตินคลาสิค 150 กรัมถุง(M)"
                ,@"โอวัลตินชอยส์525กรัมถุง",@"โอวัลตินซอยย์สูตรผสมงาดำ490 กรัมแพ็ค14"
//                ,@"โอวัลตินยูเอชทีสมาร์ท125มล.แพค4รสชอคโกแลต",@"โอวัลตินยูเอชทีไฮไนน์180มล.M"
//                ,@"โอวัลตินยูเอชทีไฮไนน์225มลแพค6(M)",@"โอวัลตินเย็น3IN1ครั้นซ์ชี่630Gถุง"
                ,@"โอวัลตินเย็นครั้นซ์ชี่175กรัม ถุง(M)", nil ];
    
    arrData1 = [[NSArray alloc]initWithObjects:@"2",@"6",@"5",@"9",@"3",@"0",@"3",@"2",@"1",@"3",@"2",@"9",@"9",@"9", nil ];
    
    arrData2 = [[NSArray alloc]initWithObjects:@"423.00",@"55.50",@"42.50",@"118.00",@"118.00",@"43.50",@"30.00",@"98.00",@"98.00",@"32.00",@"43.50",@"71.50",@"114.00",@"38.50", nil ];
    
    arrData3 = [[NSArray alloc]initWithObjects:@"100434182",@"100498051",@"100425481",@"100425108",@"100493479",@"100457578",@"100426619",@"100438515",@"100517093",@"100591916",@"100544444",@"100573942",@"100546553",@"100540341",@"100670740",@"100673714",@"100630613",@"100613035",@"100620515",@"100659488",@"100636211",@"100674679",@"100678777",@"100691215",@"100647033",@"100660592",@"100628551", nil ];
    
    //[super viewDidLoad];
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
    return arrData0.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger tableWidth = (tableView.frame.size.width)/2+50;
    static NSString * iden = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(tableWidth*3/10, 0, 40, 21)];
        textField.placeholder = @"0";
        textField.text = @"";
        textField.delegate = nil;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.textAlignment = UITextAlignmentRight;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        
        
        UILabel * label0 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*3/10, 0, 40, 21)];
        label0.text = @"1";//[arrData1 objectAtIndex:indexPath.row];
        [label0 setTextAlignment:UITextAlignmentRight];
        
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(0,0,80,20)];
        label1.text = [arrData2 objectAtIndex:indexPath.row];
        [label1 setTextAlignment:UITextAlignmentRight];
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*5/10-20,0,80,20)];
        label2.text = [arrData2 objectAtIndex:indexPath.row];
        [label2 setTextAlignment:UITextAlignmentRight];
        
        UILabel * label3 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*8/10,0,80,20)];
        label3.text = [arrData2 objectAtIndex:indexPath.row];
        [label3 setTextAlignment:UITextAlignmentRight];
        
        UILabel * label4 = [[UILabel alloc] initWithFrame:CGRectMake(tableWidth*7/10-10, 0, 50, 21)];
        label4.text = @"0";//[arrData2 objectAtIndex:indexPath.row];
        [label4 setTextAlignment:UITextAlignmentRight];
        
        UIView * myView = [[UIView alloc]initWithFrame:CGRectMake(tableWidth,0,tableWidth,21)];
        myView.backgroundColor = [UIColor clearColor];
        
        //[myView addSubview:textField];
        //[myView addSubview:textField2];
        [myView addSubview:label0];
        [myView addSubview:label1];
        [myView addSubview:label2];
        [myView addSubview:label3];
        [myView addSubview:label4];
        
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
    headLabel1.text = @"ราคา";
    
    UILabel * headLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(tableWidth*5/9,0,100,20)];
    headLabel2.text = @"จำนวน";
    
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
}


- (IBAction)buttonBack:(id)sender {
    [self.view removeFromSuperview];
}
@end
