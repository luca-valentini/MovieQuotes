//
//  SqliteDelegate.m
//  Quotes
//
//  Created by Luca on 1/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SqliteDelegate.h"
#import <sqlite3.h>

@implementation SqliteDelegate
@synthesize queryAttributes;

- (NSMutableArray *)dbQuery:(NSString *)query columns:(int) anInteger{
	NSString *path = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
	sqlite3 *database;
	if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
	{
		sqlite3_stmt *statement;
		sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, nil);
		NSMutableArray *queryResult = [[NSMutableArray alloc]init];
		for (int i = 0; i < anInteger; i++) {
			[queryResult addObject:[[NSMutableArray alloc]init]];
		}
		while(sqlite3_step(statement) == SQLITE_ROW)
		{
				for (int i = 0; i < anInteger; i++) 
				{
					NSString *value = [[NSString alloc] initWithUTF8String:
							   (char *)sqlite3_column_text(statement, i)];
					[[queryResult objectAtIndex:i]addObject:value];
					[value release];
				}
		}
		sqlite3_close(database);
		return queryResult;
	}
	
	else 
	{
		sqlite3_close(database);
		return nil;
	}
}


@end
