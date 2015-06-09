//
//  NSDictionary+SQL.m
//  PPSqliteORM
//
//  Created by StarNet on 12/22/14.
//  Copyright (c) 2014 StarNet. All rights reserved.
//

#import "NSDictionary+SQL.h"
#import "NSObject+PPSqliteORM.h"
#import "JSONKit.h"

@implementation NSDictionary (SQL)
- (NSString* )sqlValue {
    
    return [[self JSONString] sqlValue];
}

+ (id)objectForSQL:(NSString* )sql objectType:(NSString* )type {
    if (!sql) return nil;
    return [sql objectFromJSONString];
}
@end
