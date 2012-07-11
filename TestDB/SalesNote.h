//
//  SalesNote.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


//#import "tblSaleTalk.h"
@class tblSaleTalk;
@class tblPCBrief;

@interface SalesNote : UIViewController
{
    NSString * account_ID;
    NSString * plan_ID;
}

@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString * account_ID;

@property (strong, nonatomic) tblSaleTalk * tblsaleTalk;
@property (strong, nonatomic) tblPCBrief * tblpcBrief;

@property (strong, nonatomic) IBOutlet UITextView *textSalesTalk;
@property (strong, nonatomic) IBOutlet UILabel *lblPCBrief;
@property (strong, nonatomic) IBOutlet UITextView *textPCBrief;
-(void) setSalesTalkPage;
-(void) setPCBriefPage;

-(void) saveDataSaleTalk;
-(void) saveDataPCBrief;

@end
