/**
 * PPSqliteORMSQL.h
 *
 * Provide the sql statement.
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

@interface PPSqliteORMSQL : NSObject

+ (NSString* )sqlForQueryAllTables;
+ (NSString* )sqlForTableInfo:(NSString* )tableName;
+ (NSString* )sqlForCreateTable:(Class<PPSqliteORMProtocol>)clazz;
+ (NSArray* )sqlForAlter:(Class<PPSqliteORMProtocol>)clazz columnInfo:(NSDictionary* )columnInfo;
+ (NSString* )sqlForDropTable:(Class<PPSqliteORMProtocol>)clazz;
+ (NSString* )sqlForDropTableName:(NSString* )tableName;
+ (NSString* )sqlForInsert:(id<PPSqliteORMProtocol>)object;
+ (NSString* )sqlForCheck:(id<PPSqliteORMProtocol>)object;
+ (NSString* )sqlForUpdate:(id<PPSqliteORMProtocol>)object;
+ (NSString* )sqlForDelete:(id<PPSqliteORMProtocol>)object;
+ (NSString* )sqlForDeleteAll:(Class<PPSqliteORMProtocol>)clazz;
+ (NSString* )sqlForDelete:(Class<PPSqliteORMProtocol>)clazz where:(NSString* )condition;
+ (NSString* )sqlForQuery:(Class<PPSqliteORMProtocol>)clazz where:(NSString* )condition;
+ (NSString* )sqlForCount:(Class<PPSqliteORMProtocol>)clazz where:(NSString* )condition;

@end
