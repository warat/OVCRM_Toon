//
//  tblProduct.m
//  TestDB
//
//  Created by Admin on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "tblProduct.h"
#import "AppDelegate.h"

@implementation tblProduct

@synthesize  PK;
@synthesize  sale_ID;
@synthesize  product_Code;
@synthesize  product_Name;
@synthesize  lastSyncDate;
@synthesize  lastSyncTime;
@synthesize  cost;
@synthesize  weight;  
@synthesize  packaging;
@synthesize  width;
@synthesize  packSize;
@synthesize  productLong;
@synthesize  height;
@synthesize  productCategory;
@synthesize  brand;
@synthesize  shortName ;
@synthesize  product_Family; 
@synthesize  target;
@synthesize  unitName;
@synthesize  isCancel;
@synthesize  activeFlag;
@synthesize  expireFlag;
@synthesize  returnAmt; 

@synthesize  productList;

sqlite3 *database;
sqlite3_stmt *statement;

-(NSString *)DB_Field
{
    return @"PK,sale_ID,product_Code,product_Name,lastSyncDate,lastSyncTime,cost,weight,packaging,width,packSize,productLong,height,product_Category,brand,shortName,product_Family,target,unitName,isCancel,Active_Flag,Expire_Flag ";
}

-(NSMutableArray *)QueryData:(NSString *)sqlText
{    
    productList = [[NSMutableArray alloc] init] ;
    
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
        
        const char *cSale_ID = (const char *) sqlite3_column_text(statement, 1);
        NSString *tempSale_ID = nil;      
        if (cSale_ID != NULL)
        {
            tempSale_ID = [NSString stringWithUTF8String: cSale_ID]; 
        }                     
        
        const char *cProduct_Code = (const char *) sqlite3_column_text(statement, 2);                
        NSString *tempProduct_Code = nil;      
        if (cProduct_Code != NULL)
        {
            tempProduct_Code = [NSString stringWithUTF8String: cProduct_Code]; 
        } 
        
        const char *cProduct_Name = (const char *) sqlite3_column_text(statement, 3);                
        NSString *tempProduct_Name = nil;      
        if (cProduct_Name != NULL)
        {
            tempProduct_Name = [NSString stringWithUTF8String: cProduct_Name]; 
        }
        
        const char *cLastSyncDate = (const char *) sqlite3_column_text(statement, 4);                
        NSString *tempLastSyncDate = nil;      
        if (cLastSyncDate != NULL)
        {
            tempLastSyncDate = [NSString stringWithUTF8String: cLastSyncDate]; 
        }  
        
        const char *cLastSyncTime = (const char *) sqlite3_column_text(statement, 5);                
        NSString *tempLastSyncTime = nil;      
        if (cLastSyncTime != NULL)
        {
            tempLastSyncTime = [NSString stringWithUTF8String: cLastSyncTime]; 
        }  
        
        int pCost = sqlite3_column_int(statement, 6);   
        
        const char *cWeight = (const char *) sqlite3_column_text(statement, 7);                
        NSString *tempWeight = nil;      
        if (cWeight != NULL)
        {
            tempWeight = [NSString stringWithUTF8String: cWeight]; 
        } 
        
        const char *cPackaging = (const char *) sqlite3_column_text(statement, 8);                
        NSString *tempPackaging = nil;      
        if (cPackaging != NULL)
        {
            tempPackaging = [NSString stringWithUTF8String: cPackaging]; 
        } 
        
        const char *cWidth = (const char *) sqlite3_column_text(statement, 9);                
        NSString *tempWidth = nil;      
        if (cWidth != NULL)
        {
            tempWidth = [NSString stringWithUTF8String: cWidth]; 
        } 
        
        const char *cPackSize = (const char *) sqlite3_column_text(statement, 10);                
        NSString *tempPackSize = nil;      
        if (cPackSize != NULL)
        {
            tempPackSize = [NSString stringWithUTF8String: cPackSize]; 
        } 
        
        const char *cProductLong = (const char *) sqlite3_column_text(statement, 11);                
        NSString *tempProductLong = nil;      
        if (cProductLong != NULL)
        {
            tempProductLong = [NSString stringWithUTF8String: cProductLong]; 
        }
        
        const char *cHeight = (const char *) sqlite3_column_text(statement, 12);                
        NSString *tempHeight = nil;      
        if (cHeight != NULL)
        {
            tempHeight = [NSString stringWithUTF8String: cHeight]; 
        }
        
        const char *cProductCategory = (const char *) sqlite3_column_text(statement, 13);                
        NSString *tempProductCategory = nil;      
        if (cProductCategory != NULL)
        {
            tempProductCategory = [NSString stringWithUTF8String: cProductCategory]; 
        }
        
        const char *cBrand = (const char *) sqlite3_column_text(statement, 14);                
        NSString *tempBrand = nil;      
        if (cBrand != NULL)
        {
            tempBrand = [NSString stringWithUTF8String: cBrand]; 
        }
        
        const char *cShortName = (const char *) sqlite3_column_text(statement, 15);                
        NSString *tempShortName = nil;      
        if (cShortName != NULL)
        {
            tempShortName = [NSString stringWithUTF8String: cShortName]; 
        }
        
        const char *cProduct_Family = (const char *) sqlite3_column_text(statement, 16);                
        NSString *tempProduct_Family = nil;      
        if (cProduct_Family != NULL)
        {
            tempProduct_Family = [NSString stringWithUTF8String: cProduct_Family]; 
        }
        
        const char *cTarget = (const char *) sqlite3_column_text(statement, 17);                
        NSString *tempTarget = nil;      
        if (cTarget != NULL)
        {
            tempTarget = [NSString stringWithUTF8String: cTarget]; 
        }
        
        const char *cUnitName = (const char *) sqlite3_column_text(statement, 18);                
        NSString *tempUnitName = nil;      
        if (cUnitName != NULL)
        {
            tempUnitName = [NSString stringWithUTF8String: cUnitName]; 
        }
        
        const char *cIsCancel = (const char *) sqlite3_column_text(statement, 19);                
        NSString *tempIsCancel = nil;      
        if (cIsCancel != NULL)
        {
            tempIsCancel = [NSString stringWithUTF8String: cIsCancel]; 
        }
        
        const char *cActiveFlag = (const char *) sqlite3_column_text(statement, 20);                
        NSString *tempActiveFlag = nil;      
        if (cActiveFlag != NULL)
        {
            tempActiveFlag = [NSString stringWithUTF8String: cActiveFlag]; 
        }
        
        const char *cExireFlag = (const char *) sqlite3_column_text(statement, 21);                
        NSString *tempExpireFlag = nil;      
        if (cExireFlag != NULL)
        {
            tempExpireFlag = [NSString stringWithUTF8String: cExireFlag]; 
        }
        
        count = count+1;
        
        tblProduct *myProduct = [[tblProduct alloc]init];       
        
        myProduct.PK = tempPK;
        myProduct.sale_ID = tempSale_ID;//pRunNo;
        myProduct.product_Code = tempProduct_Code;
        myProduct.product_Name = tempProduct_Name;
        myProduct.lastSyncDate = tempLastSyncDate;
        myProduct.lastSyncTime = tempLastSyncTime;
        myProduct.cost = pCost; 
        myProduct.weight = tempWeight;
        myProduct.packaging = tempPackaging;
        myProduct.width = tempWidth;
        myProduct.packSize = tempPackSize;
        myProduct.productLong = tempProductLong; 
        myProduct.height = tempHeight;
        myProduct.productCategory = tempProductCategory;
        myProduct.brand = tempBrand;
        myProduct.shortName = tempShortName;
        myProduct.product_Family = tempProduct_Family;
        myProduct.target = tempTarget;
        myProduct.unitName = tempUnitName;
        myProduct.isCancel = tempIsCancel;
        myProduct.activeFlag = tempActiveFlag;
        myProduct.expireFlag = tempExpireFlag;
        myProduct.returnAmt = @"";
        
        [productList addObject:myProduct];      
        
    }    
    
    sqlite3_reset(statement);
    
    return productList;
}

-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr
{
    const char *cInsert = [addText UTF8String]; //"insert into Product (Product_ID,Product_Name) values (?,?)";
    
    sqlite3_stmt *insert_statement = nil;
    
    sqlite3_prepare_v2(database, cInsert, -1, &insert_statement, NULL);
    
    
    for(int i=0;i<[paramArr count];i++)
    {
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
        productList = [[NSMutableArray alloc] init] ;

        result = YES;
    }
    
    return result;
}

@end
