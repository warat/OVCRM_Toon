//
//  tblOrderDetail.m
//  TestDB
//
//  Created by Warat Agatwipat on 7/9/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "tblOrderDetail.h"
#import "AppDelegate.h"

@implementation tblOrderDetail

@synthesize pK,discount_Rate,product_ID,orderMaster_PK,suggest;
@synthesize total,totalDiscount,discount,price,totalPrice,quantity;
@synthesize orderDetailList = _orderDetailList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @" PK, Total, TotalDiscount, Discount, DiscountRate, Product_ID, Price, TotalPrice, Quantity, OrderMAster_PK "; 
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    _orderDetailList = [[NSMutableArray alloc]init];
    const char *cQuery = [sqlText UTF8String]; 
    //NSLog(@"%@",sqlText);
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
              
        double tempTotal =  sqlite3_column_double(statement, 1);
        
        double tempTotal_Discount =  sqlite3_column_double(statement, 2);
        
        double tempDiscount =  sqlite3_column_double(statement, 3);
        
        const char *cDiscount_Rate = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempDiscount_Rate = nil;      
        if (cPK != NULL)
        {
            tempDiscount_Rate = [NSString stringWithUTF8String: cDiscount_Rate]; 
        }
        
        const char *cProduct_ID = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempProduct_ID = nil;      
        if (cProduct_ID != NULL)
        {
            tempProduct_ID = [NSString stringWithUTF8String: cProduct_ID]; 
        }
        
        double tempPrice =  sqlite3_column_double(statement, 6);
        double tempTotalPrice =  sqlite3_column_double(statement, 7);
        
        int tempQuantity = sqlite3_column_int(statement, 8);
        
        const char *cOrderMaster_PK = (const char *) sqlite3_column_text(statement, 9);
        NSString *tempOrderMaster_PK = nil;      
        if (cOrderMaster_PK != NULL)
        {
            tempOrderMaster_PK = [NSString stringWithUTF8String: cOrderMaster_PK]; 
        }
                
        count = count+1;
        
        tblOrderDetail *myOrderDetail = [[tblOrderDetail alloc]init];               
        
        myOrderDetail.pK = tempPK;
        myOrderDetail.total = [[NSDecimalNumber alloc]initWithDouble:tempTotal];
        myOrderDetail.totalDiscount = [[NSDecimalNumber alloc]initWithDouble:tempDiscount];
        myOrderDetail.discount = [[NSDecimalNumber alloc]initWithDouble:tempDiscount];
        myOrderDetail.discount_Rate = tempDiscount_Rate;
        myOrderDetail.totalDiscount = [[NSDecimalNumber alloc]initWithDouble:tempTotal_Discount];
        myOrderDetail.product_ID = tempProduct_ID;
        myOrderDetail.price = [[NSDecimalNumber alloc]initWithDouble:tempPrice];
        myOrderDetail.totalPrice = [[NSDecimalNumber alloc]initWithDouble:tempTotalPrice];
        myOrderDetail.quantity = [[NSDecimalNumber alloc]initWithDouble:tempQuantity];
        
        [_orderDetailList addObject:myOrderDetail];
    }    
    
    sqlite3_reset(statement);
    
    return _orderDetailList;
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
    NSString * sql = [NSString stringWithFormat:@"Select PK From OrderDetail Where CAST(PK as INTEGER) = (Select MAX(CAST(PK as INTEGER))  From OrderDetail)"];
    
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


-(NSMutableArray *)QueryData2:(NSString *)sqlText
{    
    _orderDetailList = [[NSMutableArray alloc]init];
    const char *cQuery = [sqlText UTF8String]; 
    //NSLog(@"%@",sqlText);
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
        
        double tempTotal =  sqlite3_column_double(statement, 1);
        
        double tempTotal_Discount =  sqlite3_column_double(statement, 2);
        
        double tempDiscount =  sqlite3_column_double(statement, 3);
        
        const char *cDiscount_Rate = (const char *) sqlite3_column_text(statement, 4);
        NSString *tempDiscount_Rate = nil;      
        if (cDiscount_Rate != NULL)
        {
            tempDiscount_Rate = [NSString stringWithUTF8String:cDiscount_Rate]; 
        }
        
        const char *cProduct_ID = (const char *) sqlite3_column_text(statement, 5);
        NSString *tempProduct_ID = nil;      
        if (cProduct_ID != NULL)
        {
            tempProduct_ID = [NSString stringWithUTF8String: cProduct_ID]; 
        }
        
        double tempPrice =  sqlite3_column_double(statement, 6);
        double tempTotalPrice =  sqlite3_column_double(statement, 7);
        
        int tempQuantity = sqlite3_column_int(statement, 8);
        
        const char *cOrderMaster_PK = (const char *) sqlite3_column_text(statement, 9);
        NSString *tempOrderMaster_PK = nil;      
        if (cOrderMaster_PK != NULL)
        {
            tempOrderMaster_PK = [NSString stringWithUTF8String: cOrderMaster_PK]; 
        }
        
        int tempSuggest = sqlite3_column_int(statement, 8);
        
        count = count+1;
        
        tblOrderDetail *myOrderDetail = [[tblOrderDetail alloc]init];               
        
        myOrderDetail.pK = tempPK;
        myOrderDetail.total = [[NSDecimalNumber alloc]initWithDouble:tempTotal];
        myOrderDetail.totalDiscount = [[NSDecimalNumber alloc]initWithDouble:tempDiscount];
        myOrderDetail.discount = [[NSDecimalNumber alloc]initWithDouble:tempDiscount];
        myOrderDetail.discount_Rate = tempDiscount_Rate;
        myOrderDetail.totalDiscount = [[NSDecimalNumber alloc]initWithDouble:tempTotal_Discount];
        myOrderDetail.product_ID = tempProduct_ID;
        myOrderDetail.price = [[NSDecimalNumber alloc]initWithDouble:tempPrice];
        myOrderDetail.totalPrice = [[NSDecimalNumber alloc]initWithDouble:tempTotalPrice];
        myOrderDetail.quantity = [[NSDecimalNumber alloc]initWithDouble:tempQuantity];
        myOrderDetail.suggest = [[NSDecimalNumber alloc]initWithInt:tempSuggest];
        
        [_orderDetailList addObject:myOrderDetail];
    }    
    
    sqlite3_reset(statement);
    
    return _orderDetailList;
}



@end