//
//  RandomMovieController.h
//  MovieQuotes
//
//  Created by Luca on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieInfoController;

@interface RandomMovieController : UIViewController {
	MovieInfoController *movieInfoController;
	UIButton *randomButton;
}

@property (nonatomic, retain) MovieInfoController *movieInfoController;
- (IBAction)randomize:(id)sender;
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event;
@end
