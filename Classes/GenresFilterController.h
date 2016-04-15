//
//  GenresFilterController.h
//  MovieQuotes
//
//  Created by Luca on 4/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class MoviesListController;

@interface GenresFilterController : UIViewController  <UITableViewDataSource, UITableViewDelegate> {
    NSArray *list;
    NSIndexPath  *lastIndexPath;
	NSMutableDictionary *selectedGenres;
}
@property (nonatomic, retain) NSIndexPath *lastIndexPath;
@property (nonatomic, retain) NSArray *list;
@property (nonatomic, retain) NSMutableDictionary *selectedGenres;
@end
