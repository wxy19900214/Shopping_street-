//
//  ShowcollectionModel.h
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/23.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowcollectionModel : NSObject

@property (nonatomic,copy)NSString *nameLabel;

@property (nonatomic,copy)NSString *vip_priceLabel;

@property (nonatomic,copy)NSString *pictureLabel;

@property (nonatomic,copy)NSString *redirect_url;

@property (nonatomic,copy)NSString *purchase_btnLabel;

@property (nonatomic,strong)NSString *brand_area_name;

@property (nonatomic,strong)NSNumber *original_priceLabel;

@end
