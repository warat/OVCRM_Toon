//
//  SearchProduct.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SearchProduct.h"
#import "tblProduct.h"
#import "tblParameter.h"
#import "MyTableViewCell.h"
#import "SearchProdTBViewCell.h"
#import "ProductDataDetail.h"
#import "GoodsReturn.h"

@interface SearchProduct ()

@end

@implementation SearchProduct

@synthesize  arrProdCode,arrProdName,arrProdFamily,arrProdCost; 

@synthesize productDataDetail = _productDataDetail;
@synthesize goodsReturn = _goodsReturn;
@synthesize myTableView = _myTableView;
@synthesize headerView,headerViewSelectable;
@synthesize productList;
@synthesize parameterList;
@synthesize arrPickerList;
@synthesize selectedProduct;
@synthesize backState;
@synthesize previousPage;

@synthesize arrSearchFamily,arrSearchBrand;
@synthesize pickerBrand , pickerFamily;
@synthesize activePicker;
@synthesize myPicker;
@synthesize pickersArray;

@synthesize  txtProdCode;
@synthesize  txtProdName;
@synthesize  txtBrand;
@synthesize  txtProdFamily;
@synthesize  lblSearchItem;
@synthesize  txtSelectProductCode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)assignBackState:(NSString *)state
{
    //    [txtShowProdID setText:prodID]; assign to text โดยตรงไม่ได้ ค่าจะหาย
    self.backState = state;
}

- (IBAction)SubmitSelectProduct
{
    
//    GoodsReturn *pageGoodReturn = [[GoodsReturn alloc] init];    
//    pageGoodReturn.addProductCode = self.txtSelectProductCode.text;
    if (!self.goodsReturn) 
    {
        self.goodsReturn = [[GoodsReturn alloc] initWithNibName:@"GoodsReturn" bundle:nil];
    }
    self.goodsReturn.addProductCode =  self.txtSelectProductCode.text;
    [self.goodsReturn AddNewProduct];
    [[self navigationController] pushViewController:self.goodsReturn  animated:YES] ;
}

- (void)viewDidLoad
{        
    self.navigationItem.title = @"ค้นหาสินค้า"; 
    // Release any retained subviews of the main view.
    arrProdCode = [[NSMutableArray alloc] init];
    arrProdName = [[NSMutableArray alloc] init];
    arrProdFamily = [[NSMutableArray alloc] init];
    arrProdCost = [[NSMutableArray alloc] init];
    
    [self.myTableView reloadData]; 
       
    [self LoadMasterData];
    self.myPicker.hidden = YES;
//    if ([self.previousPage isEqualToString:@"GR"])
//    {
//        headerView.hidden = YES;
//    }
//    else
//    {
//        headerViewSelectable.hidden = YES;
//    }

    
    [super viewDidLoad];    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    self.pickerBrand.hidden = YES;
//    self.pickerFamily.hidden = NO;
    //In case redirect from product detail, show search result
//    NSLog(@"Back=***%@",self.backState);
//    if (![self.backState isEqualToString:@"Y"])
//    {
//        arrProdCode = [[NSMutableArray alloc] init];
//        arrProdName = [[NSMutableArray alloc] init];
//        arrProdFamily = [[NSMutableArray alloc] init];
//        arrProdCost = [[NSMutableArray alloc] init];
//        
//        [self.myTableView reloadData];    
//    }    
}

-(IBAction)backgroungTab
{
    [self.txtProdCode resignFirstResponder]; 
    [self.txtProdName resignFirstResponder];
    [self.txtProdFamily resignFirstResponder];
    [self.txtBrand resignFirstResponder];
    self.myPicker.hidden = YES;
}

- (IBAction)btnSearch:(id)sender
{
    [self SearchProduct];
}

#pragma mark -
#pragma mark picker methods

-(void)LoadMasterData
{
    tblParameter *myParameter = [[tblParameter alloc] init];
    
    if ([myParameter OpenConnection] == YES) 
    {
        NSString *tableField = [myParameter DB_Field] ; 
        NSString *cond = [[NSString alloc] initWithFormat:@"select %@ from Parameter where Tag='Brand' or Tag='Family' order by Tag asc,Label asc",tableField];
                        
        arrSearchBrand = [[NSMutableArray alloc] init];
        arrSearchFamily = [[NSMutableArray alloc] init];
               
        parameterList = [myParameter QueryData:cond];               
        
        if(parameterList.count > 0){
            for (int i=0;i<=parameterList.count-1;i++)
            {
                myParameter = [parameterList objectAtIndex:i]  ;
                
                if ([myParameter.tag isEqualToString:@"Brand"]) //Brand
                {
                  [arrSearchBrand addObject: myParameter.label];                       
                }
                else  //Family
                {
                  [arrSearchFamily addObject: myParameter.label];   
                }

            }         
        }

    }   
    
//    pickerBrand = [[UIPickerView alloc] initWithFrame:CGRectMake(0,250,400,160)];
//    pickerBrand.tag = kBRANDPICKERTAG;
//    pickerBrand.showsSelectionIndicator = TRUE;
//    pickerBrand.dataSource = self;
//    pickerBrand.delegate = self;
//    pickerBrand.hidden = YES;
//
//    pickerFamily = [[UIPickerView alloc] initWithFrame:CGRectMake(0,250,400,160)];
//    pickerFamily.backgroundColor = [UIColor blueColor];
//    pickerFamily.tag = kFAMILYPICKERTAG;
//    pickerFamily.showsSelectionIndicator = TRUE;
//    pickerFamily.hidden = YES;
//    pickerFamily.dataSource = self;
//    pickerFamily.delegate = self;
//    
//    pickersArray =  [[NSArray alloc] initWithObjects: pickerBrand, pickerFamily ,nil];//add your both pickers to this array and we will use button tags to get picker from this array and alternate between two pickers
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)eve
//{
//    
//}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
   return kPICKERCOLUMN;    
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arrPickerList  count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     return [arrPickerList objectAtIndex:row];

}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *selectItem  = [arrPickerList objectAtIndex:[pickerView selectedRowInComponent:0]];
    
    if ([self.lblSearchItem.text isEqualToString:@"B"]) //Brand
    {      
        [txtBrand setText:selectItem];          
    }
    else //Family
    {               
       [txtProdFamily setText:selectItem];          
    }   
    self.myPicker.hidden = YES;
}

-(void) ShowFamilyPicker
{
    self.lblSearchItem.text = @"F";
    self.myPicker.hidden = NO;    
    self.arrPickerList = self.arrSearchFamily;    
    [self.myPicker reloadAllComponents]; 
}

-(void) ShowBrandPicker
{  
    self.lblSearchItem.text = @"B";
    self.myPicker.hidden = NO;    
    self.arrPickerList = self.arrSearchBrand;    
    [self.myPicker reloadAllComponents];
//    UIButton * control = (UIButton*) sender;
//    //UITextField * control = (UITextField*) sender;
//    if (self.activePicker) {
//        
//        [self.activePicker removeFromSuperview];
//        
//    }
//    NSLog(@"Segment index:%d",control.tag);
//    self.activePicker = [pickersArray objectAtIndex:control.tag];
//    
//    [self.view  addSubview:self.activePicker];
    
}

-(NSInteger) getRowIndex:(UIView *)view
{
    UITableViewCell * cellOfText = (UITableViewCell *)view.superview.superview;
    UITableView * tbv =  (UITableView *)cellOfText.superview;
    NSInteger rowIndex = [[tbv indexPathForCell:cellOfText] row];
    return rowIndex;
}

-(void) touchSwitch:(UISwitch *)switchItem
{
    NSInteger rowIndex = [self getRowIndex:switchItem];    
    NSString *sProdCode =  [arrProdCode objectAtIndex:rowIndex];
    NSString *sAllSelectItem= self.txtSelectProductCode.text;//[NSString alloc];
    NSString *sCheckString = [[NSString alloc] initWithFormat:@"/%@/",sProdCode];

    if ([switchItem isOn]) 
    {    
        //Select product code is in format /c001//c002/
        sAllSelectItem  = [NSString stringWithFormat:@"%@%@",sAllSelectItem,sCheckString];  
    }
    
    else 
    {
     sAllSelectItem = [sAllSelectItem stringByReplacingOccurrencesOfString:sCheckString withString:@""]; 
    }
    self.txtSelectProductCode.text = sAllSelectItem;
}

#pragma mark -
#pragma mark tableview methods

-(void)SearchProduct
{
    tblProduct *myProduct = [[tblProduct alloc] init];
    
    if ([myProduct OpenConnection] == YES) 
    {
        NSString *tableField = [myProduct DB_Field] ; 
        NSString *cond = [[NSString alloc] initWithFormat:@"select %@ from Product where 1=1",tableField];
             
        //Search from Product Code
        if (![self.txtProdCode.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Product_Code=%@",cond , self.txtProdCode.text];
        }
        
        //Search from Product Name
        if (![self.txtProdName.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Product_Name like '%@%%'",cond , self.txtProdName.text];   
        }
        
        //Search from Brand
        if (![self.txtBrand.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Brand like '%@%%'",cond , self.txtBrand.text];   
        }
        
        //Search from Product Family
        if (![self.txtProdFamily.text isEqualToString:@""])
        {
            cond = [NSString stringWithFormat:@"%@ and Product_Family like '%@%%'",cond , self.txtProdFamily.text];   
        }
            
//        NSLog(@"***%@" , cond);
        
        arrProdCode = [[NSMutableArray alloc] init];
        arrProdName = [[NSMutableArray alloc] init];
        arrProdFamily = [[NSMutableArray alloc] init];
        arrProdCost = [[NSMutableArray alloc] init];
        
        productList=[myProduct QueryData:cond];               
        
        if(productList.count > 0){
           for (int i=0;i<=productList.count-1;i++)
           {
            myProduct = [productList objectAtIndex:i]  ;
               
            [arrProdCode addObject:myProduct.product_Code];   
            [arrProdName addObject:myProduct.product_Name];
            [arrProdFamily addObject:myProduct.product_Family];
            [arrProdCost addObject:[NSString stringWithFormat:@"%d", myProduct.cost]];                                   
           }         
        }
         [_myTableView reloadData];
    }   
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}



-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrProdCode.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
//    NSLog(@"***%@",self.previousPage);
    
    if ([self.previousPage isEqualToString:@"GR"]) //Goods Return
    {
         SearchProdTBViewCell *cell = (SearchProdTBViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SearchProdTBViewCell" owner:nil options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        cell.lblProdCode.text = [arrProdCode objectAtIndex:indexPath.row];
        cell.lblProdName.text = [arrProdName objectAtIndex:indexPath.row];
        cell.lblProdCost.text = [arrProdCost objectAtIndex:indexPath.row];      
        
        UISwitch * switchControl = cell.swSelectProduct; //[[UISwitch alloc]initWithFrame:CGRectMake(15,0,50,10)];
        [switchControl addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
    }
    else
    {
         MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MyTableViewCell" owner:nil options:nil];
            cell = [topLevelObjects objectAtIndex:0];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        
        cell.lblProdCode.text = [arrProdCode objectAtIndex:indexPath.row];
        cell.lblProdName.text = [arrProdName objectAtIndex:indexPath.row];
        cell.lblProdCost.text = [arrProdCost objectAtIndex:indexPath.row];
        
        return cell;
    }                      
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.previousPage isEqualToString:@"GR"])
    {
        headerView.hidden = YES;
        return headerViewSelectable;        
    }
    else
    {
        headerViewSelectable.hidden = YES;
        return headerView;
    }
        
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  30;
}


//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    selectedProduct = [[NSString alloc]initWithFormat:@"%@",[arrData1 objectAtIndex:indexPath.row]];
//    [self.view removeFromSuperview];
//}

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

    if (!self.productDataDetail) 
    {
        self.productDataDetail = [[ProductDataDetail alloc] initWithNibName:@"ProductDataDetail" bundle:nil];
    }
    [self.productDataDetail ShowProductID:[arrProdCode objectAtIndex:indexPath.row]];
    [[self navigationController] pushViewController:self.productDataDetail  animated:YES] ;
}


@end
