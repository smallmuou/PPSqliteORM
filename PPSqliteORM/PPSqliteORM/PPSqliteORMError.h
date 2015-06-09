/**
 * PPSqliteORMError.h
 *
 * Provide the error information of PPSqliteORMManager interface.
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

#define PPSqliteORMDEF(__code, __description) __code

enum {
    PPSqliteORMDEF(PPSqliteORMRegisterFailed = -100,   @"Create database table failed."),
    PPSqliteORMDEF(PPSqliteORMTableNameEmpty,          @"Create database table failed."),
    PPSqliteORMDEF(PPSqliteORMUnregisterFailed,        @"Drop database table failed."),
    PPSqliteORMDEF(PPSqliteORMUsedWithoutRegister,     @"Didn't register the class."),
    PPSqliteORMDEF(PPSqliteORMWriteFailed,             @"Insert failed."),
    PPSqliteORMDEF(PPSqliteORMNotAssignPrimaryKey,     @"Not assign primary key."),
    PPSqliteORMDEF(PPSqliteORMDeleteFailed,            @"Delete failed."),

};

#define PPSqliteORMErrorMacro(__code) [PPSqliteORMError errorWithCode:__code]

@interface PPSqliteORMError : NSError

+ (id)errorWithCode:(NSInteger)code;

@end
