//
//  tblReturnDetail.h
//  TestDB
//
//  Created by Admin on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface tblReturnDetail : NSObject

@property(nonatomic,strong) NSString *PK;
@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *product_ID;
@property(nonatomic,strong) NSString *quantity;
@property(nonatomic,strong) NSString *reason;
@property(nonatomic,strong) NSString *rtDate;
@property(nonatomic,strong) NSString *rtTime;

@property(strong , nonatomic) NSMutableArray  *returnList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;

@end
