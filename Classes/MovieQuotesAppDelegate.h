//
//  MovieQuotesAppDelegate.h
//  MovieQuotes
//
//  Created by Luca on 1/19/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavController.h"

@class NavController;

@interface MovieQuotesAppDelegate : UITabBarController <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	NavController *genresNavController;	
	NavController *searchNavController;	
	NavController *randomNavController;
	NavController *alphabetNavController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet NavController *genresNavController;
@property (nonatomic, retain) IBOutlet NavController *alphabetNavController;
@property (nonatomic, retain) IBOutlet NavController *searchNavController;
@property (nonatomic, retain) IBOutlet NavController *randomNavController;
@end
