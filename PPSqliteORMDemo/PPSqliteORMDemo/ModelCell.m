//
//  ModelCell.m
//  PPSqliteORMDemo
//
//  Created by StarNet on 6/9/15.
//  Copyright (c) 2015 StarNet. All rights reserved.
//

#import "ModelCell.h"

@implementation ModelCell

- (void)awakeFromNib {
    // Initialization code
    
    NSArray* array = @[self.NSIntergerTypeLabel, self.CGfloatTypeLabel, self.intTypeLabel, self.charTypeLabel, self.longTypeLabel, self.CGPointTypeLabel, self.CGRectTypeLabel, self.CGSizeTypeLabel, self.NSStringTypeLabel, self.NSDateTypeLabel];
    for (UIView* view in array) {
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Model *)model {
    self.NSTimeIntervalTypeLabel.text = [NSString stringWithFormat:@"NSTimeIntervalType: %f", model.NSTimeIntervalType];
    self.NSIntergerTypeLabel.text = [NSString stringWithFormat:@"NSIntergerType: %ld", model.NSIntergerType];
    self.CGfloatTypeLabel.text = [NSString stringWithFormat:@"CGFloatType: %f", model.CGfloatType];
    self.charTypeLabel.text = [NSString stringWithFormat:@"charType: %c", model.charType];
    self.intTypeLabel.text = [NSString stringWithFormat:@"intType: %d", model.intType];
    self.longTypeLabel.text = [NSString stringWithFormat:@"longType: %ld", model.longType];
    
    self.CGPointTypeLabel.text = [NSString stringWithFormat:@"CGPointType: %@", NSStringFromCGPoint(model.CGPointType)];
    self.CGRectTypeLabel.text = [NSString stringWithFormat:@"CGRectType: %@", NSStringFromCGRect(model.CGRectType)];
    self.CGSizeTypeLabel.text = [NSString stringWithFormat:@"CGSizeType: %@", NSStringFromCGSize(model.CGSizeType)];
    
    self.NSStringTypeLabel.text = [NSString stringWithFormat:@"NSStringType: %@", model.NSStringType];
    self.NSDateTypeLabel.text = [NSString stringWithFormat:@"NSDateType: %@", model.NSDateType];
}


@end
