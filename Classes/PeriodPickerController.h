//
//  PeriodPickerController.h
//  MovieQuotes
//
//  Created by Luca on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kFromComponent 0 
#define kToComponent 1

@class SearchController;
@interface PeriodPickerController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {

	UIPickerView *doublePicker;
	NSArray *fromYears;
	NSArray *toYears;
	NSMutableDictionary *selectedPeriod;
	SearchController *sender;

}

@property (nonatomic, retain) IBOutlet UIPickerView *doublePicker;
@property (nonatomic, retain) IBOutlet NSArray *fromYears;
@property (nonatomic, retain) IBOutlet NSArray *toYears;
@property (nonatomic, retain) NSMutableDictionary *selectedPeriod;
@property (nonatomic, retain) SearchController *sender;

-(IBAction)buttonPressed;
@end
