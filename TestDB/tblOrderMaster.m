//
//  tblOrderMaster.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/9/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblOrderMaster.h"
#import "AppDelegate.h"

@implementation tblOrderMaster

@synthesize plan_ID,pK,order_Date,order_Time;
@synthesize order_Total;
@synthesize orderMasterList = _orderMasterList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @" Plan_ID ,PK ,Order_Date ,Order_Time ,Order_Total "; 
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _orderMasterList = [[NSMutableArray alloc]init];
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
        
        const char *cOrder_Date = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempOrder_Date = nil;      
        if (cOrder_Date != NULL)
        {
            tempOrder_Date = [NSString stringWithUTF8String: cOrder_Date]; 
        }
        
        const char *cOrder_Time = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempOrder_Time = nil;      
        if (cOrder_Time != NULL)
        {
            tempOrder_Time = [NSString stringWithUTF8String: cOrder_Time]; 
        }
        
        double tempOrder_Total =  sqlite3_column_double(statement, 4);
        
        count = count+1;
        
        tblOrderMaster *myOrderMaster = [[tblOrderMaster alloc]init];               
        
        myOrderMaster.plan_ID = tempPlan_ID;
        myOrderMaster.pK = tempPK;
        myOrderMaster.order_Date = tempOrder_Date;
        myOrderMaster.order_Time = tempOrder_Time;
        
        myOrderMaster.order_Total = [[NSDecimalNumber alloc]initWithDouble:tempOrder_Total];
        
        [_orderMasterList addObject:myOrderMaster];
    }    
    
    sqlite3_reset(statement);
    
    return _orderMasterList;
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
    NSString * sql = [NSString stringWithFormat:@"Select PK From OrderMaster Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From OrderMaster)"];
    
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
