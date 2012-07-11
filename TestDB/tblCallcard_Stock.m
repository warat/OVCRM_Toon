//
//  tblCallcard_Stock.m
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tblCallcard_Stock.h"
#import "AppDelegate.h"

@implementation tblCallcard_Stock

@synthesize  callCard_PK;
@synthesize  PK;
@synthesize  product_Name;
@synthesize  onShelf;
@synthesize  inStock;

@synthesize  callCardStockList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"CallCard_PK ,PK ,Product_Name ,OnShelf ,InStock";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    callCardStockList = [[NSMutableArray alloc]init];
    
    const char *cQuery = [sqlText UTF8String]; 
    NSLog(@"%@" ,sqlText);
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
        
        const char *cProduct_ID = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempProduct_ID = nil;      
        if (cProduct_ID != NULL)
        {
            tempProduct_ID = [NSString stringWithUTF8String: cProduct_ID]; 
        } 
        
        const char *cOnShelf = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempOnShelf = nil;      
        if (cOnShelf != NULL)
        {
            tempOnShelf = [NSString stringWithUTF8String: cOnShelf]; 
        } 
        
        const char *cInStock = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempInStock = nil;      
        if (cInStock != NULL)
        {
            tempInStock = [NSString stringWithUTF8String: cInStock]; 
        }                        
        
        count = count+1;
        
        tblCallcard_Stock *myCallCard_Stock = [[tblCallcard_Stock alloc]init];               
        
        myCallCard_Stock.callCard_PK = tempPlan_ID;
        myCallCard_Stock.PK = tempPK;
        myCallCard_Stock.product_Name = tempProduct_ID;
        myCallCard_Stock.onShelf = tempOnShelf;
        myCallCard_Stock.inStock = tempInStock;        
        
        [callCardStockList addObject:myCallCard_Stock];       
        
    }    
    
    sqlite3_reset(statement);
    
    return callCardStockList;
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

-(NSString *)GetMaxRnNo
{
    
    NSString * tempMax = nil;  
    NSString * sql = [NSString stringWithFormat:@"Select PK From CallCard_Stock Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From CallCard_Stock)"];
    
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
