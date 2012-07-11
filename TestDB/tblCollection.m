//
//  tblCollection.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblCollection.h"
#import "AppDelegate.h"

@implementation tblCollection

@synthesize plan_ID;
@synthesize pK;
@synthesize collect_Date;
@synthesize collect_Time;
@synthesize invoice_No;
@synthesize amount;
@synthesize payType;
@synthesize collectionList = _collectionList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"Plan_ID, PK, Collect_Date, Collect_Time, Invoice_No, Amount, PayType";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _collectionList = [[NSMutableArray alloc]init];
    const char *cQuery = [sqlText UTF8String]; 
    //NSLog(@"%@",sqlText);
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
        const char *cPK = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempPK = nil;      
        if (cPK != NULL)
        {
            tempPK = [NSString stringWithUTF8String: cPK]; 
        }  
        const char *cCollect_Date = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempCollect_Date = nil;      
        if (cCollect_Date != NULL)
        {
            tempCollect_Date = [NSString stringWithUTF8String: cCollect_Date]; 
        }  
        const char *cCollect_Time = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempCollect_Time = nil;      
        if (cCollect_Time != NULL)
        {
            tempCollect_Time = [NSString stringWithUTF8String: cCollect_Time]; 
        }  
        const char *cInvoice_No = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempInvoice_No = nil;      
        if (cInvoice_No != NULL)
        {
            tempInvoice_No = [NSString stringWithUTF8String: cInvoice_No]; 
        }  
        const char *cAmount = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempAmount = nil;      
        if (cAmount != NULL)
        {
            tempAmount = [NSString stringWithUTF8String: cAmount]; 
        }  
        const char *cPayType = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempPayType = nil;      
        if (cPayType != NULL)
        {
            tempPayType = [NSString stringWithUTF8String: cPayType]; 
        }  
        
        count = count+1;
        
        tblCollection *myCollection = [[tblCollection alloc]init];               
        
        myCollection.plan_ID = tempPlan_ID;
        myCollection.PK = tempPK;
        myCollection.collect_Date = tempCollect_Date;
        myCollection.collect_Time = tempCollect_Time;
        myCollection.invoice_No = tempInvoice_No;
        myCollection.amount = tempAmount;
        myCollection.payType = tempPayType;
        
        [_collectionList addObject:myCollection];
    }    
    
    sqlite3_reset(statement);
    
    return _collectionList;
}

-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr
{
    const char *cInsert = [addText UTF8String]; //"insert into Product (Product_ID,Product_Name) values (?,?)";
    NSLog(@"%@",addText);
    sqlite3_stmt *insert_statement = nil;
    
    sqlite3_prepare_v2(database, cInsert, -1, &insert_statement, NULL);
    
    
    for(int i=0;i<[paramArr count];i++)
    {
         NSLog(@"%@",[paramArr objectAtIndex:i]);
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
    NSLog(@"%@",fullPath);
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

-(NSString *)GetMaxRnNo
{
    
    NSString * tempMax = nil;  
    NSString * sql = [NSString stringWithFormat:@"Select PK From Collection Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From Collection)"];
    
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
