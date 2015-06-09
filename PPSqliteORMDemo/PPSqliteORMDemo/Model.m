//
//  Model.m
//  PPSqliteORMDemo
//
//  Created by StarNet on 6/9/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "Model.h"

@implementation Model

//指定表名
PPSqliteORMAsignRegisterName(@"model");

//指定主键
PPSqliteORMAsignPrimaryKey(NSTimeIntervalType);

+ (instancetype)modelCreate {
    Model* model = [[Model alloc] init];
    model.NSTimeIntervalType = [NSDate timeIntervalSinceReferenceDate];
    model.NSIntergerType = arc4random()%1000;
    model.longType = arc4random()%100000;
    model.intType = arc4random()%1000;
    model.CGfloatType = 1.2*(arc4random()%100);
    model.charType = 'd';
    
    model.CGPointType = CGPointMake(model.intType, model.intType*2);
    model.CGRectType = CGRectMake(model.intType, model.intType*2, model.intType/2, model.intType);
    model.CGSizeType = CGSizeMake(model.intType/2, model.intType);
    
    model.NSStringType = [NSString stringWithFormat:@"Model%d", model.intType];
    model.NSDateType = [NSDate date];
    
    return model;
}

@end
