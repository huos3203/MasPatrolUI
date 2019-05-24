//
//  ReportCameraView.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "ReportCameraView.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
@implementation ReportCameraModel
@end
@interface ReportCameraColCell()
@property (strong, nonatomic) UIView *editImageView;
@property (strong, nonatomic) UIView *AddCameraView;
@end
@implementation ReportCameraColCell
{
    UIButton *_delBut;
    UIImageView *_preImgView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //ImgView
        UIImageView *imgView = [UIImageView new];
        _preImgView = imgView;
        [self.contentView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.insets(UIEdgeInsetsMake(8, 8, 8, 8));
            make.size.mas_equalTo(CGSizeMake(72, 72));
            make.center.equalTo(@0);
        }];
        //Delbut
        UIButton *delBut = [UIButton new];
        [delBut setImage:[UIImage imageNamed:@"repdel"] forState:UIControlStateNormal];
        _delBut = delBut;
        [self.contentView addSubview:delBut];
        [delBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(17, 17));
            make.right.top.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setModel:(ReportCameraModel *)model
{
    _model = model;
    _delBut.hidden = NO;
    if (model.type != Cell_CanDel) {
        _delBut.hidden = YES;
    }
    [_preImgView sd_setImageWithURL:[NSURL URLWithString:model.url]];
}

@end

@interface ReportCameraView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation ReportCameraView
-(instancetype)init
{
    self = [super init];
    UILabel *title = [UILabel new];
    title.textColor = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
    title.font = [UIFont boldSystemFontOfSize:16.0];
    title.text = @"检查结果拍照";
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@8);
        make.right.equalTo(@-8);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.bottom.left.right.equalTo(@0);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(8);
        make.left.equalTo(@8);
        make.centerX.equalTo(@0);
        make.bottom.equalTo(line.mas_top).offset(-8);
        //        make.height.equalTo(@88);
    }];
    return self;
}
#pragma mark - api
-(void)reloadData
{
    [self.collectionView reloadData];
}

#pragma mark - UICollecionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ReportCameraColCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ReportCameraColCell" forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma mark - getter
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.estimatedItemSize = CGSizeMake(85, 85);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);    //item边距
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[ReportCameraColCell class] forCellWithReuseIdentifier:@"ReportCameraColCell"];
        //
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}
@end
