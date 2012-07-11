//
//  CallCard.m
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tblCallCard.h"
#import "AppDelegate.h"

@implementation tblCallCard

@synthesize  plan_ID;
@synthesize  PK;
@synthesize  account_ID;
@synthesize  cS_Date;
@synthesize  cS_Time;

@synthesize  callCardList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"Plan_ID ,PK ,Account_ID ,CS_Date ,CS_Time ";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    callCardList = [[NSMutableArray alloc]init];
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
        
//        int pPK = sqlite3_column_int(statement, 1); 
        
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
                    
        const char *cCS_Date = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempCS_Date = nil;      
        if (cCS_Date != NULL)
        {
            tempCS_Date = [NSString stringWithUTF8String: cCS_Date]; 
        } 
        
        const char *cCS_Time = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempCS_Time = nil;      
        if (cCS_Time != NULL)
        {
            tempCS_Time = [NSString stringWithUTF8String: cCS_Time]; 
        }
        
        
        count = count+1;
        
        tblCallCard *myCallCard = [[tblCallCard alloc]init];               
        
        myCallCard.plan_ID = tempPlan_ID;
        myCallCard.PK = tempPK;
        myCallCard.account_ID = tempAccount_ID;
        myCallCard.CS_Date = tempCS_Date;
        myCallCard.CS_Time = tempCS_Time;              
        
        [callCardList addObject:myCallCard];       
        
    }    
    
    sqlite3_reset(statement);
    
    return callCardList;
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
    NSString * sql = [NSString stringWithFormat:@"Select PK From CallCard Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From CallCard)"];
    
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
