# PPSqliteORM

PPSqliteORM是对Sqlite数据库的对象化封装，减少SQL语句的操作，实现对象的写入和读取.

### 1. 前言
开发PPSqliteORM是源于公司的一个项目，需要用到大数据存储，经过评估之后，决定采用数据库存储方式，当然也就选择了Sqlite，而对于Sqlite而已，FMDB对它已经封装了一层，基于FMDB，你可以不用再去关心sqlite底层的接口，只要关系SQL语法层面的内容，那么我不直接使用FMDB，而是在FMDB的基础上又封装了一层呢，原因有如下几个:

* (1) 需要关注SQL语法
* (2) 扩展性差，比如当我新建一个类，我需要再写CREATE、DELETE、SELECT SQL语句来操作这个类

基于以上两点不足，于是我决定再封装一层，于是就有了PPSqliteORM.

### 2. 优势
相比于FMDB，PPSqliteORM有如下优势:

* 很少关注SQL语法
* 扩展性强
* 对象化操作

### 3. 支持数据类型
目前已经支持的数据类型有:整型(int,long,NSInteger...)、浮点(float, double)、布尔(BOOL)、字符串(NSString)、日期(NSDate)、字典(NSDictionary)、CGPoint、CGRect、CGSize、NSRange、CGVector、CGAffineTransform、UIEdgeInsets、UIOffset.


### 4. 如何配置
* 编译framework并导入到你的工程中
	<pre>
git clone https://github.com/smallmuou/PPSqliteORM
open PPSqliteORM.xcworkspace
利用xcode编译生成PPSqliteORM.framework，并导入到你的工程中
</pre>
![image](https://raw.githubusercontent.com/smallmuou/PPSqliteORM/master/snapshot-generate-framework.jpg)
* 导入sqlite动态库
![image](https://raw.githubusercontent.com/smallmuou/PPSqliteORM/master/snapshot-import-sqlite.jpg)
* 设置-ObjC
	<pre>
XCode -> Build Settings -> Other Linker Flags ，添加-ObjC
</pre>
![image](https://raw.githubusercontent.com/smallmuou/PPSqliteORM/master/snapshot-set-objc.jpg)
* 引入头文件
	<pre>
\#import < PPSqliteORM/PPSqliteORM.h>
</pre>

### 5. 如何使用
* 实现PPSqliteORMProtocol
	<pre>
//Model.h
@interface Model : NSObject < PPSqliteORMProtocol>
...
@end
</pre>

	<pre>
//Model.m
@implementation Model
//指定表名
PPSqliteORMAsignRegisterName(@"model");
//指定主键
PPSqliteORMAsignPrimaryKey(NSTimeIntervalType);
...
@end
</pre>

* 注册类
	<pre>
[[PPSqliteORMManager defaultManager] registerClass:[Model class] complete:nil];
</pre>
* 写入对象
	<pre>
[[PPSqliteORMManager defaultManager] writeObject:model complete:nil];
</pre>
* 读取对象
	<pre>
[[PPSqliteORMManager defaultManager] read:[Model class] condition:nil complete:^(BOOL successed, id result) {
	   if (successed) {
	   //读取成功
	   } else {
	   //读取失败
	   }
}];
</pre>
* 删除对象
	<pre>
[[PPSqliteORMManager defaultManager] delete:model complete:nil];
</pre>

* 更多操作
	<pre>
详见PPSqliteORMManager.h头文件
</pre>

### 6. 许可
该项目遵循MIT许可，详见LICENSE.

### 7. 联系
如果你在使用PPSqliteORM中遇到任何问题、或者有任何新的想法，都可以e-mail给我，我的e-mail: lvyexuwenfa100@126.com