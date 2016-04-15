//
//  RandomMovieController.m
//  MovieQuotes
//
//  Created by Luca on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "RandomMovieController.h"
#import "MovieInfoController.h"
#import "MovieQuotesAppDelegate.h"

@implementation RandomMovieController
@synthesize movieInfoController;

- (void)viewDidLoad {
    [self.view becomeFirstResponder];
	[super viewDidLoad];
}


- (IBAction)randomize:(id)sender {

	if (self.movieInfoController == nil) {
		MovieInfoController *aMovieInfo = [[MovieInfoController alloc] init];
		self.movieInfoController = aMovieInfo;
		[aMovieInfo release];
	} 
	movieInfoController.movieId =  NULL;
	[movieInfoController getMovieInfo];
	movieInfoController.title = [NSString stringWithFormat:@"Info"];
	
	MovieQuotesAppDelegate *delegate = (MovieQuotesAppDelegate *)[[UIApplication sharedApplication] delegate];

	movieInfoController.navController = delegate.randomNavController;
	[delegate.randomNavController pushViewController:movieInfoController animated:YES];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.type == UIEventSubtypeMotionShake) {
		NSLog(@"Shake");
		[self randomize:NULL];
	}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {
}


- (void)dealloc {
    [super dealloc];
}


@end
