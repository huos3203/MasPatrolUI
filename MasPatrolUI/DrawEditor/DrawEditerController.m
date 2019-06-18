//
//  DrawEditerController.m
//  MasPatrolUI
//
//  Created by admin on 2019/6/11.
//  Copyright © 2019 com. All rights reserved.
//

#import "DrawEditerController.h"
#import "CLImageEditor.h"
#import <Masonry/Masonry.h>

#import "PatrolOptionSelController.h"

@interface DrawEditerController ()<CLImageEditorDelegate>

@end

@implementation DrawEditerController
{
    UIImageView *_imgView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *editer = [UIButton new];
    [editer setTitle:@"编辑图片" forState:UIControlStateNormal];
    [editer setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [editer addTarget:self action:@selector(editerImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:editer];
    [editer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    _imgView = [UIImageView new];
    [self.view addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(@0);
    }];
}

-(void)editerImage
{
    UIImage *image;
    if (_imgView.image) {
        image = _imgView.image;
    }else{
        image = [UIImage imageNamed:@"default.jpg"];
    }
    CLImageEditor *editor = [[CLImageEditor alloc] initWithJHImage:image delegate:self];
    ///设置皮肤主题
    editor.theme.bundleName = @"CLImageEditor";  //资源bundle名
    editor.theme.backgroundColor = [UIColor blackColor];
    editor.theme.statusBarHidden = YES;
    editor.theme.toolbarColor = [UIColor blackColor];
    editor.theme.toolIconColor = @"white";
    editor.theme.toolbarTextColor = [UIColor whiteColor];
    
    CLImageToolInfo *tool0 = [editor.toolInfo subToolInfoWithToolName:@"CLDrawTool" recursive:NO];
    tool0.title = @"涂鸦";
    CLImageToolInfo *tool01 = [editor.toolInfo subToolInfoWithToolName:@"CLTextTool" recursive:NO];
    tool01.title = @"文字";
    
    [self presentViewController:editor animated:YES completion:nil];
    //[editor showInViewController:self withImageView:_imageView];
}

#pragma mark - 图片编辑器代理
- (void)imageEditor:(CLImageEditor *)editor didFinishEditingWithImage:(UIImage *)image
{
    [_imgView setImage:image];
    [editor dismissViewControllerAnimated:YES completion:^{
        //跳转到检查项选择器
        PatrolOptionSelController *optselVC = [PatrolOptionSelController new];
        optselVC.optionHandler = ^(NSArray *opts) {
            //解析数据
            //刷新UI
        };
        [self presentViewController:optselVC animated:YES completion:nil];
    }];
}

@end
