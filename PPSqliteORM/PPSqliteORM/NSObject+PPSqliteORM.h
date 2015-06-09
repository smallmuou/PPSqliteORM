/**
 * NSObject+PPSqliteORM.h
 *
 * Extension of NSObject for get necessary from model class.like tableName, primary key.
 *
 * MIT licence follows:
 *
 * Copyright (C) 2014 Wenva <lvyexuwenfa100@126.com>
 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is furnished
 * to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import "PPSqliteORMProtocol.h"

#define TYPEMAP(__rawType, __objcType, __sqliteType) \
__rawType:@[__objcType, __sqliteType]

#define kObjectCTypeToSqliteTypeMap \
@{\
    TYPEMAP(@"c",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"C",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"s",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"S",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"i",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"I",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"q",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"B",               @"NSNumber",        @"INTEGER"),\
    TYPEMAP(@"f",               @"NSNumber",        @"REAL"),\
    TYPEMAP(@"d",               @"NSNumber",        @"REAL"),\
    TYPEMAP(@"NSString",        @"NSString",        @"TEXT"),\
    TYPEMAP(@"NSMutableString", @"NSMutableString", @"TEXT"),\
    TYPEMAP(@"NSDate",          @"NSDate",          @"REAL"),\
    TYPEMAP(@"NSNumber",        @"NSNumber",        @"REAL"),\
    TYPEMAP(@"NSDictionary",    @"NSDictionary",    @"TEXT"),\
}

@interface NSObject (PPSqliteORM) <PPSqliteORMProtocol>

+ (NSString* )tableName;

/**
 * Return the Dictionary which contains all variable of this object.
 */
+ (NSDictionary* )variableMap;

/**
 * Return the Dictionary which contains all variableName and lowercase of variableName of this object.
 */
+ (NSDictionary* )lowercaseKeyMap;

/**
 * Convert object to string for SQL insert.
 */
- (NSString* )sqlValue;

/**
 * Convert SQL string to object.
 */
+ (id)objectForSQL:(NSString* )sql;

+ (id)objectFromSuperObject:(id)object;

@end
