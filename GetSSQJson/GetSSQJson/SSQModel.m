//
//  SSQModel.m
//  GetSSQJson
//
//  Created by 轩辕 on 2019/4/18.
//  Copyright © 2019 轩辕. All rights reserved.
//

#import "SSQModel.h"
#import <YYModel.h>

@implementation SSQModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{
             @"numbers" : [NumberModel class],
             @"details" : [DetailModel class],
             };
}

- (NSString *)description { return [self yy_modelDescription]; }


@end
