//
//  PeriodPickerController.m
//  MovieQuotes
//
//  Created by Luca on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PeriodPickerController.h"
#import "SearchController.h"

@implementation PeriodPickerController
@synthesize doublePicker;
@synthesize fromYears;
@synthesize toYears;
@synthesize selectedPeriod;
@synthesize sender;

-(IBAction)buttonPressed
{
	NSInteger fromRow = [doublePicker selectedRowInComponent:kFromComponent];
	NSInteger toRow = [doublePicker selectedRowInComponent:kToComponent];
	NSString *from = [fromYears objectAtIndex:fromRow];
	NSString *to = [toYears objectAtIndex:toRow]; 
	[selectedPeriod setValue:from forKey:@"From"];
	[selectedPeriod setValue:to forKey:@"To"];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selectedPeriod.plist"];
	[self.selectedPeriod writeToFile:path atomically:YES];
//	[from release];
//	[to release];
}



- (void)viewDidLoad {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"selectedPeriod.plist"];
	
	if ( [[NSFileManager defaultManager] fileExistsAtPath:path]) {
		self.selectedPeriod = [NSMutableDictionary dictionaryWithContentsOfFile:path];
	}
	else {
		[selectedPeriod setValue:@"1900" forKey:@"From"];
		[selectedPeriod setValue:@"2010" forKey:@"To"];
		[self.selectedPeriod writeToFile:path atomically:YES];
	}
	
	int fromRow = [[selectedPeriod objectForKey:@"From"]intValue] - 1900;
	int toRow = ([[selectedPeriod objectForKey:@"To"]intValue] - 2010) * (-1);
	
    NSMutableArray *fromYearsArray = [[NSMutableArray alloc] init];
	NSMutableArray *toYearsArray = [[NSMutableArray alloc] init];
	
	for (int i = 2010; i > 1899; i--) {
		NSString *fromYear = [NSString stringWithFormat:@"%i", i];
		[fromYearsArray addObject:fromYear];
		NSString *toYear = [NSString stringWithFormat:@"%i", i];
		[toYearsArray addObject:toYear];
	}
	[fromYearsArray sortUsingSelector:@selector(compare:)];
	self.fromYears = fromYearsArray;
	self.toYears = toYearsArray;
	[doublePicker selectRow:toRow inComponent:kToComponent animated:NO];
	[doublePicker selectRow:fromRow inComponent:kFromComponent animated:NO];
	[super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.fromYears = nil;
	self.toYears = nil;
	self.doublePicker = nil;
}


- (void)dealloc {
	[fromYears release];
	[toYears release];
	[doublePicker release];
    [super dealloc];
}


#pragma mark - #pragma mark Picker Data Source Methods 

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 2;
} 

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component { 
	
	if (component == kFromComponent)
	  return [self.fromYears count]; 
	
	return [self.toYears count];
}

#pragma mark Picker Delegate Methods 
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component { 
	if (component == kToComponent)
		return [self.toYears objectAtIndex:row];
	return [self.fromYears objectAtIndex:row];
}
@end
