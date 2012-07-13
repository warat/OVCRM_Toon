//
//  tblReturnDetail.m
//  TestDB
//
//  Created by Admin on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tblReturnDetail.h"
#import "AppDelegate.h"


@implementation tblReturnDetail

@synthesize PK;
@synthesize plan_ID;
@synthesize product_ID;
@synthesize quantity;
@synthesize reason;
@synthesize rtDate;
@synthesize rtTime;

@synthesize returnList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"PK,Plan_ID,Product_ID,Quantity,Reason,RT_Date,RT_Time";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    
    returnList = [[NSMutableArray alloc] init] ;
    
    const char *cQuery = [sqlText UTF8String]; 
    
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    
    NSInteger *count=0;
    
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        
        const char *cPK = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempPK = nil;      
        if (cPK != NULL)
        {
            tempPK = [NSString stringWithUTF8String: cPK]; 
        } 
        
        const char *cPlan_ID = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempPlan_ID = nil;      
        if (cPlan_ID != NULL)
        {
            tempPlan_ID = [NSString stringWithUTF8String: cPlan_ID]; 
        }                     
        
        const char *cProduct_ID = (const char *) sqlite3_column_text(statement, 2);                
        NSString *tempProduct_ID = nil;      
        if (cProduct_ID != NULL)
        {
            tempProduct_ID = [NSString stringWithUTF8String: cProduct_ID]; 
        } 
        
        const char *cQuantity = (const char *) sqlite3_column_text(statement, 3);                
        NSString *tempQuantity = nil;      
        if (cQuantity != NULL)
        {
            tempQuantity = [NSString stringWithUTF8String: cQuantity]; 
        } 
        
        const char *cReason = (const char *) sqlite3_column_text(statement, 4);                
        NSString *tempReason = nil;      
        if (cReason != NULL)
        {
            tempReason = [NSString stringWithUTF8String: cReason]; 
        } 
                
        const char *cRT_Date = (const char *) sqlite3_column_text(statement, 5);                
        NSString *tempRT_Date = nil;      
        if (cRT_Date != NULL)
        {
            tempRT_Date = [NSString stringWithUTF8String: cRT_Date]; 
        } 
        
        const char *cRT_Time = (const char *) sqlite3_column_text(statement, 6);                
        NSString *tempRT_Time = nil;      
        if (cRT_Time != NULL)
        {
            tempRT_Time = [NSString stringWithUTF8String: cRT_Time]; 
        } 
        
        count = count+1;
        
        tblReturnDetail *myReturn = [[tblReturnDetail alloc]init];       
        
        myReturn.PK = tempPK;
        myReturn.plan_ID = tempPlan_ID;
        myReturn.product_ID = tempProduct_ID;             
        myReturn.quantity = tempQuantity;
        myReturn.reason = tempReason;
        myReturn.rtDate = tempRT_Date;
        myReturn.rtTime = tempRT_Time;
        
        [returnList addObject:myReturn];      
        
    }    
    
    sqlite3_reset(statement);
    
    return returnList;
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
        returnList = [[NSMutableArray alloc] init] ;
        
        result = YES;
    }
    
    return result;
}

-(NSString *)GetMaxRnNo
{
    
    NSString * tempMax = nil;  
    NSString * sql = [NSString stringWithFormat:@"Select PK From ReturnDetail Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From ReturnDetail)"];
    
    const char *cQuery = [sql UTF8String]; 
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    NSInteger *count=0;
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        const char *PK = (const char *) sqlite3_column_text(statement, 0);
        if (PK != NULL) 
        {
            tempMax = [NSString stringWithUTF8String: PK]; 
        }  
        count = count+1;
    }
    return tempMax;
}

@end
