//
//  ViewController.m
//  PPSqliteORMDemo
//
//  Created by StarNet on 6/9/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"
#import "ModelCell.h"
#import <Foundation/Foundation.h>

static NSString* kCellReuseIdentifier = @"kCellReuseIdentifier";

@interface ViewController () {
    NSMutableArray* _tableData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"数据库ORM";
    _tableData = [NSMutableArray array];
    
    //注册表
    [[PPSqliteORMManager defaultManager] registerClass:[Model class] complete:nil];
    
    
    //读取表
    [[PPSqliteORMManager defaultManager] read:[Model class] condition:nil complete:^(BOOL successed, id result) {
        //成功
        if (successed) {
            [_tableData addObjectsFromArray:(NSArray*)result];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"读取失败！！！");
        }
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ModelCell" bundle:nil] forCellReuseIdentifier:kCellReuseIdentifier];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(onTrashAction)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddAction)];
}

- (NSString* )code {
    NSDate* date = [NSDate date];
    NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyyMMddhhmmss";
    return [fmt stringFromDate:date];
}

- (void)onTrashAction {
    [[PPSqliteORMManager defaultManager] deleteAllObjects:[Model class] complete:^(BOOL successed, id result) {
        if (successed) {
            [_tableData removeAllObjects];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"清空失败！！！！");
        }
    }];
}

- (void)onAddAction {
    Model* model = [Model modelCreate];
    
    [_tableData addObject:model];
    [[PPSqliteORMManager defaultManager] writeObject:model complete:nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ModelCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifier];
    
    cell.model = _tableData[indexPath.row];
    
    return cell;
}

@end
