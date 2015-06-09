/**
 * NSObject+PPSqliteORM.m
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


#import "NSObject+PPSqliteORM.h"
#import <objc/runtime.h>

NSString* formateObjectType(const char* objcType) {
    if (!objcType || !strlen(objcType)) return nil;
    NSString* type = [NSString stringWithCString:objcType encoding:NSUTF8StringEncoding];
    
    switch (objcType[0]) {
        case '@':
            type = [type substringWithRange:NSMakeRange(2, strlen(objcType)-3)];
            break;
        case '{':
            type = [type substringWithRange:NSMakeRange(1, strchr(objcType, '=')-objcType-1)];
            break;
        default:
            break;
    }
    return type;
}

@implementation NSObject (PPSqliteORM)

+ (NSString* )tableName {
    NSString* tableName;
    if ([self respondsToSelector:@selector(registerName)]) {
        tableName = [[self class] registerName];
    } else {
        tableName = NSStringFromClass([self class]);
    }
    return tableName;
}

+ (NSString* )primary {
    NSString* primaryKey;
    if ([(NSObject*)[self class] respondsToSelector:@selector(primaryKey)]) {
        primaryKey = [[self class] primaryKey];
    }
    return primaryKey;
}

static NSMutableDictionary* variableMapCache;
+ (NSDictionary* )variableMap {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        variableMapCache = [NSMutableDictionary dictionary];
    });
    
    //先检查Cache
    NSString* key = NSStringFromClass([self class]);
    if (variableMapCache[key]) {
        return variableMapCache[key];
    }
    
    //没有则生成
    NSMutableDictionary* map = [NSMutableDictionary dictionary];
        
    unsigned int numIvars = 0;
    Class clazz = [self class];
    
    do {
        Ivar * ivars = class_copyIvarList(clazz, &numIvars);
        if (ivars) {
            for(int i = 0; i < numIvars; i++) {
                Ivar thisIvar = ivars[i];
                const char *type = ivar_getTypeEncoding(thisIvar);
                NSString* akey = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
                if ([akey hasPrefix:@"_"]) {
                    akey = [akey substringFromIndex:1];
                }
                
                map[akey] = formateObjectType(type);
            }
            free(ivars);
        }
        
        clazz = class_getSuperclass(clazz);
    } while(clazz && strcmp(object_getClassName(clazz), "NSObject"));
    
    NSDictionary* aMap = [NSDictionary dictionaryWithDictionary:map];
    variableMapCache[key] = aMap;
    return aMap;
}

static NSMutableDictionary* lowercaseKeyMapCache;
+ (NSDictionary* )lowercaseKeyMap {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        lowercaseKeyMapCache = [NSMutableDictionary dictionary];
    });
    
    //先检查Cache
    NSString* key = NSStringFromClass([self class]);
    if (lowercaseKeyMapCache[key]) {
        return lowercaseKeyMapCache[key];
    }

    //没有则生成
    NSMutableDictionary* map = [NSMutableDictionary dictionary];
    NSDictionary* varMap = [self variableMap];
    for (NSString* key in varMap) {
        map[[key lowercaseString]] = key;
    }
    
    NSDictionary* aMap = [NSDictionary dictionaryWithDictionary:map];
    lowercaseKeyMapCache[key] = aMap;
    return aMap;
}

- (NSString* )sqlValue {
    return nil;
}

+ (id)objectForSQL:(NSString* )sql objectType:(NSString* )type {
    return nil;
}

+ (id)objectFromSuperObject:(id)object {
    if ([[self class] isSubclassOfClass:[object class]]) {
        NSDictionary* map = [[object class] variableMap];
        
        id objout = [[self alloc] init];
        for (NSString* key in map) {
            id value = [object valueForKey:key];
            if (value) [objout setValue:value forKey:key];
        }
        return objout;
    }
    return nil;
}

@end
