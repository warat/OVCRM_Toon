//
//  ViewController.m
//  TestDB
//
//  Created by Warat Agatwipat on 6/28/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#import "CheckInPage.h"
#import "CallCard.h"
#import "Merchandise.h"
#import "SalesNote.h"
#import "GoodsReturn.h"
#import "InvoiceList.h"
#import "Collection.h"
#import "TakeOrder.h"
#import "Delivery.h"
#import "DeliverySummary.h"
#import "tblSaleTalk.h"
#import "SearchProduct.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize plan_ID;
@synthesize account_ID;
@synthesize  tblsaleTalk;
@synthesize stepCount;
@synthesize btnBack = _btnBack;
@synthesize btnNext = _btnNext;

@synthesize checkInPage = _checkInPage;
@synthesize callCard = _callCard;
@synthesize merchaindise = _merchaindise;
@synthesize salesNote = _salesNote;
@synthesize goodsReturn = _goodsReturn;
@synthesize invoiceList = _invoiceList;
@synthesize collection = _collection;
@synthesize takeOrder = _takeOrder;
@synthesize delivery = _delivery;
@synthesize deliverySummary = _deliverySummary;
@synthesize searchProduct = _searchProduct;


- (void)viewDidLoad
{
    [self.view insertSubview:_checkInPage.view atIndex:0];
    plan_ID = [[NSString alloc]initWithFormat:@"13"];
    account_ID = [[NSString alloc]initWithFormat:@"12"];
    [self setTitle:@"Ovaltine"];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToGoodReturn)];
    [self.navigationItem setRightBarButtonItem:barButton animated:YES];
//    plan_ID = [[NSString alloc]initWithFormat:@"%@",plan_ID];
//    account_ID = [[NSString alloc]initWithFormat:@"%@",account_ID];

    tblsaleTalk = [[tblSaleTalk alloc]init];
    //[self NextstepView];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) removeAllSubView
{
    if ([_checkInPage.view superview]) {
        [_checkInPage.view removeFromSuperview];
    }
    if ([_callCard.view superview]) {
        [_callCard.view removeFromSuperview];
    }
    if ([_merchaindise.view superview]) {
        [_merchaindise.view removeFromSuperview];
    }
    if ([_salesNote.view superview]) {
        [_salesNote.view removeFromSuperview];
    }
    if ([_goodsReturn.view superview]) {
        [_goodsReturn.view removeFromSuperview];
    }
    if ([_invoiceList.view superview]) {
        [_invoiceList.view removeFromSuperview];
    }
    if ([_collection.view superview]) {
        [_collection.view removeFromSuperview];
    }
    if ([_takeOrder.view superview]) {
        [_takeOrder.view removeFromSuperview];
    }
    if ([_delivery.view superview]) {
        [_delivery.view removeFromSuperview];
    }
    if ([_deliverySummary.view superview]) {
        [_deliverySummary.view removeFromSuperview];
    }
}

- (IBAction)btnBackClick:(id)sender
{
    [self PrevStepView];
    stepCount -= 1;
    [self NextstepView];
    
}
- (IBAction)btnNextClick:(id)sender
{
    [self PrevStepView];
    stepCount += 1;
    [self NextstepView];
}

-(void) NextstepView
{
    [self removeAllSubView];
    switch (stepCount) {
        case 0:
            [self.view insertSubview:_checkInPage.view atIndex:0];
            break;
        case 1:
            [self.view insertSubview:_callCard.view atIndex:0];
            [_callCard setCallCardPageWithPlan:plan_ID Account:account_ID];
            break;
        case 2:
            [self.view insertSubview:_merchaindise.view atIndex:0];
            break;
        case 3:
            [self.view insertSubview:_salesNote.view atIndex:0];
            [_salesNote setSalesTalkPage];
            break;
        case 4:
            [self.view insertSubview:_goodsReturn.view atIndex:0];
            break;
        case 5:
            [self.view insertSubview:_invoiceList.view atIndex:0];
            break;
        case 6:
            [self.view insertSubview:_collection.view atIndex:0];
            break;
        case 7:
            [self.view insertSubview:_takeOrder.view atIndex:0];
            break;
        case 8:
            [self.view insertSubview:_delivery.view atIndex:0];
            break;
        case 9:
            [self.view insertSubview:_deliverySummary.view atIndex:0];
            break;
        case 10:
            [self.view insertSubview:_salesNote.view atIndex:0];
            [_salesNote setPCBriefPage];
            break;
        default:
            stepCount = 0;
            break;
    }
}

-(void) PrevStepView 
{
    switch (stepCount) {
        case 0:
//            [self.view insertSubview:_checkInPage.view atIndex:0];
            break;
        case 1:
//            [self.view insertSubview:_callCard.view atIndex:0];
            [_callCard saveCallCardPage];
            break;
        case 2:
//            [self.view insertSubview:_merchaindise.view atIndex:0];
            //[_merchaindise saveMerchandisePage];
            break;
        case 3:
            [_salesNote saveDataSaleTalk];
            break;
        case 4:
//            [self.view insertSubview:_goodsReturn.view atIndex:0];
            break;
        case 5:
//            [self.view insertSubview:_invoiceList.view atIndex:0];
            break;
        case 6:
//            [self.view insertSubview:_collection.view atIndex:0];
            break;
        case 7:
//            [self.view insertSubview:_takeOrder.view atIndex:0];
            break;
        case 8:
//            [self.view insertSubview:_delivery.view atIndex:0];
            break;
        case 9:
//            [self.view insertSubview:_deliverySummary.view atIndex:0];
            break;
        case 10:
            [_salesNote saveDataSaleTalk];
            break;
        default:
//            stepCount = 0;
            break;
    }
}

-(void) nextToCallCard
{
    CallCard * nextView = [[CallCard alloc]initWithNibName:@"CallCard" bundle:nil];
    [nextView setPlan_ID:plan_ID];
    [nextView setAccount_ID:self.account_ID];
    [self.navigationController pushViewController:nextView animated:YES];
}

-(void) nextToSearchProduct
{
    SearchProduct * nextView = [[SearchProduct alloc]initWithNibName:@"SearchProduct" bundle:nil];
//    [nextView setPlan_ID:plan_ID];
//    [nextView setAccount_ID:self.account_ID];
    [self.navigationController pushViewController:nextView animated:YES];
}

-(void) nextToGoodReturn
{
    GoodsReturn * nextView = [[GoodsReturn alloc]initWithNibName:@"GoodsReturn" bundle:nil];
    //    [nextView setPlan_ID:plan_ID];
    //    [nextView setAccount_ID:self.account_ID];
    [self.navigationController pushViewController:nextView animated:YES];
}



@end
