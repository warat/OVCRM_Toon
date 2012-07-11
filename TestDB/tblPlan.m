//
//  tblPlan.m
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tblPlan.h"
#import "AppDelegate.h"

@implementation tblPlan

@synthesize  sale_ID;
@synthesize  plan_ID;
@synthesize  account_ID;
@synthesize  account_Name; 
@synthesize  date_Plan;
@synthesize  timePlan_In;
@synthesize  timePlan_Out;
@synthesize  visit_Date;
@synthesize  visit_TimeIn; 
@synthesize  visit_TimeOut;
@synthesize  latitude;
@synthesize  longtitude;
@synthesize  lastSyncDate;
@synthesize  lastSyncTime;

@synthesize  planList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"Plan_ID ,Account_ID ,Account_Name ,Date_Plan ,TimePlan_In ,TimePlan_Out ,Visit_Date ,Visit_TimeIn ,Visit_TimeOut ,Latitude ,Longtitude , LastSyncDate , LastSyncTime";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    const char *cQuery = [sqlText UTF8String]; 
    
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    
    NSInteger *count=0;
    
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        
        const char *cPlan_ID = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempPlan_ID = nil;      
        if (cPlan_ID != NULL)
        {
            tempPlan_ID = [NSString stringWithUTF8String: cPlan_ID]; 
        }         
        
        const char *cAccount_ID = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempAccount_ID = nil;      
        if (cAccount_ID != NULL)
        {
            tempAccount_ID = [NSString stringWithUTF8String: cAccount_ID]; 
        }         
        
        const char *cAccount_Name = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempAccount_Name = nil;      
        if (cAccount_Name != NULL)
        {
            tempAccount_Name = [NSString stringWithUTF8String: cAccount_Name]; 
        } 
       
        const char *cDate_Plan = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempDate_Plan = nil;      
        if (cDate_Plan != NULL)
        {
            tempDate_Plan = [NSString stringWithUTF8String: cDate_Plan]; 
        } 

        const char *cTimePlan_In = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempTimePlan_In = nil;      
        if (cTimePlan_In != NULL)
        {
            tempTimePlan_In = [NSString stringWithUTF8String: cTimePlan_In]; 
        } 
        
        const char *cTimePlan_Out = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempTimePlan_Out = nil;      
        if (cTimePlan_Out != NULL)
        {
            tempTimePlan_Out = [NSString stringWithUTF8String: cTimePlan_Out]; 
        }     
    
        const char *cVisit_Date = (const char *) sqlite3_column_text(statement, 6);
        NSString *tempVisit_Date = nil;      
        if (cVisit_Date != NULL)
        {
            tempVisit_Date = [NSString stringWithUTF8String: cVisit_Date]; 
        }   
        
        const char *cVisit_TimeIn = (const char *) sqlite3_column_text(statement, 7);
        NSString *tempVisit_TimeIn = nil;      
        if (cVisit_TimeIn != NULL)
        {
            tempVisit_TimeIn = [NSString stringWithUTF8String: cVisit_TimeIn]; 
        }   
        
        const char *cVisit_TimeOut = (const char *) sqlite3_column_text(statement, 8);
        NSString *tempVisit_TimeOut = nil;      
        if (cVisit_TimeOut != NULL)
        {
            tempVisit_TimeOut = [NSString stringWithUTF8String: cVisit_TimeOut]; 
        }   
        
        const char *cLatitude = (const char *) sqlite3_column_text(statement, 9);
        NSString *tempLatitude = nil;      
        if (cLatitude != NULL)
        {
            tempLatitude = [NSString stringWithUTF8String: cLatitude]; 
        } 
        
        const char *cLongtitude = (const char *) sqlite3_column_text(statement, 10);
        NSString *tempLongtitude = nil;      
        if (cLongtitude != NULL)
        {
            tempLongtitude = [NSString stringWithUTF8String: cLongtitude]; 
        } 
       
        const char *cLastSyncDate = (const char *) sqlite3_column_text(statement, 11);
        NSString *tempLastSyncDate = nil;      
        if (cLastSyncDate != NULL)
        {
            tempLastSyncDate = [NSString stringWithUTF8String: cLastSyncDate]; 
        } 
        
        const char *cLastSyncTime = (const char *) sqlite3_column_text(statement, 12);
        NSString *tempLastSyncTime = nil;      
        if (cLastSyncTime != NULL)
        {
            tempLastSyncTime  = [NSString stringWithUTF8String: cLastSyncTime]; 
        } 
                           
        
        count = count+1;
        
        tblPlan *myPlan = [[tblPlan alloc]init];               
        
        myPlan.plan_ID = tempPlan_ID;
        myPlan.account_ID = tempAccount_ID;
        myPlan.account_Name = tempAccount_Name;
        myPlan.date_Plan = tempDate_Plan;
        myPlan.timePlan_In = tempTimePlan_In;               
        myPlan.timePlan_Out = tempTimePlan_Out;
        myPlan.visit_Date = tempVisit_Date;
        myPlan.visit_TimeIn = tempVisit_TimeIn;
        myPlan.visit_TimeOut = tempVisit_TimeOut;
        myPlan.latitude = tempLatitude;
        myPlan.longtitude = tempLongtitude;
        myPlan.lastSyncDate = tempLastSyncDate;
        myPlan.lastSyncTime = tempLastSyncTime;
        
        [planList addObject:myPlan];       
        
    }    
    
    sqlite3_reset(statement);
    
    return planList;
}

-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr
{
    const char *cInsert = [addText UTF8String]; //"insert into Product (Product_ID,Product_Name) values (?,?)";
    
    sqlite3_stmt *insert_statement = nil;
    
    sqlite3_prepare_v2(database, cInsert, -1, &insert_statement, NULL);
    
    
    for(int i=0;i<[paramArr count];i++)
    {
        // NSLog(@"param value=%@",[paramArr objectAtIndex:i]);
        sqlite3_bind_text(insert_statement, i+1, 
                          [[paramArr objectAtIndex:i] UTF8String],-1,SQLITE_TRANSIENT);
    }                              
    
    sqlite3_step(insert_statement);
    sqlite3_finalize(insert_statement);
    
    return YES;
}

-(bool)OpenConnection
{
    bool result = NO;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *fullPath = [path stringByAppendingPathComponent: DATABASE_NAME];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exists = [fm fileExistsAtPath:fullPath];
    if (exists)
    {
        NSLog(@"%@ exist -- just opening",fullPath);
    }
    else {
        NSLog(@"%@ does not exist -- copying and opening",fullPath);       
        
        NSString *pathForStartingDB = [[NSBundle mainBundle]pathForResource:DATABASE_TITLE ofType:@"db"];
        
        //        NSLog(@"**** %@ ******",pathForStartingDB);
        
        BOOL success = [fm copyItemAtPath:pathForStartingDB toPath:fullPath error:NULL];
        if (!success)
        {
            NSLog(@"Database copy failed");
        }
    }
    
    const char *cFullPath = [fullPath cStringUsingEncoding:NSUTF8StringEncoding];
    
    if  (sqlite3_open(cFullPath, &database) != SQLITE_OK)
    {
        // NSLog(@"Unable to open database");
    }
    else {
        result = YES;
    }
    
    return result;
}

@end
