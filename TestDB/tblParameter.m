//
//  tblParameter.m
//  TestDB
//
//  Created by Admin on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tblParameter.h"
#import "AppDelegate.h"

@implementation tblParameter

@synthesize  tag,key,label;
@synthesize  parameterList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"tag,key,label";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    
    parameterList = [[NSMutableArray alloc] init] ;
    
    const char *cQuery = [sqlText UTF8String]; 
    
    if (sqlite3_prepare_v2(database, cQuery, -1, &statement, NULL) != SQLITE_OK)
    {
        NSLog(@"Query Error:%@",statement);
    }       
    
    NSInteger *count=0;
    
    while (sqlite3_step(statement) == SQLITE_ROW)
    {
        
        const char *cTag = (const char *) sqlite3_column_text(statement, 0);
        NSString *tempTag = nil;      
        if (cTag != NULL)
        {
            tempTag = [NSString stringWithUTF8String: cTag]; 
        } 
        
        const char *cKey = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempKey = nil;      
        if (cKey != NULL)
        {
            tempKey = [NSString stringWithUTF8String: cKey]; 
        }                     
        
        const char *cLabel = (const char *) sqlite3_column_text(statement, 2);                
        NSString *tempLabel = nil;      
        if (cLabel != NULL)
        {
            tempLabel = [NSString stringWithUTF8String: cLabel]; 
        } 
       
        count = count+1;
        
        tblParameter *myParameter = [[tblParameter alloc]init];       
        
        myParameter.tag = tempTag;
        myParameter.key = tempKey;
        myParameter.label = tempLabel;             
        
        [parameterList addObject:myParameter];      
        
    }    
    
    sqlite3_reset(statement);
    
    return parameterList;
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
        parameterList = [[NSMutableArray alloc] init] ;
        
        result = YES;
    }
    
    return result;
}



@end
