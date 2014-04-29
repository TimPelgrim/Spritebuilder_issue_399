//
//  SQLiteDatabase.m
//  babel
//
//  Created by Tim Pelgrim on 3/29/13.
//
//

#import "YYSQLiteDatabase.h"
#import <sqlite3.h>

@implementation YYSQLiteDatabase
{
	sqlite3 *_database;
}

-(instancetype)initWithDatabasePath:(NSString *)databasePath
{
    self = [super init];
    if (self)
    {
        sqlite3 *dbConnection;
        if (sqlite3_open([databasePath UTF8String], &dbConnection) != SQLITE_OK)
        {
            NSLog(@"[SQLITE] Unable to open database!");
            return nil;
        }
        _database = dbConnection;
    }
    return self;
}

-(id)init
{
	NSAssert(NO, @"Please use designated initialer (initWithDatabasePath:)");
	return nil;
}

//=======================================
#pragma mark Perform query
//=======================================

-(NSArray *)performQuery:(NSString *)query,...
{
	va_list va;
    va_start(va, query);
    query = [[NSString alloc] initWithFormat:query arguments:va];
    va_end(va);
    
    sqlite3_stmt *statement = nil;
	const char *sql = [query UTF8String];
	if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK)
	{
		NSLog(@"%s SQL error in query: %@ \n '%s' (%1d)",__FUNCTION__,query,  sqlite3_errmsg(_database), sqlite3_errcode(_database));
	} else
	{
#ifdef DEBUG
        NSLog(@"[SQLITE] Perform query: %@",query);
#endif
        NSMutableArray *result = [NSMutableArray array];
		while (sqlite3_step(statement) == SQLITE_ROW)
		{
			NSMutableDictionary *row = [NSMutableDictionary dictionary];
			for (int i=0; i<sqlite3_column_count(statement); i++)
			{
				int colType = sqlite3_column_type(statement, i);
				const char *columnname = sqlite3_column_name(statement, i);
				NSString *key = [NSString stringWithFormat:@"%s", columnname];
				id value;
				if (colType == SQLITE_TEXT)
				{
					const unsigned char *col = sqlite3_column_text(statement, i);
					value = [NSString stringWithUTF8String:[[NSString stringWithFormat:@"%s", col] cStringUsingEncoding:NSMacOSRomanStringEncoding]];
				} else if (colType == SQLITE_INTEGER)
				{
					int col = sqlite3_column_int(statement, i);
					value = [NSNumber numberWithInt:col];
				} else if (colType == SQLITE_FLOAT)
				{
					double col = sqlite3_column_double(statement, i);
					value = [NSNumber numberWithDouble:col];
				} else if (colType == SQLITE_NULL)
				{
					value = [NSNull null];
				} else
				{
					NSAssert(NO, @"UNKOWN DATATYPE IS DATABASE");
				}
				[row setValue:value forKey:key];
			}
			[result addObject:row];
		}
		return result;
	}
	return nil;
}

-(NSArray *)performSingleValueQuery:(NSString *)query,...
{
	va_list va;
    va_start(va, query);
    query = [[NSString alloc] initWithFormat:query arguments:va];
    va_end(va);
    
    sqlite3_stmt *statement = nil;
	const char *sql = [query UTF8String];
	if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK)
	{
		NSLog(@"[SQLITE] Error when preparing query!: %@",query);
	} else
	{
#ifdef DEBUG
        NSLog(@"[SQLITE] Perform single value query: %@",query);
#endif
        NSMutableArray *result = [NSMutableArray array];
		while (sqlite3_step(statement) == SQLITE_ROW)
		{
			int colType = sqlite3_column_type(statement, 0);
			id value;
			if (colType == SQLITE_TEXT)
			{
				const unsigned char *col = sqlite3_column_text(statement, 0);
				value = [NSString stringWithUTF8String:[[NSString stringWithFormat:@"%s", col] cStringUsingEncoding:NSMacOSRomanStringEncoding]];
			} else if (colType == SQLITE_INTEGER)
			{
				int col = sqlite3_column_int(statement, 0);
				value = [NSNumber numberWithInt:col];
			} else if (colType == SQLITE_FLOAT)
			{
				double col = sqlite3_column_double(statement, 0);
				value = [NSNumber numberWithDouble:col];
			} else if (colType == SQLITE_NULL)
			{
				value = [NSNull null];
			} else
			{
				NSAssert(NO, @"UNKOWN DATATYPE IS DATABASE");
			}
			[result addObject:value];
		}
		return result;
	}
	return nil;
}

-(long)insertWithQuery:(NSString *)query,...
{
    va_list va;
    va_start(va, query);
    query = [[NSString alloc] initWithFormat:query arguments:va];
    va_end(va);
    
#ifdef DEBUG
    NSLog(@"[SQLITE] Perform insert query: %@",query);
#endif
    sqlite3_stmt *statement = nil;
    sqlite_int64 returnID = 0;
	const char *sql = [query UTF8String];
	if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK)
	{
		NSLog(@"%s SQL error in query: %@ \n '%s' (%1d)",__FUNCTION__,query,  sqlite3_errmsg(_database), sqlite3_errcode(_database));
	} else
	{
		if (sqlite3_step(statement) == SQLITE_DONE)
		{
			returnID = sqlite3_last_insert_rowid(_database);
		}
	}
	return (long)returnID;
}


@end
