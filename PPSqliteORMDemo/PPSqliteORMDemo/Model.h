//
//  Model.h
//  PPSqliteORMDemo
//
//  Created by StarNet on 6/9/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <PPSqliteORM/PPSqliteORM.h>


@interface Model : NSObject <PPSqliteORMProtocol>

@property (nonatomic, assign) NSTimeInterval NSTimeIntervalType;

@property (nonatomic, assign) NSInteger     NSIntergerType;
@property (nonatomic, assign) CGFloat       CGfloatType;
@property (nonatomic, assign) int           intType;
@property (nonatomic, assign) char          charType;
@property (nonatomic, assign) long          longType;

@property (nonatomic, assign) CGPoint       CGPointType;
@property (nonatomic, assign) CGRect        CGRectType;
@property (nonatomic, assign) CGSize        CGSizeType;

@property (nonatomic, strong) NSString*     NSStringType;
@property (nonatomic, strong) NSDate*       NSDateType;

+ (instancetype)modelCreate;

@end
