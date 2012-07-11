//
//  tblCollection.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"

@interface tblCollection : NSObject

@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *collect_Date;
@property(nonatomic,strong) NSString *collect_Time;
@property(nonatomic,strong) NSString *invoice_No;
@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *payType;


@property(strong , nonatomic) NSMutableArray  *collectionList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;

@end
