//
//  ProductDataDetail.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "ProductDataDetail.h"
#import "tblProduct.h"
#import "SearchProduct.h"

@interface ProductDataDetail ()

@end

@implementation ProductDataDetail

@synthesize  productID;
@synthesize  productList;
@synthesize  searchMyProduct;

@synthesize  lblProductName;
@synthesize  lblProductCode;
@synthesize  lblProductCategory;
@synthesize  lblBrand;
@synthesize  lblProductFamily;
@synthesize  lblPackSize;
@synthesize  lblPackaging;
@synthesize  lblWeight;
@synthesize  lblWidth;
@synthesize  lblHeight;                  
@synthesize  lblLong;
@synthesize  lblCost;


-(void)ShowProductID:(NSString *)prodID
{
//    [txtShowProdID setText:prodID]; assign to text โดยตรงไม่ได้ ค่าจะหาย
    self.productID = prodID;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    if (productID != nil)
    {
        self.lblProductCode.text = productID;
        [self LoadProductDetail];
    }
}

-(void)LoadProductDetail
{
    tblProduct *myProduct = [[tblProduct alloc] init];

    if ([myProduct OpenConnection] == YES) 
    {
        NSString *tableField = [myProduct DB_Field] ;               
        NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from Product where product_code=%@",tableField,productID]; 
        
        productList=[myProduct QueryData:searchString];               
        
        if(productList.count > 0){
//            for (int i=0;i<=productList.count-1;i++)
//            {
               // myProduct = [productList objectAtIndex:i]  ;
                myProduct = [productList objectAtIndex:0]  ;
                self.lblProductName.text = myProduct.product_Name;
                self.lblProductCategory.text = myProduct.productCategory;
                self.lblBrand.text = myProduct.brand;
                self.lblProductFamily.text = myProduct.product_Family;
                self.lblPackSize.text = myProduct.packSize;
                self.lblPackaging.text = myProduct.packaging;
                self.lblWeight.text = myProduct.weight;
                self.lblWidth.text = myProduct.width;
                self.lblHeight.text = myProduct.height;
                self.lblLong.text = myProduct.productLong;
                self.lblCost.text = [NSString stringWithFormat:@"%d", myProduct.cost];                
//            }
        }
        
    }   
}

-(void)backPage
{    
    if (!self.searchMyProduct) 
    {
        self.searchMyProduct = [[SearchProduct alloc] initWithNibName:@"SearchProduct" bundle:nil];
    }
    [self.searchMyProduct assignBackState:@"Y"];
    [[self navigationController] pushViewController:self.searchMyProduct  animated:YES] ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.    
    self.navigationItem.title = @"รายละเอียดสินค้า";    
    
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backPage)];
//    self.navigationItem.leftBarButtonItem = backButton;
    
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

@end
