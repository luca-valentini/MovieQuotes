//
//  GenresController.m
//  MovieQuotes
//
//  Created by Luca on 1/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GenresController.h"
#import "SqliteDelegate.h"
#import "MoviesListController.h"
#import "MovieQuotesAppDelegate.h"

@implementation GenresController
@synthesize table;
@synthesize listData;
@synthesize moviesListController;


- (void)viewDidLoad {
	self.title = @"Genres";
    [super viewDidLoad];
	NSMutableArray *genresList = [NSMutableArray arrayWithObjects:@"Action", @"Adventure", @"Animation", @"Biography", @"Comedy", @"Crime", @"Documentary", @"Drama", @"Family", @"Fantasy", @"Film-Noir", @"Game-Show", @"History", @"Horror", @"Music", @"Musical", @"Mystery", @"Romance", @"Sci-Fi", @"Short", @"Sport", @"Thriller", @"War", @"Western", nil];
	self.listData = genresList;	
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

}


- (void)dealloc {
	[listData release];
    [super dealloc];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
	return [self.listData count];
} 



/* - (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
	if (cell == nil) { 
		cell = [[[UITableViewCell alloc]
				 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier] autorelease];
	}
	NSUInteger row = [indexPath row]; 
	cell.textLabel.text = [listData objectAtIndex:row]; 
	cell.textLabel.textColor = [UIColor whiteColor];
//	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:1818];
	return cell;
} */

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
	//cell.detailTextLabel.text = [movieIds objectAtIndex:row];
	//cell.accessoryType = UITableViewCellAccessoryType
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:18];
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}



-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row]; 
	NSString *rowValue = [listData objectAtIndex:row];
	if (self.moviesListController == nil) {
		MoviesListController *aList = [[MoviesListController alloc] init];
		self.moviesListController = aList;
		[aList release];
	}
	moviesListController.query  = [NSString stringWithFormat:@"SELECT id, title FROM movies WHERE genre like '%%%@%%'", rowValue];
	moviesListController.title = rowValue;
	moviesListController.sender = [NSString stringWithFormat:@"Genres"];
	[moviesListController getList];
	[moviesListController.table reloadData];
	MovieQuotesAppDelegate *delegate = (MovieQuotesAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate.genresNavController pushViewController:moviesListController animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[moviesListController release];
	moviesListController = nil;

	
}
@end
