//
//  tblInvoice.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblInvoice.h"
#import "AppDelegate.h"

@implementation tblInvoice

@synthesize pK;
@synthesize invoice_No;
@synthesize inv_DueDate;
@synthesize inv_Total;
@synthesize paid;
@synthesize account_ID;
@synthesize invoiceList = _invoiceList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"PK, Invoice_No, Inv_DueDate, Inv_Total, Paid, Account_ID";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _invoiceList = [[NSMutableArray alloc]init];
    const char *cQuery = [sqlText UTF8String]; 
    NSLog(@"%@",sqlText);
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
        const char *cInvoice_No = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempInvoice_No = nil;      
        if (cInvoice_No != NULL)
        {
            tempInvoice_No = [NSString stringWithUTF8String: cInvoice_No]; 
        }  
        const char *cInv_DueDate = (const char *) sqlite3_column_text(statement, 2);
        NSString *tempInv_DueDate = nil;      
        if (cInv_DueDate != NULL)
        {
            tempInv_DueDate = [NSString stringWithUTF8String: cInv_DueDate]; 
        }  
        const char *cInv_Total = (const char *) sqlite3_column_text(statement, 3);
        NSString *tempInv_Total = nil;      
        if (cInv_Total != NULL)
        {
            tempInv_Total = [NSString stringWithUTF8String: cInv_Total]; 
        }  
        const char *cPaid = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempPaid = nil;      
        if (cPaid != NULL)
        {
            tempPaid = [NSString stringWithUTF8String: cPaid]; 
        }  
        const char *cAccount_ID = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempAccount_ID = nil;      
        if (cAccount_ID != NULL)
        {
            tempAccount_ID = [NSString stringWithUTF8String: cAccount_ID]; 
        }  
        
        count = count+1;
        
        tblInvoice *myInvoice = [[tblInvoice alloc]init];               
        
        myInvoice.PK = tempPK;
        myInvoice.invoice_No = tempInvoice_No;
        myInvoice.inv_DueDate = tempInv_DueDate;
        myInvoice.inv_Total = tempInv_Total;
        myInvoice.paid = tempPaid;
        myInvoice.account_ID = tempAccount_ID;
        
        [_invoiceList addObject:myInvoice];
    }    
    
    sqlite3_reset(statement);
    
    return _invoiceList;
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
    NSString * sql = [NSString stringWithFormat:@"Select PK From Invoice Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From Invoice)"];
    
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
