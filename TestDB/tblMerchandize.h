//
//  tblMerchandize.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface tblMerchandize : NSObject

@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *account_ID;
@property(nonatomic,strong) NSString *product_Name;
@property(nonatomic,strong) NSString *mcd_Price;
@property(nonatomic,strong) NSString *mCD_Share;
@property(nonatomic,strong) NSString *mCD_Date;
@property(nonatomic,strong) NSString *mCD_Time;

@property(strong , nonatomic) NSMutableArray  *merchandizeList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;

@end
