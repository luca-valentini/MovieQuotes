//
//  MovieInfoController.m
//  MovieQuotes
//
//  Created by Luca on 1/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MovieInfoController.h"
#import "SqliteDelegate.h"
#import "NavController.h"

@implementation MovieInfoController

@synthesize rowValue;
@synthesize movieTitle;
@synthesize actors;
@synthesize director;
@synthesize genre;
@synthesize year;
@synthesize movieId;
@synthesize navController;
@synthesize quotes;
@synthesize quoteLabel;
@synthesize quotesCounter;
@synthesize prevButton;
@synthesize nextButton;
@synthesize gestureStartPoint;
@synthesize quoteView;

- (void)getMovieInfo {
	SqliteDelegate *dbConnector = [[SqliteDelegate alloc]init];
	
	NSString *query;
	if (movieId == NULL) {
		query = [NSString stringWithFormat:@"SELECT title, director, actors, genre, year, id FROM movies ORDER BY Random() LIMIT 1"];
	}
	else {
		query = [NSString stringWithFormat:@"SELECT title, director, actors, genre, year, id FROM movies WHERE id=\"%@\"", movieId];
	}
	NSMutableArray *queryResult = [dbConnector dbQuery:query columns:6];
	year.text = [[queryResult objectAtIndex:4]objectAtIndex:0];

	director.text = [[queryResult objectAtIndex:1]objectAtIndex:0];

	movieTitle.text = [[queryResult objectAtIndex:0] objectAtIndex:0];
	movieId = [[queryResult objectAtIndex:5] objectAtIndex:0];
	
	NSMutableString *genresString = [NSMutableString stringWithString:[[[queryResult objectAtIndex:3]objectAtIndex:0] stringByReplacingOccurrencesOfString:@";" withString:@", "]];
	NSMutableString *actorsString = [NSMutableString stringWithString:[[[queryResult objectAtIndex:2]objectAtIndex:0] stringByReplacingOccurrencesOfString:@";" withString:@", "]];
	NSMutableString *directorsString = [NSMutableString stringWithString:[[[queryResult objectAtIndex:1]objectAtIndex:0] stringByReplacingOccurrencesOfString:@";" withString:@", "]];
	if ([directorsString length] > 2) {
	[directorsString replaceCharactersInRange:NSMakeRange([directorsString length]-2, 2) withString:@"."];
	}
	else {
		directorsString = [NSMutableString stringWithString:@"Unknown."];
	}
	
	if ([genresString length] > 2) {
		[genresString replaceCharactersInRange:NSMakeRange([genresString length]-2, 2) withString:@"."];
	}
	else {
		genresString = [NSMutableString stringWithString:@"Unknown."];
	}
	
	if ([actorsString length] > 2) {
		[actorsString replaceCharactersInRange:NSMakeRange([actorsString length]-2, 2) withString:@"."];
	}
	else {
		actorsString = [NSMutableString stringWithString:@"Unknown."];
	}
	
	genresString = [NSString stringWithFormat:@"Genres: %@", genresString];		
	actorsString = [NSString stringWithFormat:@"Actors: %@", actorsString];	
	directorsString = [NSString stringWithFormat:@"Directors: %@", directorsString];	
	genre.text = genresString;
	actors.text = actorsString;
	director.text = directorsString;
	[dbConnector release];
	[self getQuotes];
}

- (void)viewDidLoad {
	director.hidden = FALSE;
	genre.hidden = FALSE;
	actors.hidden = FALSE;
	quoteLabel.hidden = TRUE;
	nextButton.hidden = TRUE;
	prevButton.hidden = TRUE;
	year.hidden = FALSE;
	quotesCounter.hidden = TRUE;
	quoteView.hidden = TRUE;
	[quoteView addSubview:quoteLabel];
	[prevButton setShowsTouchWhenHighlighted:TRUE];
	[nextButton setShowsTouchWhenHighlighted:TRUE];
    [super viewDidLoad];
	NSArray *itemArray = [NSArray arrayWithObjects: @"Info", @"Quotes", nil];
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
	segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	segmentedControl.selectedSegmentIndex = 0;
	self.navigationItem.titleView = segmentedControl;
	[segmentedControl addTarget:self
						 action:@selector(toggleControls:)
			   forControlEvents:UIControlEventValueChanged];
	quoteLabel.font = [UIFont fontWithName:@"Courier-Bold" size:18];
	quoteLabel.textColor = [UIColor whiteColor];
	[self getMovieInfo];
//	[self getQuotes];
}



- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {

}


- (void)dealloc {
    [super dealloc];
}


- (void)getQuotes 
{
	NSString *query = [NSString stringWithFormat:@"SELECT quote FROM quotes WHERE movie=\"%@\"", movieId];
	SqliteDelegate *dbConnector = [[SqliteDelegate alloc]init];
	NSMutableArray *queryResult = [dbConnector dbQuery:query columns:1];
	
	self.quotes = [queryResult objectAtIndex:0];
	
	totalQuotesNumber = [quotes count];
	quoteNumber = 0;
	NSMutableArray *parsedQuotesArray = [[NSMutableArray alloc]init];
	
	for (int i = 0; i < totalQuotesNumber; i++) {
		NSMutableString *parsedQuote = [NSMutableString stringWithString:[[[quotes objectAtIndex:i] stringByReplacingOccurrencesOfString:@"#" withString:@""]  stringByReplacingOccurrencesOfString:@"@" withString:@""]];
		[parsedQuotesArray addObject:parsedQuote];					
	}
	
	self.quoteLabel.text = [parsedQuotesArray objectAtIndex:0];
	[quotes release];
	quotes = parsedQuotesArray;
	[self createCounterString];
	//[queryResult release];
	[dbConnector release];
}


- (IBAction)prevQuote:(id)sender {
	quoteNumber--;
	if (quoteNumber < 0) {
		quoteNumber += totalQuotesNumber;
	}
	self.quoteLabel.text = [quotes objectAtIndex:quoteNumber];
	[self createCounterString];
}

- (IBAction)nextQuote:(id)sender {	
	quoteNumber++;
	quoteNumber = quoteNumber%totalQuotesNumber;
	self.quoteLabel.text = [quotes objectAtIndex:quoteNumber];
	[self createCounterString];
}

-(void)createCounterString {
	quotesCounter.text = [NSString stringWithFormat:@"%i/%i", quoteNumber+1, totalQuotesNumber];
}

- (IBAction)toggleControls:(id)sender {
	if ([sender selectedSegmentIndex] == 1)
	{
		director.hidden = TRUE;
		genre.hidden = TRUE;
		actors.hidden = TRUE;
		quoteLabel.hidden = FALSE;
		nextButton.hidden = FALSE;
		prevButton.hidden = FALSE;
		quotesCounter.hidden = FALSE;
		quoteView.hidden = FALSE;
		year.hidden = TRUE;
	} 
	else 
	{
		director.hidden = FALSE;
		genre.hidden = FALSE;
		actors.hidden = FALSE;
		quoteLabel.hidden = TRUE;
		nextButton.hidden = TRUE;
		prevButton.hidden = TRUE;
		quotesCounter.hidden = TRUE;
		quoteView.hidden = TRUE;
		year.hidden = FALSE;
	}
}

#pragma mark -
#pragma mark -
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    gestureStartPoint = [touch locationInView:quoteView];
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPosition = [touch locationInView:quoteView];
    
//    CGFloat deltaX = fabsf(gestureStartPoint.x - currentPosition.x);
    CGFloat deltaX = (gestureStartPoint.x - currentPosition.x);
	if (deltaX < 0) {
		if (fabsf(deltaX) >= kMinimumGestureLength) {
			NSLog(@"Horizontal right swipe detected");
			[self prevQuote:self];
		}
	}
	else {
		if (deltaX >= kMinimumGestureLength) {
			NSLog(@"Horizontal left swipe detected");
			[self nextQuote:self];
		}
	}
	

	
      //  [self performSelector:@selector(eraseText)
          //         withObject:nil afterDelay:2];
}
@end
