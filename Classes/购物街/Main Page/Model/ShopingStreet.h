//
//  ShopingStreet.h
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/22.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ShopingStreet : NSObject
@property (nonatomic,copy)NSString *PictureImage;
@property (nonatomic,copy)NSString *NameLabel;
@property (nonatomic,copy)NSString *original_priceLabel;
@property (nonatomic,copy)NSString *vip_price;
@property (nonatomic,copy)NSString *purchase_btnLabel;
@property (nonatomic,copy)NSString *promotion_customLabel;
@property (nonatomic,copy)NSString *item_count_msgLabel;
@property (weak,nonatomic) NSNumber* brand_area_idLabel;
@property (nonatomic,strong)NSString *brand_area_nameLabel;
@property (nonatomic ,strong)NSString *redirect_urlLabel;
@end








