//
//  SearchController.h
//  MovieQuotes
//
//  Created by Luca on 1/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	NSMutableArray *listData;
	UITableView *table;
}
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *listData;
@end
