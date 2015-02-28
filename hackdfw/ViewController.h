//
//  ViewController.h
//  hackdfw
//
//  Created by Jacob Banks on 2/28/15.
//  Copyright (c) 2015 Jacobanks development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataModel.h"
#import "dataManager.h"
#import "APIManager.h"

#define WEAK_SELF __typeof__(self) __weak weakSelf = self;

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *cityLabel;

@end

