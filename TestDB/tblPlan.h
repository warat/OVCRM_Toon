//
//  tblPlan.h
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface tblPlan : NSObject

@property(nonatomic,strong) NSString *sale_ID;
@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *account_ID;
@property(nonatomic,strong) NSString *account_Name; 
@property(nonatomic,strong) NSString *date_Plan;
@property(nonatomic,strong) NSString *timePlan_In;
@property(nonatomic,strong) NSString *timePlan_Out;
@property(nonatomic,strong) NSString *visit_Date;
@property(nonatomic,strong) NSString *visit_TimeIn; 
@property(nonatomic,strong) NSString *visit_TimeOut;
@property(nonatomic,strong) NSString *latitude;
@property(nonatomic,strong) NSString *longtitude;
@property(nonatomic,strong) NSString *lastSyncDate;
@property(nonatomic,strong) NSString *lastSyncTime;

@property(strong , nonatomic) NSMutableArray  *planList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

@end
