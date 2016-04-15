//
//  GenresController.h
//  MovieQuotes
//
//  Created by Luca on 1/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MoviesListController;

@interface GenresController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSMutableArray *listData;
	UITableView *table;
	MoviesListController *moviesListController;
}
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic, retain) MoviesListController *moviesListController;

@end
