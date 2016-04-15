//
//  SqliteDelegate.h
//  Quotes
//
//  Created by Luca on 1/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqliteDelegate : NSObject {
	NSArray *queryAttributes;
}

@property (nonatomic, retain) NSArray *queryAttributes;

- (NSMutableArray *)dbQuery:(NSString *)query columns:(int)anInteger;

@end
