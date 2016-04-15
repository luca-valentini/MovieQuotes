//
//  AlphabetScrollViewController.m
//  MovieQuotes
//
//  Created by Luca on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AlphabetScrollViewController.h"
#import "MoviesListController.h"
#import "MovieQuotesAppDelegate.h"
#import "MovieInfoController.h"
#import "SqliteDelegate.h"

@implementation AlphabetScrollViewController
@synthesize scrollView;
@synthesize moviesListController;
@synthesize table;
@synthesize movieIds;
@synthesize listData;
@synthesize movieInfoController;
@synthesize query;



/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self createButtons];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (void)createButtons {
	for (int i = 0; i <= 25; i++)
    {
		self.title = @"Movies";
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[array release];
		CGRect rect = CGRectMake(i*30, 15, 25, 25);
		UIButton *btn = [[UIButton alloc] initWithFrame:rect];
		btn.tag = i;
		NSString *buttonTitle = [NSString stringWithFormat:@"%c", i+65];
		[btn addTarget:self action:@selector(frameClicked:) forControlEvents:UIControlEventTouchUpInside];
		[btn setTitle:buttonTitle forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[btn contentVerticalAlignment];
		btn.titleLabel.font = [UIFont fontWithName:@"Courier-Bold" size:18];
		[scrollView addSubview:btn];	
		[btn setShowsTouchWhenHighlighted:TRUE];
		[btn release];
	}
	
	CGRect rect = CGRectMake(26*30, 5, 25, 30);
	UIButton *btn = [[UIButton alloc] initWithFrame:rect];
	btn.tag = 26;
	NSString *buttonTitle = [NSString stringWithFormat:@"..."];
	[btn addTarget:self action:@selector(frameClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn setTitle:buttonTitle forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn setShowsTouchWhenHighlighted:TRUE];
	[scrollView addSubview:btn];	
	[btn release];
	[scrollView setContentSize:CGSizeMake(30*27, 30)];
	
}	


- (IBAction)frameClicked:(id)sender {
	NSString *buttonTitle = [NSString stringWithFormat:@"%@", [sender titleForState:UIControlStateNormal]];
	if ([buttonTitle isEqualToString:@"..."]) {
		buttonTitle = [NSString stringWithFormat:@"$"];
	} 
	self.query = [NSString stringWithFormat:@"SELECT id,title FROM movies WHERE firstLetter=\"%@\"", buttonTitle];

	[self getList];
}


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
	cell.detailTextLabel.text = [movieIds objectAtIndex:row];
	//cell.accessoryType = UITableViewCellAccessoryType
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.font = [UIFont fontWithName:@"Courier-Bold" size:16];
	cell.selectionStyle = UITableViewCellSelectionStyleGray;
	return cell;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSUInteger row = [indexPath row]; 

	NSString *movie = [movieIds objectAtIndex:row];
	if (self.movieInfoController == nil) {
		MovieInfoController *aMovieInfo = [[MovieInfoController alloc] init];
		self.movieInfoController = aMovieInfo;
		[aMovieInfo release];
	}
	movieInfoController.movieId =  [NSString stringWithFormat:@"%@", movie];
	[movieInfoController getMovieInfo];

	MovieQuotesAppDelegate *delegate = (MovieQuotesAppDelegate *)[[UIApplication sharedApplication] delegate];

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	[delegate.alphabetNavController pushViewController:movieInfoController animated:YES];
}


- (void)getList {
	SqliteDelegate *dbConnector = [[SqliteDelegate alloc]init];
	NSMutableArray *result = [dbConnector dbQuery:query columns:2];
	self.movieIds = [result objectAtIndex:0];
	self.listData = [result objectAtIndex:1];
	[dbConnector release];
	[table reloadData];
}

@end
