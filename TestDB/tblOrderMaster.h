//
//  tblOrderMaster.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/9/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface tblOrderMaster : NSObject

@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *order_Time;
@property(nonatomic,strong) NSString *order_Date;

@property (nonatomic,strong) NSDecimalNumber * order_Total;

@property(strong , nonatomic) NSMutableArray  *orderMasterList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;

@end
