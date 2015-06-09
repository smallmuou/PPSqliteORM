/**
 * PPSqliteORMManager.h
 *
 * Provide the interfaces for user to operate database.
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

#ifdef DEBUG
#define __FILE_WITHOUT_PATH__ (strrchr(__FILE__, '/') ? strrchr(__FILE__, '/') + 1 : __FILE__)

#define PPSqliteORMDebug(fmt, ...) \
do {\
    NSLog(@"[%s:%d]: " fmt,\
     __FILE_WITHOUT_PATH__, __LINE__, ##__VA_ARGS__);\
} while(0);

#else
#define PPSqliteORMDebug(fmt, ...);
#endif

/**
 * Callback block, when successed = NO, result is PPSqliteORMError object.
 */
typedef void(^PPSqliteORMComplete)(BOOL successed, id result);

@interface PPSqliteORMManager : NSObject

/**
 * If you don't need to support multi-database file, you can use defaultManager.
 */
+ (id)defaultManager;

/**
 * If you need multi database file, please use this function.
 *
 * @param filename point out the database file name(without basepath).if filename=nil, means memory db.
 */
- (id)initWithDBFilename:(NSString* )filename;


/**
 * Register class to database.
 * 
 * @param clazz         The class will be registered
 * @param complete      Callback for complete
 */
- (void)registerClass:(Class <PPSqliteORMProtocol>)clazz complete:(PPSqliteORMComplete)complete;

/**
 * Unregister class from database.
 *
 * @param clazz         The class will be unregistered
 * @param complete      Callback for complete
 */
- (void)unregisterClass:(Class <PPSqliteORMProtocol>)clazz complete:(PPSqliteORMComplete)complete;

/**
 * Unregister all class from databse.
 *
 * @param complete      Callback for complete
 */
- (void)unregisterAllClass:(PPSqliteORMComplete)complete;

/**
 * Write the object to database.
 *
 * @param object        The object which will be writed to database
 * @param complete      Callback for complete
 */
- (void)writeObject:(id <PPSqliteORMProtocol>)object complete:(PPSqliteORMComplete)complete;

/**
 * Write the objects to database.
 *
 * @param objects       The array contain object which will be writed to database
 * @param complete      Callback for complete
 *
 * @Note The objects of array must be same belong to same class
 */
- (void)writeObjects:(NSArray* )objects complete:(PPSqliteORMComplete)complete;

/**
 * Delete object from databse.
 *
 * @param object         The object which will be delete from database
 * @param complete      Callback for complete
 */
- (void)deleteObject:(id <PPSqliteORMProtocol>)object complete:(PPSqliteORMComplete)complete;

/**
 * Delete objects from databse.
 *
 * @param objects         The array contain object which will be delete from database
 * @param complete      Callback for complete
 *
 * @Note The objects of array must be same belong to same class
 */
- (void)deleteObjects:(NSArray* )objects complete:(PPSqliteORMComplete)complete;

/**
 * Delete all objects off this class.
 *
 * @param clazz         The array contain object which will be delete from database
 * @param complete      Callback for complete
 */
- (void)deleteAllObjects:(Class <PPSqliteORMProtocol>)clazz complete:(PPSqliteORMComplete)complete;

/**
 * Read object from database.
 *
 * @param clazz         Assign the class
 * @param condition     SQL condition(like and, or, group by, order by, =, >, < and so)
 * @param complete      Callback for complete
                        result is the NSArray of object.
 */
- (void)read:(Class <PPSqliteORMProtocol>)clazz condition:(NSString* )condition complete:(PPSqliteORMComplete)complete;

/**
 * Read object from database.
 *
 * @param clazz         Assign the class
 * @param condition     SQL condition(like and, or, group by, order by, =, >, < and so)
 * @param complete      Callback for complete
 result is the NSArray of object.
 */
- (void)deleteObject:(Class <PPSqliteORMProtocol>)clazz condition:(NSString* )condition complete:(PPSqliteORMComplete)complete;



/**
 * Get the count of the clazz under the condition
 *
 * @param clazz         Assign the class
 * @param condition     SQL condition(like and, or, group by, order by, =, >, < and so)
 * @param complete      Callback for complete
 *                      result is NSNumber(int) of count
 */
- (void)count:(Class <PPSqliteORMProtocol>)clazz condition:(NSString* )condition complete:(PPSqliteORMComplete)complete;


/**
 * Check object is exist or not.
 *  
 * @param object The object for check
 * @param complete Callback for complete, successed=YES, mean exist, NO, means not exist.
 */
- (void)isExist:(id <PPSqliteORMProtocol>)object complete:(PPSqliteORMComplete)complete;

@end
