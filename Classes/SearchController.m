//
//  SearchController.m
//  MovieQuotes
//
//  Created by Luca on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SearchController.h"
#import "SqliteDelegate.h"
#import "GenresFilterController.h"
#import "MovieQuotesAppDelegate.h"
#import "PeriodPickerController.h"
#import "MoviesListController.h"

@implementation SearchController
@synthesize names;
@synthesize keys;
@synthesize genresFilterController;
@synthesize tempValues;
@synthesize textFieldBeingEdited;
@synthesize tableViewOutlet;
@synthesize movieTitle;
@synthesize actor;
@synthesize director;
@synthesize genres;
@synthesize period;
@synthesize searchParameters;
@synthesize genresFilterDictionary;
@synthesize periodPickerController;
@synthesize selectedPeriod;
@synthesize moviesListController;

- (void)viewDidLoad {
	int i = 0;
//	[dict release];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selectedGenres.plist"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		  NSMutableArray *array = [NSMutableArray arrayWithObjects:@"Action", @"Adventure", @"Animation", @"Biography", @"Comedy", @"Crime", @"Documentary", @"Drama", @"Family", @"Fantasy", @"Film-Noir", @"Game-Show", @"History", @"Horror", @"Music", @"Musical", @"Mystery", @"Romance", @"Sci-Fi", @"Short", @"Sport", @"Thriller", @"War", @"Western", nil];    
		  NSMutableDictionary *selectedGenres = [[NSMutableDictionary alloc]init];
		  for (int i = 0; i < [array count]; i++) {
			  [selectedGenres setValue:@"TRUE" forKey:[array objectAtIndex:i]];
		  }
		[selectedGenres writeToFile:path atomically:YES];
	}
	else {
		self.genresFilterDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
		for (id key in self.genresFilterDictionary) {
			if ([[self.genresFilterDictionary objectForKey:key] isEqualToString:@"TRUE"]) i++;
		}
	}
	NSString *genresSelected = [NSString stringWithFormat:@"Genres", i];
	NSArray *aSection = [NSArray arrayWithObjects:@"Title: ", @"Actor: ", @"Director: ", nil];
	NSMutableArray *filters = [NSMutableArray arrayWithObjects:genresSelected, @"Period", nil];
	NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:filters, @"Filters", aSection, @"ASearch", nil];
	self.names = dict;
	
	NSArray *array = [[names allKeys] sortedArrayUsingSelector:@selector(compare:)];
	self.keys = array;
	self.tableViewOutlet.backgroundColor = [UIColor clearColor];

}

- (void)viewDidUnload {
	self.names = nil;
	self.keys = nil;
}

- (void)dealloc {
	[names release]; 
	[keys release]; 
	[super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [keys count];
}


- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    return [nameSection count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    NSString *key = [keys objectAtIndex:section];
    NSArray *nameSection = [names objectForKey:key];
    
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             SectionsTableIdentifier ];
		if (cell == nil) {

			if (section == 0) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
											   reuseIdentifier:SectionsTableIdentifier ] autorelease];
				cell.backgroundColor = [UIColor clearColor];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
				UILabel *label = [[UILabel alloc] initWithFrame:
								  CGRectMake(10, 8, 88, 25)];
				label.textAlignment = UITextAlignmentRight;
				label.tag = 4096;
				label.text = [nameSection objectAtIndex:row];
				
				label.font = [UIFont fontWithName:@"Courier-Bold" size:14];
				label.textColor = [UIColor whiteColor];
				label.backgroundColor = [UIColor clearColor];
				[cell.contentView addSubview:label];
				[label release];
				UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(95, 12, 200, 25)];
				if (row == 0) {
					movieTitle = textField;
				}
				if (row == 1) {
					actor = textField;
				}
				if (row == 2) {
					director = textField;
				}
				textField.text = @"";
				textField.clearsOnBeginEditing = YES;
			//	textField.backgroundColor = [UIColor clearColor];
				textField.font = [UIFont fontWithName:@"Courier-Bold" size:14];
				textField.textColor = [UIColor whiteColor];
				[textField setDelegate:self];
				textField.tag = 12345;
				[textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
				[cell.contentView addSubview:textField];
				[searchParameters addObject:textField];
			}
			
			if (section == 1) {
				cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
											   reuseIdentifier:SectionsTableIdentifier ] autorelease];

				cell.backgroundColor = [UIColor clearColor];
				//UILabel *label = [[UILabel alloc] initWithFrame:
			//					  CGRectMake(10, 8, 80, 25)];
			//	label.textAlignment = UITextAlignmentCenter;
			//	label.tag = 4096;
			//	label.text = [nameSection objectAtIndex:row];
				cell.textLabel.text = [nameSection objectAtIndex:row];
				cell.textLabel.textAlignment = UITextAlignmentCenter;
				cell.textLabel.textColor = [UIColor whiteColor];
				cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:14];
			//	label.textColor = [UIColor whiteColor];
			//	label.backgroundColor = [UIColor clearColor];
			//	label.font = [UIFont fontWithName:@"Courier-Bold" size:14];
			//	[cell.contentView addSubview:label];
				cell.selectionStyle = UITableViewCellSelectionStyleGray;
			//	[label release];
				cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
				
				NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
				NSString *documentsDirectory = [paths objectAtIndex:0];
				NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selectedGenres.plist"];
				if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
					NSMutableArray *array = [NSMutableArray arrayWithObjects:@"Action", @"Adventure", @"Animation", @"Biography", @"Comedy", @"Crime", @"Documentary", @"Drama", @"Family", @"Fantasy", @"Film-Noir", @"Game-Show", @"History", @"Horror", @"Music", @"Musical", @"Mystery", @"Romance", @"Sci-Fi", @"Short", @"Sport", @"Thriller", @"War", @"Western", nil];    
					NSMutableDictionary *selectedGenres = [[NSMutableDictionary alloc]init];
					for (int i = 0; i < [array count]; i++) {
						[selectedGenres setValue:@"TRUE" forKey:[array objectAtIndex:i]];
					}
					[selectedGenres writeToFile:path atomically:YES];
				}
			} 
							  
		} 

	cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:14];
 //   cell.textLabel.text = [nameSection objectAtIndex:row];
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tableView 
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self backgroundTap:self];
	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];
	if(section == 1) {
		if (row == 0) {
			if (self.genresFilterController == nil) {
				GenresFilterController *aList = [[GenresFilterController alloc] init];
				self.genresFilterController = aList;
				self.genresFilterDictionary = [[NSMutableDictionary alloc]init];
				genresFilterController.selectedGenres = self.genresFilterDictionary;
				[aList release];
			}
		
			MovieQuotesAppDelegate *delegate = (MovieQuotesAppDelegate *)[[UIApplication sharedApplication] delegate];
			[delegate.searchNavController pushViewController:genresFilterController animated:YES];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			self.genresFilterDictionary = genresFilterController.selectedGenres;
			genresFilterController.title = @"Selected Genres";
			[genresFilterDictionary retain];
			[genresFilterController release];
			genresFilterController = nil;
		}
		
		if (row == 1) {
			if (self.periodPickerController == nil) {
				PeriodPickerController *aPicker = [[PeriodPickerController alloc]init];
				self.selectedPeriod = [[NSMutableDictionary alloc]init];
				self.periodPickerController = aPicker;
				periodPickerController.selectedPeriod = self.selectedPeriod;
				periodPickerController.title = @"Period";
				[aPicker release];
			}
			
			MovieQuotesAppDelegate *delegate = (MovieQuotesAppDelegate *)[[UIApplication sharedApplication] delegate];
			[delegate.searchNavController pushViewController:periodPickerController animated:YES];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
		} 
	}	
	return nil;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.textFieldBeingEdited = textField;

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSNumber *tagAsNum = [[NSNumber alloc] initWithInt:textField.tag];
    [tempValues setObject:textField.text forKey:tagAsNum];
	[textField resignFirstResponder];
    [tagAsNum release];
}



-(IBAction)cancel:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender
{
    
    if (textFieldBeingEdited != nil)
    {
        NSNumber *tagAsNum= [[NSNumber alloc] 
                             initWithInt:textFieldBeingEdited.tag];
        [tempValues setObject:textFieldBeingEdited.text forKey: tagAsNum];
        [tagAsNum release];
        
    }
	
	[self.navigationController popViewControllerAnimated:YES];
    
    NSArray *allControllers = self.navigationController.viewControllers;
    UITableViewController *parent = [allControllers lastObject];
    [parent.tableView reloadData];
}


-(IBAction)textFieldDone:(id)sender {
    UITableViewCell *cell = (UITableViewCell *)[[sender superview] superview];
    UITableView *table = (UITableView *)[cell superview];
    NSIndexPath *textFieldIndexPath = [table indexPathForCell:cell];
    NSUInteger row = [textFieldIndexPath row];
    row++;
    if (row >= kNumberOfEditableRows)
        row = 0;
    NSUInteger newIndex[] = {0, row};
    NSIndexPath *newPath = [[NSIndexPath alloc] initWithIndexes:newIndex 
                                                         length:2];
    UITableViewCell *nextCell = [self.tableViewOutlet
                                 cellForRowAtIndexPath:newPath];
    UITextField *nextField = nil;
    for (UIView *oneView in nextCell.contentView.subviews) {
        if ([oneView isMemberOfClass:[UITextField class]])
            nextField = (UITextField *)oneView;
    }
    [nextField becomeFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
	[actor resignFirstResponder];
	[movieTitle resignFirstResponder];
	[director resignFirstResponder];
	//[textField esignFirstResponder];	
}

-(IBAction)search:(id)sender {

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *pathGenres = [documentsDirectory stringByAppendingPathComponent:@"selectedGenres.plist"];
	NSString *pathPeriod = [documentsDirectory stringByAppendingPathComponent:@"selectedPeriod.plist"];
	self.genresFilterDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:pathGenres];
	self.selectedPeriod = [NSMutableDictionary dictionaryWithContentsOfFile:pathPeriod];

	[self dbQuery];
}

-(void)dbQuery {
	if (self.moviesListController == nil) {
		MoviesListController *aList = [[MoviesListController alloc] init];
		self.moviesListController = aList;
		[aList release];
	}
	moviesListController.query = [self createQuery];
	moviesListController.title = [NSString stringWithFormat:@"Search"];
	moviesListController.sender = [NSString stringWithFormat:@"Search"];
	[moviesListController getList];
	[moviesListController.table reloadData];
	MovieQuotesAppDelegate *delegate = (MovieQuotesAppDelegate *)[[UIApplication sharedApplication] delegate];
	[delegate.searchNavController pushViewController:moviesListController animated:YES];
	[moviesListController release];
	moviesListController = nil;
}

-(NSString *)createQuery {
	NSString *query = [NSString stringWithFormat:@"SELECT id, title FROM movies WHERE"];
	int i = 0;
	if ([movieTitle.text length] > 0) {
		query = [query stringByAppendingString:[NSString stringWithFormat:@" title LIKE '%%%@%%'", movieTitle.text]];
		i = 1;
	}
	if ([director.text length] > 0) {
		if (i == 1)
			query = [query stringByAppendingString:@" AND"];
		query = [query stringByAppendingString:[NSString stringWithFormat:@" director LIKE '%%%@%%'", director.text]];
		i = 1;
	}
	
	if ([actor.text length] > 0) {
		if (i == 1)
			query = [query stringByAppendingString:@" AND"];
		query = [query stringByAppendingString:[NSString stringWithFormat:@" actors LIKE '%%%@%%'", actor.text]];
		i = 1;
	}
	
	if (i == 1)
		query = [query stringByAppendingString:@" AND"];
	query = [query stringByAppendingString:@" ("];
    i = 0;

	for (id key in self.genresFilterDictionary) {
		if ([[self.genresFilterDictionary objectForKey:key] isEqualToString:@"TRUE"]) {
			if (i == 1)
				query = [query stringByAppendingString:@" OR"];
			query = [query stringByAppendingString:[NSString stringWithFormat:@" genre LIKE '%%%@%%'", key]];
			i = 1;
		}
	}
	query = [query stringByAppendingString:@" )"];
			 
	if (i == 1)
		query = [query stringByAppendingString:@" AND"];
	
	query = [query stringByAppendingString:[NSString stringWithFormat:@" year >= %d AND year <= %d", [[self.selectedPeriod objectForKey:@"From"]intValue],  [[self.selectedPeriod objectForKey:@"To"]intValue]]];
	return query;
}

@end
