//
//  MovieQuotesAppDelegate.m
//  MovieQuotes
//
//  Created by Luca on 1/19/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MovieQuotesAppDelegate.h"
#import "NavController.h"

@implementation MovieQuotesAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize genresNavController;
@synthesize alphabetNavController;
@synthesize searchNavController;
@synthesize randomNavController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[window addSubview:tabBarController.view];
}

- (void)dealloc {
    [tabBarController release];
	[genresNavController release];
	[randomNavController release];
	[alphabetNavController release];
    [window release];
    [super dealloc];
}

@end

