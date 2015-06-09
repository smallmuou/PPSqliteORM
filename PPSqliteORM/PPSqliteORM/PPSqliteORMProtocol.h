/**
 * PPSqliteORMProtocol.h
 *
 * Provide the protocol for model class.
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

#define PPSqliteORMAsignPrimaryKey(__key) \
+ (NSString* )primaryKey { \
return @(#__key); \
}\
- (void)__hint {self.__key;}

#define PPSqliteORMAsignRegisterName(__name) \
+ (NSString* )registerName { \
return __name; \
}

#define CompileErrorBlocked \
+ (NSDictionary* )variableMap;\
+ (NSString* )tableName;\
+ (NSString* )primary;\
+ (instancetype)alloc;\
+ (NSDictionary* )lowercaseKeyMap;

/**
 * Model class need implement this protocol.The Model class should inherit NSObject.
 */

@protocol PPSqliteORMProtocol <NSObject>


@optional

/**
 * Assign the table name for the class, please use macro PPSqliteORMAsignRegisterName. if not assign, will use class name for instead.
 */
+ (NSString* )registerName;

/**
 * Assign the primary key for table, please use macro PPSqliteORMAsignPrimaryKey.
 */
+ (NSString* )primaryKey;


CompileErrorBlocked
@end
