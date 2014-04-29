//
//  SQLiteDatabase.h
//  babel
//
//  Created by Tim Pelgrim on 3/29/13.
//
//

#import <Foundation/Foundation.h>

@interface YYSQLiteDatabase : NSObject

-(instancetype)initWithDatabasePath:(NSString *)databasePath;

-(NSArray *)performQuery:(NSString *)query,...;
-(NSArray *)performSingleValueQuery:(NSString *)query,...;
-(long)insertWithQuery:(NSString *)query,...;

@end
