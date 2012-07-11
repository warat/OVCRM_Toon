//
//  tblInvoice.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface tblInvoice : NSObject

@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *account_ID;
@property(nonatomic,strong) NSString *invoice_No;
@property(nonatomic,strong) NSString *inv_DueDate;
@property(nonatomic,strong) NSString *inv_Total;
@property(nonatomic,strong) NSString *paid;

@property(strong , nonatomic) NSMutableArray  *invoiceList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;

@end
