//
//  ViewController.m
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@end

@implementation ViewController
@synthesize dataDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [[dataManager sharedManager] retrieveDataWithCompletion:^(dataModel *info, NSError *error) {
//        _cityLabel.text = [NSString stringWithFormat:@"%@", info.cityNames];
//    }];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_startDate setInputView:datePicker];

    UIDatePicker *datePicker2 = [[UIDatePicker alloc]init];
    [datePicker2 setDate:[NSDate date]];
    datePicker2.datePickerMode = UIDatePickerModeDate;
    [datePicker2 addTarget:self action:@selector(dateTextField2:) forControlEvents:UIControlEventValueChanged];
    [_endDate setInputView:datePicker2];

    [self.tagsTextField setDelegate:self];

    [[AMTagView appearance] setTagLength:10];
    [[AMTagView appearance] setTextPadding:14];
    [[AMTagView appearance] setTextFont:[UIFont fontWithName:@"Futura" size:14]];
    [[AMTagView appearance] setTagColor:UIColorFromRGB(0x1f9dd6)];

    [[AMTagView appearance] setAccessoryImage:[UIImage imageNamed:@"close"]];

}

- (void)addTag:(id)sender {
    
    [self.tagListView addTag:_tagsTextField.text];
    
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [app.tagsMutableArray addObject:_tagsTextField.text ];
    
    tagsString = [app.tagsMutableArray componentsJoinedByString:@", "];
    
    NSLog(@"tags are: %@", tagsString);
    
    [self.tagsTextField setText:@""];
}


- (void)dateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)_startDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _startDate.text = [NSString stringWithFormat:@"%@", dateString];
}

- (void)dateTextField2:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)_endDate.inputView;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _endDate.text = [NSString stringWithFormat:@"%@", dateString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)submit:(id)sender {
    
    NSString *startDateString = _startDate.text;
    NSString *endDateString = _endDate.text;
    NSString *destinationString = _destination.text;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters;
    
    AppDelegate *app =  (AppDelegate*)[[UIApplication sharedApplication] delegate];

    parameters = @{@"startDate": startDateString, @"endDate": endDateString, @"destination": destinationString, @"tags": app.tagsMutableArray};
    
    [manager POST:@"http://postcatcher.in/catchers/54f23965db21ee0300004bd7" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_startDate resignFirstResponder];
    [_endDate resignFirstResponder];
    [_destination resignFirstResponder];
    [_tagsTextField resignFirstResponder];

}

@end
