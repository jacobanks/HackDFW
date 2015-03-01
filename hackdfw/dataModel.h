//
//  dataModel.h
//  
//
//  Created by Jacob Banks on 2/28/15.
//
//

#import "JSONModel.h"

@interface dataModel : JSONModel

@property (nonatomic, strong) NSString *cityFrom;
@property (nonatomic, strong) NSString *cityTo;
@property (nonatomic, strong) NSString *destination;

@end
