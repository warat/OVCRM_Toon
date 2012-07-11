//
//  tblMerchandize.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblMerchandize.h"
#import "AppDelegate.h"

@implementation tblMerchandize

@synthesize plan_ID;
@synthesize pK;
@synthesize account_ID;
@synthesize product_Name;
@synthesize mcd_Price;
@synthesize mCD_Share;
@synthesize mCD_Date;
@synthesize mCD_Time;
@synthesize merchandizeList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"Plan_ID, PK, Account_ID, Product_Name, MCD_Price, MCD_Share, MCD_Date, MCD_Time ";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    merchandizeList = [[NSMutableArray alloc]init];
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
        const char *cPK = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempPK = nil;      
        if (cPK != NULL)
        {
            tempPK = [NSString stringWithUTF8String: cPK]; 
        }  
        const char *cAccount_ID = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempAccount_ID = nil;      
        if (cAccount_ID != NULL)
        {
            tempAccount_ID = [NSString stringWithUTF8String: cAccount_ID]; 
        }  
        const char *cProduct_Name = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempProduct_Name = nil;      
        if (cProduct_Name != NULL)
        {
            tempProduct_Name = [NSString stringWithUTF8String: cProduct_Name]; 
        }  
        const char *cMCD_Price = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempMCD_Price = nil;      
        if (cMCD_Price != NULL)
        {
            tempMCD_Price = [NSString stringWithUTF8String: cMCD_Price]; 
        }  
        const char *cMCD_Share = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempMCD_Share = nil;      
        if (cMCD_Share != NULL)
        {
            tempMCD_Share = [NSString stringWithUTF8String: cMCD_Share]; 
        }  
        const char *cMCD_Date = (const char *) sqlite3_column_text(statement, 6);
        NSString *tempMCD_Date = nil;      
        if (cMCD_Date != NULL)
        {
            tempMCD_Date = [NSString stringWithUTF8String: cMCD_Date]; 
        }  
        const char *cMCD_Time = (const char *) sqlite3_column_text(statement, 7);
        NSString *tempMCD_Time = nil;      
        if (cMCD_Time != NULL)
        {
            tempMCD_Time = [NSString stringWithUTF8String: cMCD_Time]; 
        }         
        
        count = count+1;
        
        tblMerchandize *myMerchandize = [[tblMerchandize alloc]init];               
        
        myMerchandize.plan_ID = tempPlan_ID;
        myMerchandize.PK = tempPK;
        myMerchandize.account_ID = tempAccount_ID;
        myMerchandize.product_Name = tempProduct_Name;
        myMerchandize.mcd_Price = tempMCD_Price;
        myMerchandize.mCD_Share = tempMCD_Share;
        myMerchandize.MCD_Date = tempMCD_Date;
        myMerchandize.MCD_Time = tempMCD_Time;              
        
        [merchandizeList addObject:myMerchandize];       
        
    }    
    
    sqlite3_reset(statement);
    
    return merchandizeList;
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
    NSString * sql = [NSString stringWithFormat:@"Select PK From Merchandize Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From Merchandize)"];
    
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
