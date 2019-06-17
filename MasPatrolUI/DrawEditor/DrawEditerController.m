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
    tool0.available = YES;//如果available设置为no，则从菜单视图中删除。
    tool0.dockedNumber = -1;//置于顶层
    CLImageToolInfo *tool01 = [editor.toolInfo subToolInfoWithToolName:@"CLTextTool" recursive:NO];
    tool01.title = @"文字";
    tool01.available = YES;//如果available设置为no，则从菜单视图中删除。
    [self removeOtherBut:editor];
    
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
        [self presentViewController:optselVC animated:YES completion:nil];
    }];
}


-(void)removeOtherBut:(CLImageEditor *)editor
{
    CLImageToolInfo *tool = [editor.toolInfo subToolInfoWithToolName:@"CLToneCurveTool" recursive:NO];
    tool.available = NO;
    
    CLImageToolInfo *tool1 = [editor.toolInfo subToolInfoWithToolName:@"CLRotateTool" recursive:YES];
    tool1.available = NO;
    
    CLImageToolInfo *tool2 = [editor.toolInfo subToolInfoWithToolName:@"CLHueEffect" recursive:YES];
    tool2.available = NO;
    
    CLImageToolInfo *tool3 = [editor.toolInfo subToolInfoWithToolName:@"CLBlurTool" recursive:YES];
    tool3.available = NO;
    CLImageToolInfo *tool4 = [editor.toolInfo subToolInfoWithToolName:@"CLAdjustmentTool" recursive:YES];
    tool4.available = NO;
    CLImageToolInfo *tool5 = [editor.toolInfo subToolInfoWithToolName:@"CLEffectTool" recursive:YES];
    tool5.available = NO;
    //滤镜
    CLImageToolInfo *tool6 = [editor.toolInfo subToolInfoWithToolName:@"CLFilterTool" recursive:YES];
    tool6.available = NO;
    CLImageToolInfo *tool7 = [editor.toolInfo subToolInfoWithToolName:@"CLSplashTool" recursive:YES];
    tool7.available = NO;
    //贴图
    CLImageToolInfo *tool8 = [editor.toolInfo subToolInfoWithToolName:@"CLEmoticonTool" recursive:YES];
    tool8.available = NO;
    CLImageToolInfo *tool9 = [editor.toolInfo subToolInfoWithToolName:@"CLStickerTool" recursive:YES];
    tool9.available = NO;
    //放大缩小
    CLImageToolInfo *tool10 = [editor.toolInfo subToolInfoWithToolName:@"CLResizeTool" recursive:YES];
    tool10.available = NO;
    //剪切
    CLImageToolInfo *tool11 = [editor.toolInfo subToolInfoWithToolName:@"CLClippingTool" recursive:YES];
    tool11.available = NO;
}

@end
