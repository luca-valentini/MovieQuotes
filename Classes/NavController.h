//
//  MoviesNavController.h
//  MovieQuotes
//
//  Created by Luca on 1/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NavController : UINavigationController {
	UISegmentedControl *segmentedControl;
	UIBarButtonItem *rightBarButtonItem;
}
@property (nonatomic, retain) UIBarButtonItem *rightBarButtonItem;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;

@end
