//
//  JJstatusCell.m
//  嵩山野行
//
//  Created by TianJJ on 16/2/19.
//  Copyright © 2016年 TianJJ. All rights reserved.
//

#import "JJstatusCell.h"
#import "JJStatus.h"

@interface JJstatusCell ()

@property (weak, nonatomic) IBOutlet UIImageView *shareImage;
@property (weak, nonatomic) IBOutlet UILabel *shareTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareLongitude;
@property (weak, nonatomic) IBOutlet UILabel *shareLatitude;
@property (weak, nonatomic) IBOutlet UILabel *shareAltitude;

@end

@implementation JJstatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//获取cell实例
+ (JJstatusCell*)cellWithTableView:(UITableView*)tableView {
    
    static NSString *ID = @"statusCell";
    
    JJstatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"JJstatusCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

//设置cell数据
- (void)setStatus:(JJStatus *)status {
    
    _status = status;
    if (_status.shareImage.length==0) {
        self.shareImage.image = [UIImage imageNamed:@"img_01"];
    }else{
     self.shareImage.image = [UIImage imageNamed:_status.shareImage];
    }
   
    self.shareTimeLabel.text = _status.shareTime;
    self.shareLocationLabel.text = _status.shareLocation;
    self.shareLongitude.text = [NSString stringWithFormat:@"经度：%@",_status.shareLongitude];
    self.shareLatitude.text = [NSString stringWithFormat:@"纬度：%@",_status.shareLatitude];
    self.shareAltitude.text = [NSString stringWithFormat:@"高度：%@",_status.shareAltitude];
}

@end
