//
//  SSQModel.h
//  GetSSQJson
//
//  Created by 轩辕 on 2019/4/18.
//  Copyright © 2019 轩辕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NumberModel.h"
#import "DetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSQModel : NSObject

@property (nonatomic,copy) NSString *issue;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) NSString *pool;
@property (nonatomic,copy) NSString *sales;
@property (nonatomic,copy) NSArray<NumberModel *> *numbers;
@property (nonatomic,copy) NSArray<DetailModel *> *details;


@property (nonatomic,copy) NSString *red;
@property (nonatomic,copy) NSString *blue;

@property (nonatomic,copy) NSString *l1Count;
@property (nonatomic,copy) NSString *l2Count;
@property (nonatomic,copy) NSString *l3Count;
@property (nonatomic,copy) NSString *l4Count;
@property (nonatomic,copy) NSString *l5Count;
@property (nonatomic,copy) NSString *l6Count;

@property (nonatomic,copy) NSString *l1Amount;
@property (nonatomic,copy) NSString *l2Amount;
@property (nonatomic,copy) NSString *l3Amount;
@property (nonatomic,copy) NSString *l4Amount;
@property (nonatomic,copy) NSString *l5Amount;
@property (nonatomic,copy) NSString *l6Amount;




@end

NS_ASSUME_NONNULL_END
