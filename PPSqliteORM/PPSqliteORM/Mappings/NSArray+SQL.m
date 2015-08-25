//
//  NSArray+SQL.m
//  PPSqliteORM
//
//  Created by StarNet on 8/25/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "NSArray+SQL.h"
#import "NSObject+PPSqliteORM.h"
#import "JSONKit.h"

@implementation NSArray (SQL)

- (NSString* )sqlValue {
    
    return [[self JSONString] sqlValue];
}

+ (id)objectForSQL:(NSString* )sql objectType:(NSString* )type {
    if (!sql) return nil;
    return [sql objectFromJSONString];
}

@end
