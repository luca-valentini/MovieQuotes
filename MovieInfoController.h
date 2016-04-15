//
//  MovieInfoController.h
//  MovieQuotes
//
//  Created by Luca on 1/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NavController;
@class TouchableView;
#define kMinimumGestureLength       50
#define kMaximumVariance            5

@interface MovieInfoController : UIViewController {
	UILabel *movieTitle;
	UILabel *actors;
	UILabel *director;
	UILabel *genre;
	UILabel *year;
	NSString *rowValue;
	NSString *movieId;
	UINavigationController *navController;
	int totalQuotesNumber;
	int quoteNumber;
	UILabel *quotesCounter;
	UIView *quoteView;
	UITextView *quoteLabel;
	NSMutableArray *quotes;
	UIButton *prevButton;
	UIButton *nextButton;
	CGPoint gestureStartPoint;
}

@property (nonatomic, retain) NSMutableArray *quotes;
@property (nonatomic, retain) IBOutlet UILabel *actors;
@property (nonatomic, retain) IBOutlet UILabel *movieTitle;
@property (nonatomic, retain) IBOutlet UILabel *director;
@property (nonatomic, retain) IBOutlet UILabel *genre;
@property (nonatomic, retain) IBOutlet UILabel *year;
@property (nonatomic, retain) IBOutlet UITextView *quoteLabel;
@property (nonatomic, retain) IBOutlet UIView *quoteView;
@property (nonatomic, retain) IBOutlet UILabel *quotesCounter;
@property (nonatomic, retain) IBOutlet UIButton *prevButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) NSString *rowValue;
@property (nonatomic, retain) NSString *movieId;
@property (nonatomic, retain) UINavigationController *navController;
@property CGPoint gestureStartPoint;

- (void)getMovieInfo;
- (void)getQuotes;
- (void)createCounterString;
- (IBAction)nextQuote:(id)sender;
- (IBAction)prevQuote:(id)sender;
- (IBAction)toggleControls:(id)sender;

@end
