//
//  SearchController.h
//  MovieQuotes
//
//  Created by Luca on 3/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GenresFilterController;
@class MoviesListController;
@class PeriodPickerController;
#define kNumberOfEditableRows        4

@interface SearchController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {

	NSDictionary *names;
	NSArray *keys;
	GenresFilterController *genresFilterController;
	UITextField *textFieldBeingEdited;  
	NSMutableDictionary *tempValues;
	UITableView *tableViewOutlet;
	UITextField *movieTitle;
	UITextField *actor;
	UITextField *director;
	UITextField *genres;
	UITextField *period;
	NSMutableArray *searchParameters;
	NSMutableDictionary *genresFilterDictionary;
	PeriodPickerController *periodPickerController;
	NSMutableDictionary *selectedPeriod;
	MoviesListController *moviesListController;
}

@property (nonatomic, retain) NSDictionary *names; 
@property (nonatomic, retain) NSArray *keys;
@property (nonatomic, retain) GenresFilterController *genresFilterController;
@property (nonatomic, retain) UITextField *textFieldBeingEdited;
@property (nonatomic, retain) NSMutableDictionary *tempValues;
@property (nonatomic, retain) UITableView *tableViewOutlet;
@property (nonatomic, retain) UITextField *movieTitle;
@property (nonatomic, retain) UITextField *actor;
@property (nonatomic, retain) UITextField *director;
@property (nonatomic, retain) UITextField *genres;
@property (nonatomic, retain) UITextField *period;
@property (nonatomic, retain) NSMutableArray *searchParameters;
@property (nonatomic, retain) NSMutableDictionary *genresFilterDictionary;
@property (nonatomic, retain) PeriodPickerController *periodPickerController;
@property (nonatomic, retain) NSMutableDictionary *selectedPeriod;
@property (nonatomic, retain) MoviesListController *moviesListController;
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)textFieldDone:(id)sender;
- (IBAction)search:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (void)dbQuery;
- (NSString *)createQuery;
@end
