//
//  GenresFilterController.m
//  MovieQuotes
//
//  Created by Luca on 4/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GenresFilterController.h"
#import "SqliteDelegate.h"
#import "MoviesListController.h"
#import "MovieQuotesAppDelegate.h"

@implementation GenresFilterController
@synthesize selectedGenres;
@synthesize list;
@synthesize lastIndexPath;

- (void)viewDidLoad {
    NSArray *array = [NSMutableArray arrayWithObjects:@"Action", @"Adventure", @"Animation", @"Biography", @"Comedy", @"Crime", @"Documentary", @"Drama", @"Family", @"Fantasy", @"Film-Noir", @"Game-Show", @"History", @"Horror", @"Music", @"Musical", @"Mystery", @"Romance", @"Sci-Fi", @"Short", @"Sport", @"Thriller", @"War", @"Western", nil];    
	self.list = array;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selectedGenres.plist"];
   	self.selectedGenres = [NSMutableDictionary dictionaryWithContentsOfFile:path];

    [super viewDidLoad];
}

- (void)viewDidUnload {
    self.lastIndexPath = nil;
    [super viewDidUnload];
}


- (void)dealloc {
    [lastIndexPath release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CheckMarkCellIdentifier = @"CheckMarkCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CheckMarkCellIdentifier];
	cell.backgroundColor = [UIColor clearColor];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CheckMarkCellIdentifier] autorelease];
    }
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [lastIndexPath row];
    cell.textLabel.text = [list objectAtIndex:row];
	if ([[selectedGenres objectForKey:[list objectAtIndex:row]] isEqualToString:@"TRUE"]) {
    cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? 
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryCheckmark;
   }
	else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:18];
	cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}


#pragma mark -
#pragma mark Table Delegate Methods
- (void)tableView:(UITableView *)tableView 
didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
	UITableViewCell *newCell = [tableView cellForRowAtIndexPath:
								indexPath];
	NSUInteger row = [indexPath row]; 
	NSString *rowValue = [list objectAtIndex:row];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selectedGenres.plist"];

	if (newCell.accessoryType == UITableViewCellAccessoryCheckmark) {
		newCell.accessoryType = UITableViewCellAccessoryNone;
		[self.selectedGenres setObject:@"FALSE" forKey:rowValue];
		[self.selectedGenres writeToFile:path atomically:YES];
	}
	else {
		newCell.accessoryType = UITableViewCellAccessoryCheckmark;
		[self.selectedGenres  setObject:@"TRUE" forKey:rowValue];
		[self.selectedGenres writeToFile:path atomically:YES];
	}

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
