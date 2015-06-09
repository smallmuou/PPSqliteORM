/**
 * PPSqliteORMSQL.m
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

#import "PPSqliteORMSQL.h"
#import "NSObject+PPSqliteORM.h"

@implementation PPSqliteORMSQL

+ (NSString* )sqlForQueryAllTables {
    return [NSString stringWithFormat:@"SELECT name FROM sqlite_master WHERE type = 'table'"];
}

+ (NSString* )sqlForTableInfo:(NSString* )tableName {
    return [NSString stringWithFormat:@"PRAGMA table_info(%@)", tableName];
}

+ (NSString* )sqlForCreateTable:(Class<PPSqliteORMProtocol>)clazz {
    
    //Table Name
    NSString* tableName = [clazz tableName];
    NSString* primaryKey = [clazz primary];
    NSDictionary* typeMap = kObjectCTypeToSqliteTypeMap;
    
    //Attributes
    NSMutableString* columns = [NSMutableString string];
    BOOL beAssignPrimaryKey = YES;
    NSDictionary* map = [clazz variableMap];
    
    BOOL first = YES;
    for (NSString* key in map) {
        if (!typeMap[map[key]]) continue;
        
        if (!first) [columns appendString:@","];
        first = NO;
        
        NSString* sqlType = typeMap[map[key]][1];
        [columns appendFormat:@"%@ %@", key, sqlType];
        if (beAssignPrimaryKey && [primaryKey isEqualToString:key]) {
            [columns appendFormat:@" PRIMARY KEY"];
            beAssignPrimaryKey = NO;
        }
        
        //设置默认值
        if ([sqlType isEqualToString:@"INTEGER"]) {
            [columns appendFormat:@" DEFAULT 0"];
        } else if ([sqlType isEqualToString:@"REAL"]) {
            [columns appendFormat:@" DEFAULT 0.0"];
        }
    }

    return [NSString stringWithFormat:@"CREATE TABLE %@(%@)", tableName, columns];
}

+ (NSArray* )sqlForAlter:(Class<PPSqliteORMProtocol>)clazz columnInfo:(NSDictionary* )columnInfo {
    NSDictionary* map = [clazz variableMap];
    NSMutableArray* array = [NSMutableArray array];
    NSString* tableName = [clazz tableName];
    NSDictionary* typeMap = kObjectCTypeToSqliteTypeMap;
    
    for (NSString* key in [map allKeys]) {
        if (!typeMap[map[key]]) continue;

        if (!columnInfo[key]) {
            [array addObject:[NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", tableName, key, typeMap[map[key]][1]]];
        }
    }
    return [NSArray arrayWithArray:array];
}

+ (NSString* )sqlForDropTable:(Class<PPSqliteORMProtocol>)clazz {
    NSString* tableName = [clazz tableName];
    return [NSString stringWithFormat:@"DROP TABLE %@", tableName];
}

+ (NSString* )sqlForDropTableName:(NSString* )tableName {
    return [NSString stringWithFormat:@"DROP TABLE %@", tableName];
}

+ (NSString* )sqlForInsert:(id<PPSqliteORMProtocol>)object {
    NSString* tableName = [[object class] tableName];
    NSMutableString* columns = [NSMutableString string];
    NSMutableString* values = [NSMutableString string];
    NSDictionary* typeMap = kObjectCTypeToSqliteTypeMap;

    NSDictionary* map = [[object class] variableMap];
    BOOL first = YES;
    for (NSString* key in [map allKeys]) {
        if (!typeMap[map[key]]) continue;
        
        NSString* value = [[(NSObject*)object valueForKey:key] sqlValue];
        if (value) {
            if (!first) {
                [columns appendString:@","];
                [values appendString:@","];
            }
            first = NO;
                [columns appendString:key];
                [values appendString:value?value:@""];
            }
    }
    

    return [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)", tableName, columns, values];
}

+ (NSString* )sqlForCheck:(id<PPSqliteORMProtocol>)object {
    NSString* tableName = [[object class] tableName];
    NSString* primaryKey = [[object class] primaryKey];
    NSString* value = [[(NSObject*)object valueForKey:primaryKey] sqlValue];
    
    return [NSString stringWithFormat:@"SELECT 1 FROM %@ WHERE %@=%@", tableName, primaryKey, value];
}

+ (NSString* )sqlForUpdate:(id<PPSqliteORMProtocol>)object {
    NSString* tableName = [[object class] tableName];
    NSMutableString* updateString = [NSMutableString string];
    NSDictionary* typeMap = kObjectCTypeToSqliteTypeMap;
    NSString* primaryKey = [[object class] primaryKey];
    
    NSDictionary* map = [[object class] variableMap];
    BOOL first = YES;
    
    for (NSString* key in [map allKeys]) {
        if (!typeMap[map[key]]) continue;
        
        NSString* value = [[(NSObject*)object valueForKey:key] sqlValue];
        if (value) {
            if (!first) {
                [updateString appendString:@","];
            }
            first = NO;
            [updateString appendString:[NSString stringWithFormat:@"%@=%@", key, value]];
        }
    }

    return [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@=%@", tableName, updateString, primaryKey, [[(NSObject*)object valueForKey:primaryKey] sqlValue]];
}

+ (NSString* )sqlForDelete:(id<PPSqliteORMProtocol>)object {
    NSString* tableName = [[object class] tableName];
    NSString* primaryKey = [[object class] primary];

    return [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ = %@", tableName, primaryKey, [[(NSObject*)object valueForKey:primaryKey] sqlValue]];
}

+ (NSString* )sqlForDelete:(Class<PPSqliteORMProtocol>)clazz where:(NSString* )condition {
    if (!condition || [condition isEqualToString:@""]) {
        return [NSString stringWithFormat:@"DELETE FROM %@", [clazz tableName]];
    } else {
        return [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@", [clazz tableName], condition];
    }
}



+ (NSString* )sqlForDeleteAll:(Class<PPSqliteORMProtocol>)clazz {
    return [NSString stringWithFormat:@"DELETE FROM %@", [clazz tableName]];
}

+ (NSString* )sqlForQuery:(Class<PPSqliteORMProtocol>)clazz where:(NSString* )condition {
    if (!condition || [condition isEqualToString:@""]) {
        return [NSString stringWithFormat:@"SELECT * FROM %@", [clazz tableName]];
    } else {
        condition = [condition stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString* upper = [condition uppercaseString];
        if ([upper hasPrefix:@"ORDER BY"] || [upper hasPrefix:@"GROUP BY"]) {
            return [NSString stringWithFormat:@"SELECT * FROM %@ %@", [clazz tableName], condition];
        } else {
            return [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@", [clazz tableName], condition];
        }
    }
}

+ (NSString* )sqlForCount:(Class<PPSqliteORMProtocol>)clazz where:(NSString* )condition {
    if (!condition || [condition isEqualToString:@""]) {
        return [NSString stringWithFormat:@"SELECT count(1) FROM %@", [clazz tableName]];
    } else {
        return [NSString stringWithFormat:@"SELECT count(1) FROM %@ WHERE %@", [clazz tableName], condition];
    }
}

@end
