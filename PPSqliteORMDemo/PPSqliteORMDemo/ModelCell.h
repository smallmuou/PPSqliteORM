//
//  ModelCell.h
//  PPSqliteORMDemo
//
//  Created by StarNet on 6/9/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface ModelCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel* NSTimeIntervalTypeLabel;

@property (nonatomic, retain) IBOutlet UILabel* NSIntergerTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* CGfloatTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* intTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* charTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* longTypeLabel;

@property (nonatomic, retain) IBOutlet UILabel* CGPointTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* CGRectTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* CGSizeTypeLabel;

@property (nonatomic, retain) IBOutlet UILabel* NSStringTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel* NSDateTypeLabel;


@property (nonatomic, strong) Model* model;

@end
