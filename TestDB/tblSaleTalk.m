//
//  tblSaleTalk.m
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tblSaleTalk.h"
#import "AppDelegate.h"

@implementation tblSaleTalk

@synthesize  plan_ID;
@synthesize  RunNo;
@synthesize  SaleTalk;
@synthesize  ST_Date;
@synthesize  ST_Time;

@synthesize  saleTalkList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"Plan_ID, RunNo ,SaleTalk , ST_Date , ST_Time ";
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
        
        int pRunNo = sqlite3_column_int(statement, 1);                       
        
        const char *cSaleTalk = (const char *) sqlite3_column_text(statement, 2);                
        NSString *tempSaleTalk = nil;      
        if (cSaleTalk != NULL)
        {
            tempSaleTalk = [NSString stringWithUTF8String: cSaleTalk]; 
        } 
        
        const char *cST_Date = (const char *) sqlite3_column_text(statement, 3);                
        NSString *tempST_Date = nil;      
        if (cST_Date != NULL)
        {
            tempST_Date = [NSString stringWithUTF8String: cST_Date]; 
        }
        
        const char *cST_Time = (const char *) sqlite3_column_text(statement, 4);                
        NSString *tempST_Time = nil;      
        if (cST_Time != NULL)
        {
            tempST_Time = [NSString stringWithUTF8String: cST_Time]; 
        }                       
  
        
        count = count+1;
        
        tblSaleTalk *mySaleTalk = [[tblSaleTalk alloc]init];       
        
        mySaleTalk.plan_ID = tempPlan_ID;
        mySaleTalk.RunNo = pRunNo;
        mySaleTalk.SaleTalk = tempSaleTalk;
        mySaleTalk.ST_Date = tempST_Date;
        mySaleTalk.ST_Time = tempST_Time;               
        
        [saleTalkList addObject:mySaleTalk];       
        
    }    
    
    sqlite3_reset(statement);
    
    return saleTalkList;
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
        saleTalkList = [[NSMutableArray alloc] init] ;
        result = YES;
    }
    
    return result;
}


@end
