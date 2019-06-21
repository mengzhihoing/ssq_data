//
//  ViewController.m
//  GetSSQJson
//
//  Created by 轩辕 on 2019/4/18.
//  Copyright © 2019 轩辕. All rights reserved.
//

#import "ViewController.h"
#import "HttpTool.h"
#import "SSQModel.h"
#import <YYModel.h>

@interface ViewController () {
    int from;
    int count;
    BOOL isFinished;
    NSMutableArray *tmp;
}

@property (nonatomic,strong)   NSMutableArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
     
     http://api.huoxingcp.com/ssq/searchDrawnDatas_ltServer.action?clientType=2&count=30&start=120&versionId=1
     
     */

    from = 0;
    count = 30;
    isFinished = NO;
    tmp = [NSMutableArray new];

//    [self start];
    
//    return;

    NSString *path = @"/Users/xuanyuan/Desktop/all.plist";
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"=%@", arr);

//    NSString *cc = @"[";

    _dataArr = [NSMutableArray new];
    
    
    for (NSDictionary *dic in arr) {
        SSQModel *model = [SSQModel yy_modelWithJSON:dic];

        NSString *red1;
        NSString *red2;
        NSString *red3;
        NSString *red4;
        NSString *red5;
        NSString *red6;
        NSString *blue;

        for (NumberModel *md in model.numbers) {
            NSString *num = [self getNumber:md];
            BOOL isRed = [self isRed:md];

            if (isRed == YES) {
                if (!red1) {
                    red1 = num;
                } else if (!red2) {
                    red2 = num;
                } else if (!red3) {
                    red3 = num;
                } else if (!red4) {
                    red4 = num;
                } else if (!red5) {
                    red5 = num;
                }else if (!red6) {
                    red6 = num;
                }

            } else {
                blue = num;
            }
        }
        
        
        NSString *lv1Count;
        NSString *lv2Count;
        NSString *lv3Count;
        NSString *lv4Count;
        NSString *lv5Count;
        NSString *lv6Count;
        
        NSString *lv1Amount;
        NSString *lv2Amount;
        NSString *lv3Amount;
        NSString *lv4Amount;
        NSString *lv5Amount;
        NSString *lv6Amount;
        
        for (DetailModel *md in model.details) {
            NSString *level = [self getLevel:md];
            NSString *cc = md.count;
            NSString *amount = md.amount;
            
            if ([level isEqualToString:@"1"]) {
                lv1Count = cc;
                lv1Amount = amount;
            }else  if ([level isEqualToString:@"2"]) {
                lv2Count = cc;
                lv2Amount = amount;
            }else  if ([level isEqualToString:@"3"]) {
                lv3Count = cc;
                lv3Amount = amount;
            }else  if ([level isEqualToString:@"4"]) {
                lv4Count = cc;
                lv4Amount = amount;
            }else  if ([level isEqualToString:@"5"]) {
                lv5Count = cc;
                lv5Amount = amount;
            }else  if ([level isEqualToString:@"6"]) {
                lv6Count = cc;
                lv6Amount = amount;
            }
        }
        
        NSString *red = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@",red1,red2,red3,red4,red5,red6];
        
        model.red = red;
        model.blue = blue;
        model.l1Count =  lv1Count;
        model.l1Amount = lv1Amount;
        model.l2Count =  lv2Count;
        model.l2Amount = lv2Amount;
        model.l3Count =  lv3Count;
        model.l3Amount = lv3Amount;
        model.l4Count =  lv4Count;
        model.l4Amount = lv4Amount;
        model.l5Count =  lv5Count;
        model.l5Amount = lv5Amount;
        model.l6Count =  lv6Count;
        model.l6Amount = lv6Amount;
        

        [self.dataArr addObject:model];

//        NSString *json = [NSString stringWithFormat:@"{ \"seriaNO\": %@,\n \"date\": \"%@\",\n  \"pool\": %@\n,\"sales\": %@\n, \"red1\": %@\n, \"red2\": %@\n,\"red3\": %@\n,\"red4\": %@\n, \"red5\": %@\n, \"blue\": %@\n, \"level1Count\": %@\n,\"level2Count\": %@\n,\"level3Count\": %@\n,\"level4Count\": %@\n,\"level5Count\": %@\n, \"level6Count\": %@\n, \"level1Amount\": %@\n,\"level2Amount\": %@\n, \"level3Amount\": %@\n,\"level4Amount\": %@\n,\"level5Amount\": %@\n,\"level6Amount\": %@\n },", model.issue, model.date, model.pool, model.sales, red1, red2, red3, red4, red5, blue ,lv1Count,lv2Count,lv3Count,lv4Count,lv5Count,lv6Count,lv1Amount,lv2Amount,lv3Amount,lv4Amount,lv5Amount,lv6Amount];
//
//
//        cc = [NSString stringWithFormat:@"%@ %@",cc,json];
        
    }
    
    [self goHttp];
    
//    NSString *cccc = @"/Users/xuanyuan/Desktop/cc.txt";
//
//    [cc writeToFile:cccc  atomically:YES];
}

- (void)goHttp {
    
    static int index = 0;
    
    if (index == self.dataArr.count) {
        NSLog(@"all finished");
        return;
    }
    
    SSQModel *model = self.dataArr[index];
    
    NSString *l1Count = @"";
    NSString *l1Amount = @"";
    NSString *l2Count = @"";
    NSString *l2Amount = @"";
    NSString *l3Count = @"";
    NSString *l3Amount = @"";
    NSString *l4Count = @"";
    NSString *l4Amount = @"";
    NSString *l5Count = @"";
    NSString *l5Amount = @"";
    NSString *l6Count = @"";
    NSString *l6Amount = @"";
    
    if (model.details.count) {
        
        l1Count = model.l1Count;
        l1Amount = model.l1Amount;
        l2Count =  model.l2Count;
        l2Amount = model.l2Amount;
        l3Count =  model.l3Count;
        l3Amount = model.l3Amount;
        l4Count =  model.l4Count;
        l4Amount = model.l4Amount;
        l5Count =  model.l5Count;
        l5Amount = model.l5Amount;
        l6Count =  model.l6Count;
        l6Amount = model.l6Amount;
        
    }
    
    
    NSDictionary *dic = @{
                          @"serialNo": model.issue,
                          @"date": model.date,
                          @"pool": model.pool,
                          @"sales": model.sales,
                          @"red": model.red,
                          @"blue": model.blue,
                          @"l1Count": l1Count,
                          @"l1Amount": l1Amount,
                          @"l2Count":l2Count,
                          @"l2Amount": l2Amount,
                          @"l3Count":l3Count,
                          @"l3Amount": l3Amount,
                          @"l4Count": l4Count,
                          @"l4Amount": l4Amount,
                          @"l5Count": l5Count,
                          @"l5Amount": l5Amount,
                          @"l6Count": l6Count,
                          @"l6Amount": l6Amount,
                          };
     
    
     [HttpTool getWithUrl:@"http://localhost:8181/ssq/api/ssq/add" paras:dic success:^(id result) {
         NSLog(@"index=%d",index);
         [self goHttp];
    } failure:^(NSString *error) {
        NSLog(@"e=%@",error);
    }];
    
    
    
    index++;
    
    
    
}

- (NSString *)getLevel:(DetailModel *)model {
    return model.level;
}

- (NSString *)getNumber:(NumberModel *)model {
    return model.number;
}

- (BOOL)isRed:(NumberModel *)model {

    if ([model.color isEqualToString:@"Red"]) {
        return YES;
    }

    return NO;
}

- (void)start {

    if (isFinished==YES) {
        NSLog(@"over");
        return;
    }

//    NSMutableArray *mArr = [NSMutableArray new];
//    NSMutableArray *tmp = [NSMutableArray new];

    NSDictionary *dic = @{@"start": @(from),@"count": @(count),@"clientType": @"2",@"versionId": @"1"};

    [HttpTool getWithUrl:@"http://api.huoxingcp.com/ssq/searchDrawnDatas_ltServer.action" paras:dic success:^(id result) {

//        NSLog(@"res=%@",result);

        NSArray *arr = result[@"obj"];

        if (arr.count>0) {
            [tmp addObjectsFromArray:arr];

//            for (NSDictionary *dic in arr) {
//                SSQModel *model = [SSQModel yy_modelWithJSON:dic];
//                [mArr addObject:model];
//            }


            if (tmp.count>0) {
                NSString *path = @"/Users/xuanyuan/Desktop/all.plist";
                [tmp writeToFile:path atomically:YES];

            }else {
                isFinished = YES;
            }

            from += arr.count;

            [self start];

        }

    } failure:^(NSString *error) {
        NSLog(@"e=%@",error);
    }];

}

@end
