//
//  StoreTypeColView.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "StoreTypeColView.h"
#import <Masonry/Masonry.h>

@implementation StoreTypeCell
{
    UILabel *tagLabel;
    UIView *selectLine;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //tag
        tagLabel = [UILabel new];
        tagLabel.textColor = [UIColor colorWithRed:0/255.0 green:3/255.0 blue:51/255.0 alpha:1.0];
        tagLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:tagLabel];
        [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.equalTo(self.contentView);
        }];
        selectLine = [UIView new];
        [self.contentView addSubview:selectLine];
        selectLine.backgroundColor = [UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0];
        selectLine.hidden = YES;
        [selectLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-6);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(8);
            make.height.equalTo(@2);
        }];
        
    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    tagLabel.text = [NSString stringWithFormat:@"  %@   ",title];
}
-(void)setSelected:(BOOL)selected
{
    if (selected) {
        tagLabel.textColor = [UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0];;
        tagLabel.font = [UIFont boldSystemFontOfSize:16];
        selectLine.hidden = NO;
    }else{
        tagLabel.textColor = [UIColor colorWithRed:0/255.0 green:3/255.0 blue:51/255.0 alpha:1.0];
        tagLabel.font = [UIFont systemFontOfSize:14];
        selectLine.hidden = YES;
    }
    
}

@end


@interface StoreTypeColView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation StoreTypeColView

-(instancetype)init
{
    if (self = [super init]) {
        //left
        UIButton *leftArrow = [UIButton new];
        leftArrow.backgroundColor = [UIColor redColor];
        [leftArrow setImage:[UIImage new] forState:UIControlStateNormal];
        leftArrow.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        UIButton *rightArrow = [UIButton new];
        rightArrow.backgroundColor = [UIColor redColor];
        [rightArrow setImage:[UIImage new] forState:UIControlStateNormal];
        rightArrow.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self addSubview:leftArrow];
        [self addSubview:rightArrow];
        [leftArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(15, 11));
        }];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_equalTo(-8);
            make.size.mas_equalTo(CGSizeMake(15, 11));
        }];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftArrow.mas_right).offset(0);
            make.right.equalTo(rightArrow.mas_left).offset(0);
            make.height.equalTo(@30);
            make.top.bottom.equalTo(@0);
        }];
    }
    return self;
}

#pragma mark - API
-(void)reloadData{
    [self.collectionView reloadData];
}
#pragma mark collection代理方法
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
    StoreTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreTypeCell" forIndexPath:indexPath];
    cell.title = _dataArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
//    if ([_delegate respondsToSelector:@selector(dragSectionOf:collectionView:)]) {
//        [_delegate dragSectionOf:currentIndexPath collectionView:self.collectionView];
//    }
}


#pragma mark - getter
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.estimatedItemSize = CGSizeMake(100, 33);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);    //item边距
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[StoreTypeCell class] forCellWithReuseIdentifier:@"StoreTypeCell"];
        //
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    
    return _collectionView;
}
@end
