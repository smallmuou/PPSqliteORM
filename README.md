# PPSqliteORM

PPSqliteORM是对Sqlite数据库的对象化操作，主要表现在对象的写入、对象的读取等.

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

### 3. 如何使用
* 编译framework并导入到你的工程中
	<pre>
git clone https://github.com/smallmuou/PPSqliteORM
open PPSqliteORM.xcworkspace
利用xcode编译生成PPSqliteORM.framework，并导入到你的工程中
</pre>
![image](http://)
* 导入sqlite动态库

* 设置-ObjC
	<pre>
	XCode -> Build Settings -> Other Linker Flags ，添加-ObjC
</pre>


### 4. 许可
该项目遵循MIT许可

### 5. 联系
如果你在使用PPSqliteORM中遇到任何问题、或者有任何新的想法，都可以e-mail给我，我的e-mail: lvyexuwenfa100@126.com