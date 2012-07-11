//
//  ActivityMain.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "ActivityMain.h"

@interface ActivityMain ()
//-(void) setArrayCurrent;
-(void) setCameraButton;
-(void) setPageActivity;
@end

@implementation ActivityMain
@synthesize btnCamera = _btnCamera;
@synthesize btnBack;
@synthesize btnNext;
@synthesize currentArray;
@synthesize callCard = _callCard;
@synthesize merchaindise = _merchaindise;
@synthesize salesNote = _salesNote;
@synthesize goodsReturn = _goodsReturn;
@synthesize invoiceList = _invoiceList;
@synthesize collection = _collection;
@synthesize takeOrder = _takeOrder;
@synthesize delivery = _delivery;
@synthesize deliverySummary = _deliverySummary;
@synthesize takePhoto = _takePhoto;

@synthesize stepActivity;

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
    [self setCameraButton];
    stepActivity = 0;
    [self setPageActivity];
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setBtnCamera:nil];
    //[self setBtnBack:nil];
    //[self setBtnNext:nil];
    //[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)btnBackClick:(id)sender {
    if (stepActivity==0){
        [self.view removeFromSuperview];
    }else {
        stepActivity -= 1;
        [self setPageActivity];
    }
}

- (IBAction)btnNextClick:(id)sender {
    stepActivity += 1;
    [self setPageActivity];
}

- (void) removeAllSubView
{
    if ([_callCard.view superview]){
        [_callCard.view removeFromSuperview];
    }
    if ([_merchaindise.view superview]){
        [_merchaindise.view removeFromSuperview];
    }
    if ([_salesNote.view superview]){
        [_salesNote.view removeFromSuperview];
    }
    if ([_goodsReturn.view superview]){
        [_goodsReturn.view removeFromSuperview];
    }
    if ([_invoiceList.view superview]){
        [_invoiceList.view removeFromSuperview];
    }
    if ([_collection.view superview]){
        [_collection.view removeFromSuperview];
    }
    if ([_takeOrder.view superview]){
        [_takeOrder.view removeFromSuperview];
    }
    if ([_delivery.view superview]){
        [_delivery.view removeFromSuperview];
    }
    if ([_deliverySummary.view superview]){
        [_deliverySummary.view removeFromSuperview];
    }
    
    
    if ([_callCard.searchProduct.view superview]){
        [_callCard.searchProduct.view removeFromSuperview];
    }
    if ([_merchaindise.searchProduct.view superview]){
        [_merchaindise.searchProduct.view removeFromSuperview];
    }
    if ([_takeOrder.searchProduct.view subviews]){
        [_takeOrder.searchProduct.view removeFromSuperview];
    }
    if ([_takePhoto.view superview]){
        [_takePhoto.view removeFromSuperview];
    }
}


- (void) showCallCard
{
    [self removeAllSubView];
    [self.view insertSubview:_callCard.view atIndex:0];
}
- (void) showMerchaindise
{
    [self removeAllSubView];
    [self.view insertSubview:_merchaindise.view atIndex:0];
}
- (void) showSalesTalk
{
    [self removeAllSubView];
    [self.view insertSubview:_salesNote.view atIndex:0];
    [_salesNote setSalesTalkPage];
}
- (void) showGoodsReturn
{
    [self removeAllSubView];
    [self.view insertSubview:_goodsReturn.view atIndex:0];
}
- (void) showInvoiceList
{
    [self removeAllSubView];
    [self.view insertSubview:_invoiceList.view atIndex:0];
}
- (void) showCollection
{
    [self removeAllSubView];
    [self.view insertSubview:_collection.view atIndex:0];
}
- (void) showTakeOrder
{
    [self removeAllSubView];
    [self.view insertSubview:_takeOrder.view atIndex:0];
}
- (void) showDelivery
{
    [self removeAllSubView];
    [self.view insertSubview:_delivery.view atIndex:0];
}
- (void) showDeliverySummary
{
    [self removeAllSubView];
    [self.view insertSubview:_deliverySummary.view atIndex:0];
}
- (void) showPCBrief
{
    [self removeAllSubView];
    [self.view insertSubview:_salesNote.view atIndex:0];
    [_salesNote setPCBriefPage];
}

-(void) setPageActivity
{
    
    if (stepActivity==0){
        [btnBack setTitle:@"ข้อมูลร้านค้า" forState:UIControlStateNormal];
        [btnNext setTitle:@"สำรวจชั้นวาง" forState:UIControlStateNormal];
        [self showCallCard];
    }else if (stepActivity==1) {
        [btnBack setTitle:@"ตรวจนับสินค้า" forState:UIControlStateNormal];
        [btnNext setTitle:@"Sales Talk" forState:UIControlStateNormal];
        [self showMerchaindise];
    }else if (stepActivity==2) {
        [btnBack setTitle:@"สำรวจชั้นวาง" forState:UIControlStateNormal];
        [btnNext setTitle:@"คืนสินค้า" forState:UIControlStateNormal];
        [self showSalesTalk];
    }else if (stepActivity==3) {
        [btnBack setTitle:@"Sales Talk" forState:UIControlStateNormal];
        [btnNext setTitle:@"รายการค้างชำระ" forState:UIControlStateNormal];
        [self showGoodsReturn];
    }else if (stepActivity==4) {
        [btnBack setTitle:@"คืนสินค้า" forState:UIControlStateNormal];
        [btnNext setTitle:@"ชำระค่าสินค้า" forState:UIControlStateNormal];
        [self showInvoiceList];
    }else if (stepActivity==5) {
        [btnBack setTitle:@"รายการค้างชำระ" forState:UIControlStateNormal];
        [btnNext setTitle:@"สั่งสินค้า" forState:UIControlStateNormal];
        [self showCollection];
    }else if (stepActivity==6) {
        [btnBack setTitle:@"ชำระค่าสินค้า" forState:UIControlStateNormal];
        [btnNext setTitle:@"กำหนดวันจัดส่ง" forState:UIControlStateNormal];
        [self showTakeOrder];
    }else if (stepActivity==7) {
        [btnBack setTitle:@"สั่งสินค้า" forState:UIControlStateNormal];
        [btnNext setTitle:@"สรุปวันจัดส่ง" forState:UIControlStateNormal];
        [self showDelivery];
    }else if (stepActivity==8) {
        [btnBack setTitle:@"กำหนดวันจัดส่ง" forState:UIControlStateNormal];
        [btnNext setTitle:@"PC Brief" forState:UIControlStateNormal];
        [self showDeliverySummary];
    }else if (stepActivity==9) {
        [btnBack setTitle:@"สรุปวันจัดส่ง" forState:UIControlStateNormal];
        [btnNext setTitle:@"เสร็จสิ้น" forState:UIControlStateNormal];
        [self showPCBrief];
    }else if (stepActivity==10) {
        stepActivity = 0;
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Message" 
                                                        message:@"ทำรายการเสร็จสิ้น" 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles: nil];
        [alert show];
        [self.view removeFromSuperview];
        
    }
}

-(IBAction)startSomething:(id)sender {
    [sender setTitle:@"Hello" forState:UIControlStateNormal];
}

-(void) setCameraButton
{
    [_btnCamera setTitle:@"" forState:UIControlStateNormal];
    NSString *imName = [[NSString alloc] initWithFormat:@"Camera-Icon.jpg"];  
    [_btnCamera setImage:[UIImage imageNamed:imName] forState:UIControlStateNormal];
}
- (IBAction)startCamera:(id)sender {
    [self.view addSubview:_takePhoto.view];
}

@end
