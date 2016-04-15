//
//  MoviesListController.m
//  MovieQuotes
//
//  Created by Luca on 1/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MoviesListController.h"
#import "SqliteDelegate.h"
#import "MovieInfoController.h"
#import "MovieQuotesAppDelegate.h"

@implementation MoviesListController
@synthesize listData;
@synthesize table;
@synthesize movieInfoController;
@synthesize movieIds;
@synthesize genre;
@synthesize query;
@synthesize sender;


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getList {
	SqliteDelegate *dbConnector = [[SqliteDelegate alloc]init];
	NSMutableArray *result = [dbConnector dbQuery:query columns:2];
	[self.movieIds release];
	[self.listData release];
	self.movieIds = [result objectAtIndex:0];
	self.listData = [result objectAtIndex:1];
	[dbConnector release];
	[table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

}


#pragma mark - 
#pragma mark Table View Data Source Methods 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
	return [self.listData count];
} 

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
	if (cell == nil) { 
		cell = [[[UITableViewCell alloc]
					initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	NSUInteger row = [indexPath row];
	cell.textLabel.text = [listData objectAtIndex:row]; 
	cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:18];
	cell.detailTextLabel.text = [movieIds objectAtIndex:row];
//	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row]; 
//	NSString *rowValue = [listData objectAtIndex:row];
	NSString *movie = [movieIds objectAtIndex:row];
	if (self.movieInfoController == nil) {
		MovieInfoController *aMovieInfo = [[MovieInfoController alloc] init];
		self.movieInfoController = aMovieInfo;
		[aMovieInfo release];
	}
	movieInfoController.movieId =  [NSString stringWithFormat:@"%@", movie];
	[movieInfoController getMovieInfo];
	movieInfoController.title = [NSString stringWithFormat:@"Info"];
	
	MovieQuotesAppDelegate *delegate = (MovieQuotesAppDelegate *)[[UIApplication sharedApplication] delegate];
	if ([sender isEqualToString:@"Genres"]) {
		movieInfoController.navController = delegate.genresNavController;
		[delegate.genresNavController pushViewController:movieInfoController animated:YES];
	}
	if ([sender isEqualToString:@"AlphabeticalList"]) {
		movieInfoController.navController = delegate.genresNavController;
		[delegate.alphabetNavController pushViewController:movieInfoController animated:YES];
	}
	if ([sender isEqualToString:@"Search"]) {
		movieInfoController.navController = delegate.searchNavController;
		[delegate.searchNavController pushViewController:movieInfoController animated:YES];
	}	
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}
	
- (void)dealloc {
	[table release];
	[movieInfoController release];
    [super dealloc];
}


@end
