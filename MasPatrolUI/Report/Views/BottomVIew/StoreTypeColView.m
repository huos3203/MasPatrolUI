//
//  StoreTypeColView.m
//  MasPatrolUI
//
//  Created by admin on 2019/5/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "StoreTypeColView.h"
#import <Masonry/Masonry.h>

@implementation StoreTypeModel
@end

@interface StoreTypeCell()
@property (strong, nonatomic) UIColor *textColor;
@end
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
            make.bottom.equalTo(self.contentView).offset(5);
            make.height.equalTo(@2);
        }];
        
    }
    return self;
}
-(void)setModel:(StoreTypeModel *)model
{
    _model = model;
    tagLabel.text = [NSString stringWithFormat:@"  %@   ",model.title];
    tagLabel.textColor = self.textColor;
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        tagLabel.textColor = [UIColor colorWithRed:44/255.0 green:215/255.0 blue:115/255.0 alpha:1.0];;
        tagLabel.font = [UIFont boldSystemFontOfSize:16];
        selectLine.hidden = NO;
    }else{
        tagLabel.textColor = self.textColor;
        tagLabel.font = [UIFont systemFontOfSize:14];
        selectLine.hidden = YES;
    }
}

- (UIColor *)textColor{
    UIColor *color;
    switch (self.model.flag) {
        case SType_CanDo:
            color = [UIColor colorWithRed:47/255.0 green:56/255.0 blue:86/255.0 alpha:1.0];
            break;
        case SType_CantDo:
            color = [UIColor colorWithRed:153/255.0 green:160/255.0 blue:182/255.0 alpha:1.0];
            break;
        case SType_Completed:
            color = [UIColor colorWithRed:66/255.0 green:139/255.0 blue:254/255.0 alpha:1.0];
            break;
        default:
            break;
    }
    return color;
}


@end


@interface StoreTypeColView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation StoreTypeColView
{
    UIButton *leftBtn;
    UIButton *rightBtn;
    void(^blockHandler)(NSString *);
}
-(instancetype)initWith:(void(^)(NSString *))handler
{
    if (self = [super init]) {
        //left
        blockHandler = handler;
        UIButton *leftArrow = [UIButton new];
        leftBtn = leftArrow;
        [leftArrow setImage:[UIImage imageNamed:@"reprightArrow"] forState:UIControlStateNormal];
        CGAffineTransform transform = CGAffineTransformIdentity;
        transform = CGAffineTransformRotate(transform, M_PI);
        leftArrow.transform = transform;
        leftArrow.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftArrow addTarget:self action:@selector(toLeftAction:) forControlEvents:UIControlEventTouchUpInside];
        UIButton *rightArrow = [UIButton new];
        rightBtn = rightArrow;
        [rightArrow setImage:[UIImage imageNamed:@"reprightArrow"] forState:UIControlStateNormal];
        rightArrow.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [rightArrow addTarget:self action:@selector(toRightAction:) forControlEvents:UIControlEventTouchUpInside];
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
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.bottom.left.right.equalTo(@0);
        }];
    }
    return self;
}

#pragma mark - API
-(void)reloadData{
    [self.collectionView reloadData];
}

#pragma mark - UIAction
-(void)toLeftAction:(UIButton *)leftArrow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
}

-(void)toRightAction:(UIButton *)rightArrow
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.dataArray.count-1 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionLeft];
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
    cell.model = _dataArray[indexPath.row];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreTypeModel *model = self.dataArray[indexPath.row];
    BOOL isEqual = NO;
    NSArray *arry = [self.collectionView indexPathsForSelectedItems];
    if (arry.count > 0) {
        NSIndexPath *preIndex = arry[0];
        isEqual = preIndex.row == indexPath.row;
    }
    if (model.flag == SType_CantDo || isEqual) return NO;
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    StoreTypeModel *model = self.dataArray[indexPath.row];
    if (blockHandler) {
        blockHandler(model.typeId);
    }
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    leftBtn.enabled = indexPath.row == 0?NO:YES;
    rightBtn.enabled = indexPath.row == self.dataArray.count - 1?NO:YES;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(20, 30);
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
