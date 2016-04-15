//
//  MoviesListController.h
//  MovieQuotes
//
//  Created by Luca on 1/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieInfoController;

@interface MoviesListController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSMutableArray *listData;
	NSMutableArray *movieIds;
	NSString *query;
	UITableView *table;
	MovieInfoController *movieInfoController;
	NSString *genre;
	NSString *sender;
}

@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic, retain) NSMutableArray *movieIds;
@property (nonatomic, retain) NSString *query;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) MovieInfoController *movieInfoController;
@property (nonatomic, retain) NSString *genre;
@property (nonatomic, retain) NSString *sender;

- (void)getList;

@end
