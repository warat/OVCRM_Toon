//
//  tblPCBrief.h
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface tblPCBrief : NSObject

@property (nonatomic,strong) NSString *plan_ID;
@property (nonatomic,assign) NSInteger RunNo;
@property (nonatomic,strong) NSString *SaleTalk;
@property (nonatomic,strong) NSString *PCB_Date;
@property (nonatomic,strong) NSString *PCB_Time;

@property(strong , nonatomic) NSMutableArray  *pcBriefList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

@end
