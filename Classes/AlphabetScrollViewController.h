//
//  AlphabetScrollViewController.h
//  MovieQuotes
//
//  Created by Luca on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MoviesListController;
@class MovieInfoController;
@interface AlphabetScrollViewController : UIViewController {
 	UIScrollView *scrollView;
	MoviesListController *moviesListController;	
	UITableView *table;
	NSMutableArray *listData;
	NSMutableArray *movieIds;
	MovieInfoController *movieInfoController;
	NSString *query;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *movieIds;
@property (nonatomic, retain) NSMutableArray *listData;
@property (nonatomic, retain) MoviesListController *moviesListController;
@property (nonatomic, retain) MovieInfoController *movieInfoController;
@property (nonatomic, retain) NSString *query;
- (void)createButtons;
- (void)getList;
@end
