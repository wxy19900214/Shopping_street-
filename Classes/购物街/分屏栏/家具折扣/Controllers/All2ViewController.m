//
//  All2ViewController.m
//  Shoping Street
//
//  Created by WANGXINYU on 16/3/29.
//  Copyright © 2016年 wangxinyu. All rights reserved.
//

#import "All2ViewController.h"
#import "AllCollectionViewCell.h"
#import "AFNetworking.h"
#import "TaoBaoViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AllModel.h"
#import "MJRefresh.h"

#define URL_ALL @"http://m.meiyou.com/brand_area_catalog/item_list?myuid=73722622&tbuid=AAHHcXGgACLvjRdMA10NBJAl&device_id=20:08:ed:07:f3:79&platform=android&v=1.1.1&imei=359209025863006&bundleid=186&mode=0&app_id=7&auth=3.e6%252FqGrXdHtwYLX3rhveAfIQJQGQnzZC6iWMtmJGTub4%253D&sdkversion=17&catalog_id=0&group_id=2&size=0"

//page=1
@interface All2ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSInteger count;
}

@property (nonatomic,strong)NSMutableArray *DataArray;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation All2ViewController

-(NSMutableArray *)DataArray
{
    if (!_DataArray) {
        
        _DataArray = [NSMutableArray new];
    }
    return _DataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"AllCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self getAllFromNet];
    
    [self addRefrsh];
}

-(void)addRefrsh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        count = 1;
        [self getAllFromNet];
        
        
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        count++;
        [self getAllFromNet];
    }];

}

-(void)getAllFromNet
{
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    
    if (count == 1) {
        
        [self.DataArray removeAllObjects];
    }

    
    manger.responseSerializer = [AFHTTPResponseSerializer serializer];
   
    [manger GET:URL_ALL  parameters:@{@"page":@(count)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        
        //解析数据
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        //NSLog(@"dict=%@",dict);
        
        NSDictionary *dict1 = dict[@"data"];
        
        
        NSArray *itemsArray = dict1[@"item_list"];
        
        for (NSDictionary *dict1 in itemsArray) {
            
            AllModel *model = [AllModel new];
            
            model.nameLabel = dict1[@"name"];
            model.vip_priceLabel = dict1[@"vip_price"];
            model.pictureLabel = dict1[@"picture"];
            model.redirect_url = dict1[@"redirect_url"];
            model.original_priceLabel = dict1[@"original_price"];
                         
            [self.DataArray addObject:model];
            
        }
        [self.collectionView reloadData];
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"获取详情数据失败");
        
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];

    }];
}

#pragma mark-UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.DataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    AllCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    AllModel *model = self.DataArray[indexPath.item];
    
    cell.nameLabel.text =model.nameLabel;
    
    cell.vip_priceLabel.text = [NSString stringWithFormat:@"%@",model.vip_priceLabel];
    
    cell.original_priceLabel.text = [NSString stringWithFormat:@"%@",model.original_priceLabel];
    
    [cell.pictureImage setImageWithURL:[NSURL URLWithString:model.pictureLabel]];
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TaoBaoViewController *tvc = [TaoBaoViewController new];
    AllModel*model = self.DataArray[indexPath.item];
    
    tvc.url = [NSURL URLWithString:model.redirect_url];
    
    [self.navigationController pushViewController:tvc animated:YES];
    //tvc.hidesBottomBarWhenPushed = YES;
        
    //[self presentViewController:tvc animated:YES completion:nil];
    
}

 
@end
