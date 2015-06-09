//
//  NSValue+SQL.m
//  PPSqliteORM
//
//  Created by StarNet on 6/9/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSValue+SQL.h"
#import "NSObject+PPSqliteORM.h"

@implementation NSValue (SQL)

- (NSString* )sqlValue {
    NSString* type = formateObjectType([self objCType]);
    
    if ([type isEqualToString:@"CGPoint"]) {
        return [NSStringFromCGPoint([self CGPointValue]) sqlValue];
    } else if ([type isEqualToString:@"CGSize"]) {
        return [NSStringFromCGSize([self CGSizeValue]) sqlValue];
    } else if ([type isEqualToString:@"CGRect"]) {
        return [NSStringFromCGRect([self CGRectValue]) sqlValue];
    } else if ([type isEqualToString:@"CGVector"]) {
        return [NSStringFromCGVector([self CGVectorValue]) sqlValue];
    } else if ([type isEqualToString:@"CGAffineTransform"]) {
        return [NSStringFromCGAffineTransform([self CGAffineTransformValue]) sqlValue];
    } else if ([type isEqualToString:@"UIEdgeInsets"]) {
        return [NSStringFromUIEdgeInsets([self UIEdgeInsetsValue]) sqlValue];
    } else if ([type isEqualToString:@"UIOffset"]) {
        return [NSStringFromUIOffset([self UIOffsetValue]) sqlValue];
    } else if ([type isEqualToString:@"NSRange"]) {
        return [NSStringFromRange([self rangeValue]) sqlValue];
    }

    return nil;
}

+ (id)objectForSQL:(NSString* )sql objectType:(NSString* )type {
    if ([type isEqualToString:@"CGPoint"]) {
        return [NSValue valueWithCGPoint:CGPointFromString(sql)];
    } else if ([type isEqualToString:@"CGSize"]) {
        return [NSValue valueWithCGSize:CGSizeFromString(sql)];
    } else if ([type isEqualToString:@"CGRect"]) {
        return [NSValue valueWithCGRect:CGRectFromString(sql)];
    } else if ([type isEqualToString:@"CGVector"]) {
        return [NSValue valueWithCGVector:CGVectorFromString(sql)];
    } else if ([type isEqualToString:@"CGAffineTransform"]) {
        return [NSValue valueWithCGAffineTransform:CGAffineTransformFromString(sql)];
    } else if ([type isEqualToString:@"UIEdgeInsets"]) {
        return [NSValue valueWithUIEdgeInsets:UIEdgeInsetsFromString(sql)];
    } else if ([type isEqualToString:@"UIOffset"]) {
        return [NSValue valueWithUIOffset:UIOffsetFromString(sql)];
    } else if ([type isEqualToString:@"NSRange"]) {
        return [NSValue valueWithRange:NSRangeFromString(sql)];
    }
    return nil;
}

@end
