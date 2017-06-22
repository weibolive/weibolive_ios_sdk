//
//  SendMessageToWeiboViewController.m
//  WeiboSDKDemo
//
//  Created by Wade Cheng on 3/29/13.
//  Copyright (c) 2013 SINA iOS Team. All rights reserved.
//

#import "SendMessageToWeiboViewController.h"
#import "AppDelegate.h"
#import "WeiboSDK.h"
#import "WeiboSDK+Statistics.h"
#import "WeiboLiveSDK.h"
#import "WBIMLiveManager.h"
#import "WBIMLiveListener.h"
#pragma "WBIMPushMessageModel.h"
#import "WBIMBaseRequest.h"
#import "WBIMUser.h"
#import "WBIMBundle.h"


#define kTest_RoomId @""
#define kTest_UserId @""
#define kTest_UserName @""
#define kTest_Token @""

@interface WBDataTransferObject ()
//@property (nonatomic, readonly) WeiboSDK3rdApp *app;
- (NSString *)validate;
- (void)storeToDictionary:(NSMutableDictionary *)dict;
- (void)loadFromDictionary:(NSDictionary *)dict;
+ (id)mappedObjectWithDictionary:(NSDictionary *)dict;
#ifdef WeiboSDKDebug
- (void)debugPrint;
#endif
@end

@interface SendMessageToWeiboViewController()<UIScrollViewDelegate, WBIMLiveListener>
-(UITextView*)createSubView:(UILabel*) label labelvalue:(NSString*)labelvalue labelrect:(CGRect)labelrect text:(UITextView*)text textvalue:(NSString*)textvalue rect:(CGRect)textrect scrollView:(UIScrollView*) scrollView;
-(void)initSubView;

@property (nonatomic) WeiboLiveSDK *weiboLiveSDK;

@property (nonatomic, strong) UILabel *titleLabel;


@property (nonatomic, strong) UITextView *textToken;
@property (nonatomic, strong) UITextView *textUid;

@property (nonatomic, strong) UITextView *textCreateInput;
@property (nonatomic, strong) UITextView *textCreateToken;
@property (nonatomic, strong) UITextView *textCreateTitle;
@property (nonatomic, strong) UITextView *textCreateWidth;
@property (nonatomic, strong) UITextView *textCreateHeight;

@property (nonatomic, strong) UITextView *textCreateSummary;
@property (nonatomic, strong) UISwitch * switchCreateSummary;
@property (nonatomic, strong) UITextView *textCreatePublished;
@property (nonatomic, strong) UISwitch * switchCreatePublished;
@property (nonatomic, strong) UITextView *textCreateImage;
@property (nonatomic, strong) UISwitch * switchCreateImage;
@property (nonatomic, strong) UITextView *textCreateReplay;
@property (nonatomic, strong) UISwitch * switchCreateReplay;
@property (nonatomic, strong) UITextView *textCreatePano;
@property (nonatomic, strong) UISwitch * switchCreatePano;

@property (nonatomic, strong) UITextView *textUpdateInput;
@property (nonatomic, strong) UITextView *textUpdateToken;
@property (nonatomic, strong) UITextView *textUpdateID;
@property (nonatomic, strong) UITextView *textUpdateTitle;
@property (nonatomic, strong) UISwitch * switchUpdateTitle;
@property (nonatomic, strong) UITextView *textUpdateSummary;
@property (nonatomic, strong) UISwitch * switchUpdateSummary;
@property (nonatomic, strong) UITextView *textUpdatePublished;
@property (nonatomic, strong) UISwitch * switchUpdatePublished;
@property (nonatomic, strong) UITextView *textUpdateImage;
@property (nonatomic, strong) UISwitch * switchUpdateImage;
@property (nonatomic, strong) UITextView *textUpdateStop;
@property (nonatomic, strong) UISwitch * switchUpdateStop;
@property (nonatomic, strong) UITextView *textUpdateReplayurl;
@property (nonatomic, strong) UISwitch * switchUpdateReplayurl;


@property (nonatomic, strong) UITextView *textShowInput;
@property (nonatomic, strong) UITextView *textShowToken;
@property (nonatomic, strong) UITextView *textShowID;
@property (nonatomic, strong) UITextView *textShowDetail;
@property (nonatomic, strong) UISwitch * switchShwoDetail;

@property (nonatomic, strong) UITextView *textDeleteInput;
@property (nonatomic, strong) UITextView *textDeleteToken;
@property (nonatomic, strong) UITextView *textDeleteID;

@property (nonatomic, strong) UISwitch * textSwitch;

@property (nonatomic, strong) UITextField *roomIdTextField;
@property (nonatomic, strong) UITextField *joinRoomTokenTextField;
@property (nonatomic, strong) UITextField *userIdTextField;
@property (nonatomic, strong) UITextView *pushMsgTextView;

@end

@implementation SendMessageToWeiboViewController

-(void)updateTokenUid:(NSString*)token uid:(NSString*)uid{
    self.textToken.text = token;
    self.textUid.text = uid;
    
    NSString* access_token = @"";
    access_token = [access_token stringByAppendingString:[NSString stringWithFormat:@"access_token=%@", token]];
    NSString* createlive = access_token;
    NSString* title = @"hellolive";
    NSString* width = @"720";
    NSString* height = @"480";
    createlive = [createlive stringByAppendingString:[NSString stringWithFormat:@"&title=%@&height=%@&width=%@", title, height, width]];
    
    self.textCreateInput.text = createlive;
    self.textCreateToken.text = token;
    self.textCreateTitle.text = title;
    self.textCreateWidth.text = width;
    self.textCreateHeight.text = height;
    
    
    self.textUpdateInput.text = access_token;
    self.textUpdateToken.text = token;
    
    self.textShowInput.text = access_token;
    self.textShowToken.text = token;
    
    self.textDeleteInput.text = access_token;
    self.textDeleteToken.text = token;
}

-(UITextView*)createSubView:(UILabel*) label labelvalue:(NSString*)labelvalue labelrect:(CGRect)labelrect text:(UITextView*)text textvalue:(NSString*)textvalue rect:(CGRect)textrect scrollView:(UIScrollView*) scrollView{
    label = [[UILabel alloc] initWithFrame:labelrect];
    label.text = labelvalue;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:label];
    
    text = [[UITextView alloc] initWithFrame:textrect];
    text.text = textvalue;
    text.backgroundColor = [UIColor clearColor];
    text.textAlignment = NSTextAlignmentLeft;
    text.layer.masksToBounds=YES;
    text.layer.borderWidth=1.0;
    text.layer.borderColor=[[UIColor grayColor] CGColor];
    text.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [scrollView addSubview:text];
    
    return text;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.weiboLiveSDK = [[WeiboLiveSDK alloc] init];
    
    int height = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*5)];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, 300, 30)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 3;
    [scrollView addSubview:self.titleLabel];
    self.titleLabel.text = @"WBLiveSDKDemo";
    
    ////
    height += 30;
    UIButton *ssoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ssoButton setTitle:@"登录" forState:UIControlStateNormal];
    [ssoButton addTarget:self action:@selector(ssoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    ssoButton.frame = CGRectMake(50, height, 100, 40);
    [scrollView addSubview:ssoButton];
    
    UIButton *ssoOutButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ssoOutButton setTitle:@"退出" forState:UIControlStateNormal];
    [ssoOutButton addTarget:self action:@selector(ssoOutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    ssoOutButton.frame = CGRectMake(120, height, 250, 40);
    [scrollView addSubview:ssoOutButton];
    
    height += 30;
    UILabel *accesstokenLabel = nil;
    UITextView *accesstokenText = nil;
    self.textToken = [self createSubView:accesstokenLabel labelvalue:@"token" labelrect:CGRectMake(15, height, 60, 30) text:accesstokenText textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
    
    
    height += 5;
    height += 30;
  
    UILabel *uidLabel = nil;
    UITextView *uidText = nil;
    self.textUid = [self createSubView:uidLabel labelvalue:@"uid" labelrect:CGRectMake(15, height, 60, 30) text:uidText textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
    
    /////
    
    height += 50;
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, height, 120, 30)];
    textLabel.text = @"直播参数设置";
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;

    self.textSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(140, height, 120, 30)];
    self.textSwitch.on = NO;
    self.textSwitch.hidden = YES;
    [self.textSwitch addTarget:self action:@selector(switchChange) forControlEvents:UIControlEventValueChanged];
    [scrollView addSubview:textLabel];
    [scrollView addSubview:self.textSwitch];
    
    //////
    height += 30;
    UIButton *createliveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [createliveButton setTitle:@"创建直播" forState:UIControlStateNormal];
    [createliveButton addTarget:self action:@selector(createLive) forControlEvents:UIControlEventTouchUpInside];
    createliveButton.frame = CGRectMake(20, height, 280, 40);
    [scrollView addSubview:createliveButton];
    
    height += 35;
    UILabel *createLiveLabelInput = nil;
    UITextView *createliveText = nil;
    self.textCreateInput = [self createSubView:createLiveLabelInput labelvalue:@"参数" labelrect:CGRectMake(15, height, 50, 30) text:createliveText textvalue:@"" rect:CGRectMake(70, height, 230, 60) scrollView:scrollView ];

    height += 35;
///////
    UILabel *create_token_label = nil;
    UITextView *create_token_text = nil;
    self.textCreateToken = [self createSubView:create_token_label labelvalue:@"token" labelrect:CGRectMake(15, height, 60, 30) text:create_token_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];

    height += 35;
    UILabel *create_title_label = nil;
    UITextView *create_title_text = nil;
    self.textCreateTitle = [self createSubView:create_title_label labelvalue:@"title" labelrect:CGRectMake(15, height, 60, 30) text:create_title_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
  
    height += 35;
    UILabel *create_width_label = nil;
    UITextView *create_width_text = nil;
    self.textCreateWidth = [self createSubView:create_width_label labelvalue:@"width" labelrect:CGRectMake(15, height, 60, 30) text:create_width_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
  
    height += 35;
    UILabel *create_height_label = nil;
    UITextView *create_height_text = nil;
    self.textCreateHeight = [self createSubView:create_height_label labelvalue:@"height" labelrect:CGRectMake(15, height, 60, 30) text:create_height_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
    
    height += 35;
    UILabel *create_summary_label = nil;
    UITextView *create_summary_text = nil;
    self.textCreateSummary = [self createSubView:create_summary_label labelvalue:@"summary" labelrect:CGRectMake(15, height, 60, 30) text:create_summary_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchCreateSummary = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchCreateSummary.on = NO;
    [scrollView addSubview:self.switchCreateSummary];
   
    height += 35;
    UILabel *create_published_label = nil;
    UITextView *create_published_text = nil;
    self.textCreatePublished = [self createSubView:create_published_label labelvalue:@"published" labelrect:CGRectMake(15, height, 60, 30) text:create_published_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchCreatePublished = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchCreatePublished.on = NO;
    [scrollView addSubview:self.switchCreatePublished];
   
    height += 35;
    UILabel *create_image_label = nil;
    UITextView *create_image_text = nil;
    self.textCreateImage = [self createSubView:create_image_label labelvalue:@"image" labelrect:CGRectMake(15, height, 60, 30) text:create_image_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchCreateImage = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchCreateImage.on = NO;
    [scrollView addSubview:self.switchCreateImage];
    
    height += 35;
    UILabel *create_replay_label = nil;
    UITextView *create_replay_text = nil;
    self.textCreateReplay = [self createSubView:create_replay_label labelvalue:@"replay" labelrect:CGRectMake(15, height, 60, 30) text:create_replay_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchCreateReplay = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchCreateReplay.on = NO;
    [scrollView addSubview:self.switchCreateReplay];

    height += 35;
    UILabel *create_pano_label = nil;
    UITextView *create_pano_text = nil;
    self.textCreatePano = [self createSubView:create_pano_label labelvalue:@"pano" labelrect:CGRectMake(15, height, 60, 30) text:create_pano_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchCreatePano = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchCreatePano.on = NO;
    [scrollView addSubview:self.switchCreatePano];

    ///////
    
    
    ///////
    height += 60;
    UIButton *updateliveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [updateliveButton setTitle:@"更新直播" forState:UIControlStateNormal];
    [updateliveButton addTarget:self action:@selector(updateLive) forControlEvents:UIControlEventTouchUpInside];
    updateliveButton.frame = CGRectMake(20, height, 280, 40);
    [scrollView addSubview:updateliveButton];
    
    height += 35;
    UILabel *updateLiveLabelInput = nil;
    UITextView *updateliveText = nil;
    self.textUpdateInput = [self createSubView:updateLiveLabelInput labelvalue:@"参数" labelrect:CGRectMake(15, height, 50, 30) text:updateliveText textvalue:@"" rect:CGRectMake(70, height, 230, 60) scrollView:scrollView ];
  
    
    height += 35;
    UILabel *update_token_label = nil;
    UITextView *update_token_text = nil;
    self.textUpdateToken = [self createSubView:update_token_label labelvalue:@"token" labelrect:CGRectMake(15, height, 60, 30) text:update_token_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
  
    height += 35;
    UILabel *update_id_label = nil;
    UITextView *update_id_text = nil;
    self.textUpdateID = [self createSubView:update_id_label labelvalue:@"id" labelrect:CGRectMake(15, height, 60, 30) text:update_id_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];

    height += 35;
    UILabel *update_title_label = nil;
    UITextView *update_title_text = nil;
    self.textUpdateTitle = [self createSubView:update_title_label labelvalue:@"title" labelrect:CGRectMake(15, height, 60, 30) text:update_title_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchUpdateTitle = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchUpdateTitle.on = NO;
    [scrollView addSubview:self.switchUpdateTitle];
   
    height += 35;
    UILabel *update_summary_label = nil;
    UITextView *update_summary_text = nil;
    self.textUpdateSummary = [self createSubView:update_summary_label labelvalue:@"summary" labelrect:CGRectMake(15, height, 60, 30) text:update_summary_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchUpdateSummary = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchUpdateSummary.on = NO;
    [scrollView addSubview:self.switchUpdateSummary];
  
    height += 35;
    UILabel *update_published_label = nil;
    UITextView *update_published_text = nil;
    self.textUpdatePublished = [self createSubView:update_published_label labelvalue:@"published" labelrect:CGRectMake(15, height, 60, 30) text:update_published_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchUpdatePublished = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchUpdatePublished.on = NO;
    [scrollView addSubview:self.switchUpdatePublished];
    
    height += 35;
    UILabel *update_image_label = nil;
    UITextView *update_image_text = nil;
    self.textUpdateImage = [self createSubView:update_image_label labelvalue:@"image" labelrect:CGRectMake(15, height, 60, 30) text:update_image_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchUpdateImage = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchUpdateImage.on = NO;
    [scrollView addSubview:self.switchUpdateImage];
  
    height += 35;
    UILabel *update_stop_label = nil;
    UITextView *update_stop_text = nil;
    self.textUpdateStop = [self createSubView:update_stop_label labelvalue:@"stop" labelrect:CGRectMake(15, height, 60, 30) text:update_stop_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchUpdateStop = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchUpdateStop.on = NO;
    [scrollView addSubview:self.switchUpdateStop];
   
    height += 35;
    UILabel *update_replay_label = nil;
    UITextView *update_replay_text = nil;
    self.textUpdateReplayurl = [self createSubView:update_replay_label labelvalue:@"replayurl" labelrect:CGRectMake(15, height, 60, 30) text:update_replay_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchUpdateReplayurl = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchUpdateReplayurl.on = NO;
    [scrollView addSubview:self.switchUpdateReplayurl];
  

    ////
    height += 60;
    UIButton *showliveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [showliveButton setTitle:@"获取直播信息" forState:UIControlStateNormal];
    [showliveButton addTarget:self action:@selector(showLive) forControlEvents:UIControlEventTouchUpInside];
    showliveButton.frame = CGRectMake(20, height, 280, 40);
    [scrollView addSubview:showliveButton];
    
    height += 30;
    UILabel *showLiveLabelInput = nil;
    UITextView *showliveText = nil;
    self.textShowInput = [self createSubView:showLiveLabelInput labelvalue:@"参数" labelrect:CGRectMake(15, height, 50, 30) text:showliveText textvalue:@"" rect:CGRectMake(70, height, 230, 60) scrollView:scrollView ];
  
    
    height += 60;
    UILabel *show_token_label = nil;
    UITextView *show_token_text = nil;
    self.textShowToken = [self createSubView:show_token_label labelvalue:@"token" labelrect:CGRectMake(15, height, 60, 30) text:show_token_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
   
    height += 35;
    UILabel *show_id_label = nil;
    UITextView *show_id_text = nil;
    self.textShowID = [self createSubView:show_id_label labelvalue:@"id" labelrect:CGRectMake(15, height, 60, 30) text:show_id_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
    
    height += 35;
    UILabel *show_detail_label = nil;
    UITextView *show_detail_text = nil;
    self.textShowDetail = [self createSubView:show_detail_label labelvalue:@"detail" labelrect:CGRectMake(15, height, 60, 30) text:show_detail_text textvalue:@"" rect:CGRectMake(70, height, 170, 30) scrollView:scrollView ];
    self.switchShwoDetail = [[UISwitch alloc] initWithFrame:CGRectMake(250, height, 30, 30)];
    self.switchShwoDetail.on = NO;
    [scrollView addSubview:self.switchShwoDetail];
    
    ////
    
    height += 60;
    UIButton *deleteliveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleteliveButton setTitle:@"删除直播" forState:UIControlStateNormal];
    [deleteliveButton addTarget:self action:@selector(deleteLive) forControlEvents:UIControlEventTouchUpInside];
    deleteliveButton.frame = CGRectMake(20, height, 280, 40);
    [scrollView addSubview:deleteliveButton];
    
    height += 35;
    UILabel *deleteLiveLabelInput = nil;
    UITextView *deleteliveText = nil;
    self.textDeleteInput = [self createSubView:deleteLiveLabelInput labelvalue:@"参数" labelrect:CGRectMake(15, height, 50, 30) text:deleteliveText textvalue:@"" rect:CGRectMake(70, height, 230, 60) scrollView:scrollView ];
 
    
    ///
    height += 60;
    UILabel *delete_token_label = nil;
    UITextView *delete_token_text = nil;
    self.textDeleteToken = [self createSubView:delete_token_label labelvalue:@"token" labelrect:CGRectMake(15, height, 60, 30) text:delete_token_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
    
    height += 35;
    UILabel *delete_id_label = nil;
    UITextView *delete_id_text = nil;
    self.textDeleteID =  [self createSubView:delete_id_label labelvalue:@"id" labelrect:CGRectMake(15, height, 60, 30) text:delete_id_text textvalue:@"" rect:CGRectMake(70, height, 230, 30) scrollView:scrollView ];
    
    
    
    
    // 互动相关
    
    height += 55;
    
    CGFloat width = self.view.frame.size.width;
    
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, height, width, 1)];
    splitView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:splitView];
    
    
    height = CGRectGetMaxY(splitView.frame) + 5;
    UIButton *joinRoomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    joinRoomBtn.layer.cornerRadius = 15;
    joinRoomBtn.layer.borderWidth = 1;
    joinRoomBtn.layer.borderColor = [UIColor greenColor].CGColor;
    [joinRoomBtn setTitle:@"加入房间" forState:UIControlStateNormal];
    [joinRoomBtn addTarget:self action:@selector(onJoinRoomBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *exitRoomBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    exitRoomBtn.layer.cornerRadius = 15;
    exitRoomBtn.layer.borderWidth = 1;
    exitRoomBtn.layer.borderColor = [UIColor greenColor].CGColor;
    [exitRoomBtn setTitle:@"退出房间" forState:UIControlStateNormal];
    [exitRoomBtn addTarget:self action:@selector(onExitRoomBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    joinRoomBtn.frame = CGRectMake(10, height, (width - 40)/2.f, 30.f);
    exitRoomBtn.frame = CGRectMake(width/2.f + 10, height, (width - 40)/2.f, 30.f);
    
    [scrollView addSubview:joinRoomBtn];
    [scrollView addSubview:exitRoomBtn];
    
    // 房间id
    height = CGRectGetMaxY(joinRoomBtn.frame) + 5;
    CGFloat padding = 10;
    UILabel *roomidLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, 30.f)];
    roomidLabel.text = @"房间id:";
    [scrollView addSubview:roomidLabel];
    
    height = CGRectGetMaxY(roomidLabel.frame) + 5;
    self.roomIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(padding, height, width-padding*2, 30.f)];
    self.roomIdTextField.layer.borderWidth = 1;
    self.roomIdTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.roomIdTextField.text = kTest_RoomId;//@"1042097:bf0dc624a1081ac6b08c6caad7356c8a";
    [scrollView addSubview:self.roomIdTextField];
    
    // token
    height = CGRectGetMaxY(self.roomIdTextField.frame) + 5;
    UILabel *joinRoomTokenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, 30.f)];
    joinRoomTokenLabel.text = @"token:";
    [scrollView addSubview:joinRoomTokenLabel];
    
    height = CGRectGetMaxY(joinRoomTokenLabel.frame) + 5;
    self.joinRoomTokenTextField = [[UITextField alloc] initWithFrame:CGRectMake(padding, height, width-padding*2, 30.f)];
    self.joinRoomTokenTextField.layer.borderWidth = 1;
    self.joinRoomTokenTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.joinRoomTokenTextField.text = kTest_Token;//@"2.00XPF6kGheU7qB6747b840fdqvGzvD";
    [scrollView addSubview:self.joinRoomTokenTextField];
    
    // id
    height = CGRectGetMaxY(self.joinRoomTokenTextField.frame) + 5;
    UILabel *joinRoomUserIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, 30.f)];
    joinRoomUserIdLabel.text = @"用户id:";
    [scrollView addSubview:joinRoomUserIdLabel];
    
    height = CGRectGetMaxY(joinRoomUserIdLabel.frame) + 5;
    self.userIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(padding, height, width-padding*2, 30.f)];
    self.userIdTextField.layer.borderWidth = 1;
    self.userIdTextField.layer.borderColor = [UIColor grayColor].CGColor;
    self.userIdTextField.text = kTest_UserId;//@"6182486831";
    [scrollView addSubview:self.userIdTextField];
    
    // msg
    height = CGRectGetMaxY(self.userIdTextField.frame) + 5;
    UILabel *pushMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height, width, 30.f)];
    pushMsgLabel.text = @"下发消息:";
    [scrollView addSubview:pushMsgLabel];
    
    height = CGRectGetMaxY(pushMsgLabel.frame) + 5;
    self.pushMsgTextView = [[UITextView alloc] initWithFrame:CGRectMake(padding, height, width-padding*2, 160.f)];
    self.pushMsgTextView.layer.borderWidth = 1;
    self.pushMsgTextView.layer.borderColor = [UIColor grayColor].CGColor;
    [scrollView addSubview:self.pushMsgTextView];
    
    
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, height + 200)];
    
    [self initSubView];
    
    [self _registerSDK];
    [[WBIMLiveManager sharedInstance] addListener:self];
}

- (void)viewWillUnload {
    [[WBIMLiveManager sharedInstance] removeListener:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
    [super viewWillDisappear:animated];
}

- (void)showAlert:(NSString*)title content:(NSString*)content {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                       message:content
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"收到网络回调", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}


- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}


- (void)ssoOutButtonPressed
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}

- (void)createLive{
    NSData* data = nil;
    NSString* result  = nil;
    
    if(self.textSwitch.on){
        NSString* accesstoken = self.textToken.text;
        NSString* content = content =  self.textCreateInput.text;
        data=[content dataUsingEncoding:NSUTF8StringEncoding];
        result = [self.weiboLiveSDK createLive:accesstoken data:data];
    }
    else{
        NSString* token = self.textCreateToken.text;
        NSString* title = self.textCreateTitle.text;
        NSString* width = self.textCreateWidth.text;
        NSString* height = self.textCreateHeight.text;
        NSString* summary = self.textCreateSummary.text;
        NSString* published = self.textCreatePublished.text;
        NSString* image = self.textCreateImage.text;
        NSString* replay = self.textCreateReplay.text;
        NSString* pano = self.textCreatePano.text;
        if([token  isEqual: @""]){
            token = nil;
        }
        if([token  isEqual: @""]){
            token = nil;
        }if([title  isEqual: @""]){
            title = nil;
        }if([width  isEqual: @""]){
            width = nil;
        }if([height  isEqual: @""]){
            height = nil;
        }if(!self.switchCreateSummary.on){
            summary = nil;
        }if(!self.switchCreatePublished.on){
            published = nil;
        }if(!self.switchCreateImage.on){
            image = nil;
        }if(!self.switchCreateReplay.on){
            replay = nil;
        }if(!self.switchCreatePano.on){
            pano = nil;
        }
        result = [self.weiboLiveSDK createLive:token title:title width:width height:height summary:summary published:published image:image replay:replay is_panolive:pano];
    }
    
    if(result != nil){
        NSData* rd = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:rd options:NSJSONReadingMutableLeaves error:nil];
        NSString * liveid = [dataDic objectForKey:@"id"];
        NSString* room_id = [dataDic objectForKey:@"room_id"];
        if(liveid != nil && room_id != nil){
            //
            NSString* accesstoken = nil;
            if(self.textSwitch.on){
                accesstoken = self.textToken.text;
            }
            else{
                accesstoken = self.textCreateToken.text;
            }
            
            NSString* tokenid = @"";
            tokenid = [tokenid stringByAppendingString:[NSString stringWithFormat:@"access_token=%@&id=%@", accesstoken, liveid]];
            self.textUpdateInput.text = tokenid;
            self.textShowInput.text = tokenid;
            self.textDeleteInput.text = tokenid;
            
            self.textUpdateID.text = liveid;
            self.textShowID.text = liveid;
            self.textDeleteID.text = liveid;
            
            // 创建完成之后，更新到互动哪里
            self.userIdTextField.text = self.textUid.text;
            self.joinRoomTokenTextField.text = accesstoken ? accesstoken : @"";
            self.roomIdTextField.text = room_id;
        }
    }
    
    NSString *alert_title = @"创建直播返回消息";
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:alert_title
                                       message:result
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)updateLive{
    NSData* data = nil;
    NSString* result  = nil;

    if(self.textSwitch.on){
        NSString* accesstoken = self.textToken.text;
        NSString* content = content =  self.textUpdateInput.text;
        data=[content dataUsingEncoding:NSUTF8StringEncoding];
        result = [self.weiboLiveSDK updateLive:accesstoken data:data];
    }
    else{
        NSString* token = self.textUpdateToken.text;
        NSString* liveid = self.textUpdateID.text;
        NSString* title = self.textUpdateTitle.text;
        NSString* summary = self.textUpdateSummary.text;
        NSString* published = self.textUpdatePublished.text;
        NSString* image = self.textUpdateImage.text;
        NSString* stop = self.textUpdateStop.text;
        NSString* replayurl = self.textUpdateReplayurl.text;
        if([token  isEqual: @""]){
            token = nil;
        }
        if([token  isEqual: @""]){
            token = nil;
        }if([liveid  isEqual: @""]){
            liveid = nil;
        }if(!self.switchUpdateTitle.on){
            title = nil;
        }if(!self.switchUpdateSummary.on){
            summary = nil;
        }if(!self.switchUpdatePublished.on){
            published = nil;
        }if(!self.switchUpdateImage.on){
            image = nil;
        }if(!self.switchUpdateStop.on){
            stop = nil;
        }if(!self.switchUpdateReplayurl.on){
            replayurl = nil;
        }
        result = [self.weiboLiveSDK updateLive:token liveid:liveid title:title summary:summary published:published image:image stop:stop replay_url:replayurl];
    }
    
    NSString *alert_title = @"更新直播返回消息";
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:alert_title
                                       message:result
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)showLive{

    NSData* data = nil;
    NSString* result  = nil;
    
    if(self.textSwitch.on){
        NSString* accesstoken = self.textToken.text;
        NSString* content = self.textShowInput.text;
        data=[content dataUsingEncoding:NSUTF8StringEncoding];
        result = [self.weiboLiveSDK showLive:accesstoken data:data];
    }
    else{
        NSString* token = self.textShowToken.text;
        NSString* liveid = self.textShowID.text;
        NSString* detail = self.textShowDetail.text;

        if([token  isEqual: @""]){
            token = nil;
        }if([liveid  isEqual: @""]){
            liveid = nil;
        }if(!self.switchShwoDetail.on){
            detail = nil;
        }
        result = [self.weiboLiveSDK showLive:token liveid:liveid detail:detail];
    }
    
    NSString *title = @"获取直播信息返回消息";
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:result
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)deleteLive{

    NSData* data = nil;
    NSString* result  = nil;
    if(self.textSwitch.on){
        NSString* accesstoken = self.textToken.text;
        NSString* content = self.textDeleteInput.text;
        data=[content dataUsingEncoding:NSUTF8StringEncoding];
        result = [self.weiboLiveSDK deleteLive:accesstoken data:data];
    }
    else{
        NSString* token = self.textDeleteToken.text;
        NSString* liveid = self.textDeleteID.text;
        
        if([token  isEqual: @""]){
            token = nil;
        }
        if([token  isEqual: @""]){
            token = nil;
        }
        
        result = [self.weiboLiveSDK deleteLive:token liveid:liveid];
    }
    
    NSString *title = @"删除直播返回信息";
    UIAlertView *alert = nil;
    
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:result
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

-(void)switchChange{
    [self initSubView];
}

-(void)initSubView{
    if(!self.textSwitch.on){
    
        self.textCreateInput.hidden = YES;
        self.textCreateToken.hidden = NO;
        self.textCreateTitle.hidden = NO;
        self.textCreateWidth.hidden = NO;
        self.textCreateHeight.hidden = NO;
        self.textCreateSummary.hidden = NO;
        self.textCreatePublished.hidden = NO;
        self.textCreateImage.hidden = NO;
        self.textCreateReplay.hidden = NO;
        self.textCreatePano.hidden = NO;
        
        self.textUpdateInput.hidden = YES;
        self.textUpdateToken.hidden = NO;
        self.textUpdateID.hidden = NO;
        self.textUpdateTitle.hidden = NO;
        self.textUpdateSummary.hidden = NO;
        self.textUpdatePublished.hidden = NO;
        self.textUpdateImage.hidden = NO;
        self.textUpdateStop.hidden = NO;
        self.textUpdateReplayurl.hidden = NO;
        
        self.textShowInput.hidden = YES;
        self.textShowToken.hidden = NO;
        self.textShowID.hidden = NO;
        self.textShowDetail.hidden = NO;
        
        self.textDeleteInput.hidden = YES;
        self.textDeleteToken.hidden = NO;
        self.textDeleteID.hidden = NO;
        
    }
    else{
        self.textCreateInput.hidden = NO;
        self.textCreateToken.hidden = YES;
        self.textCreateTitle.hidden = YES;
        self.textCreateWidth.hidden = YES;
        self.textCreateHeight.hidden = YES;
        self.textCreateSummary.hidden = YES;
        self.textCreatePublished.hidden = YES;
        self.textCreateImage.hidden =YES;
        self.textCreateReplay.hidden = YES;
        self.textCreatePano.hidden = YES;
        
        self.textUpdateInput.hidden = NO;
        self.textUpdateToken.hidden = YES;
        self.textUpdateID.hidden = YES;
        self.textUpdateTitle.hidden = YES;
        self.textUpdateSummary.hidden = YES;
        self.textUpdatePublished.hidden = YES;
        self.textUpdateImage.hidden = YES;
        self.textUpdateStop.hidden = YES;
        self.textUpdateReplayurl.hidden = YES;
        
        self.textShowInput.hidden = NO;
        self.textShowToken.hidden = YES;
        self.textShowID.hidden = YES;
        self.textShowDetail.hidden = YES;
        
        self.textDeleteInput.hidden = NO;
        self.textDeleteToken.hidden = YES;
        self.textDeleteID.hidden =YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self setEditing:NO];
}

#pragma mark - interaction
- (void)_registerSDK {
    WBIMUser *user = [[WBIMUser alloc] init];
    user.uid = 2608799093;
    user.nickname = @"jokan";
    user.token = @"2.00C5euDEMhHgLIcee3fe37c4ILZqLC";
    WBIMBundle *bundle = [[WBIMBundle alloc] init];
    bundle.userAgent = @"x86_64__weibo__6.6.1__iphone__os9.3";
    bundle.from = @"1066193010";
    bundle.wm = @"3333_2001";
    [[WBIMLiveManager sharedInstance] registerWithBundle:bundle user:user];
}

- (void)onJoinRoomBtnPressed:(UIView*)sender {
    NSString *token = self.joinRoomTokenTextField.text;
    NSString *userId = self.userIdTextField.text;
    NSString *roomId = self.roomIdTextField.text;
    NSString *name = @"";
    
    WBIMUser *user = [[WBIMUser alloc] init];
    user.uid = [userId longLongValue];
    user.nickname = name;
    user.token = token;
    WBIMBundle *bundle = [[WBIMBundle alloc] init];
    //bundle.userAgent = @"x86_64__weibo__6.6.1__iphone__os9.3";
    //bundle.from = @"1066193010";
    //bundle.wm = @"3333_2001";
    
    bundle.userAgent = @"abc";
    bundle.from = @"abc";
    bundle.wm = @"abc";
    
    [[WBIMLiveManager sharedInstance] changeUser:user bundle:bundle];
    
    WBIMJoinRoomRequest *request = [[WBIMJoinRoomRequest alloc] init];
    request.roomId = roomId;
    [[WBIMLiveManager sharedInstance] joinLiveRoom:request succ:^(NSString *requestId, WBIMJoinRoomModel *response) {
        [self showAlert:@"提示" content:@"加入房间成功"];
    } fail:^(NSString *requestId, NSInteger code, NSString *msg) {
        NSString *info = [NSString stringWithFormat:@"加入房间失败， code = %ld, msg = %@", code, msg];
        [self showAlert:@"警告" content:info];
    }];
}

- (void)onExitRoomBtnPressed:(UIView*)sender {
    
    WBIMExitRoomRequest *request = [[WBIMExitRoomRequest alloc] init];
    request.roomId = self.roomIdTextField.text;
    [[WBIMLiveManager sharedInstance] exitLiveRoom:request succ:^(NSString *requestId) {
        self.pushMsgTextView.text = @"";
        [self showAlert:@"提示" content:@"退出房间成功"];
    } fail:^(NSString *requestId, NSInteger code, NSString *msg) {
        [self showAlert:@"警告" content:@"退出房间失败"];
    }];
}

#pragma mark - WBIMLiveListener
- (void)didPushConnectionConnect {
    NSLog(@"互动链接");
}
- (void)didPushConnectionDisconnect:(NSInteger)errCode errMsg:(NSString *)errMsg {
    [self showAlert:@"警告" content:@"互动断开"];
}

- (void)onNewMessage:(WBIMPushMessageModel *)msg requestId:(NSString *)requestId errCode:(NSInteger)errCode
              errMsg:(NSString *)errMsg {
    if (!errCode) {
        NSString *resInfo = [NSString stringWithFormat:@"requestId = %@, type = %ld, sysMsgType = %ld", requestId, msg.type, msg.sysMsgType];
        NSString *typeInfo = @"";
        switch (msg.type) {
            case WBIMMsgText: // 聊天信息
                typeInfo = @"聊天";
                break;
            case WBIMMsgPraise: // 赞
                typeInfo = @"赞";
                break;
            case WBIMMsgLightAnchor: // 点亮主播
                typeInfo = @"点亮主播";
                break;
            case WBIMMsgShutup: // 禁言 = 拉黑
                typeInfo = @"禁言";
                break;
            case WBIMMsgRoomStatus: // 礼物消息
                typeInfo = @"l礼物";
                break;
            case WBIMMsgNotification: // 公告
                typeInfo = @"公告";
                break;
            case WBIMMsgShareLiveRoom: // 分享
                typeInfo = @"分享";
                break;
            case WBIMMsgAttendAnchor: // 关注主播
                typeInfo = @"关注主播";
                break;
            case WBIMMsgAddToChartm: // 加入购物车
            case WBIMMsgCommodity: // 商品
                break;
            case WBIMMsgLiveStatusChange: // 直播状态
                typeInfo = @"直播状态";
                break;
            case WBIMMsgJoinOrExitRoom: // 进出直播间
                typeInfo = @"进入或退出房间";
                break;
            case WBIMMsgReward: // 打赏
                break;
            case WBIMMsgAdminChange: // 管理员变更 = 场控
                typeInfo = @"管理员变更";
                break;
            case WBIMMsgSystem: // 系统消息
                typeInfo = [self onSystemMessage:msg];
                break;
            case 16: {//WBIMMsgTop: // 置顶/取消置顶评论消息
                typeInfo = @"置顶或取消置顶";
                break;
            }
            case WBIMMsgCustom: // 自定义消息
                break;
            default:
                break;
        }
        
        NSString *outText = [NSString stringWithFormat:@"收到下发消息：%@， 类型：%@消息", resInfo, typeInfo];
        NSMutableString *text = [[NSMutableString alloc] initWithString:self.pushMsgTextView.text];
        [text appendFormat:@"%@\n\n", outText];
        self.pushMsgTextView.text = text;
    }
}

- (NSString*)onSystemMessage:(WBIMPushMessageModel*)msg {
    if(!msg.extension || msg.extension.length == 0){
        return @"";
    }
    
    NSString *typeInfo = @"";
    switch (msg.sysMsgType) {
        case WBIMSysMsgShowcase: // 橱窗
            typeInfo = @"橱窗";
            break;
        case WBIMSysMsgStreamMode: // 流状态
            break;
        case WBIMSysMsgDepositIssue: // 充值下发
            typeInfo = @"充值下发";
            break;
        case WBIMSysMsgReview: // 审核
            typeInfo = @"审核";
            break;
        case WBIMSysMsgActivityMark: // 活动角标
            typeInfo = @"活动角标";
            break;
        case WBIMSysMsgUserList: // 观众列表
            typeInfo = @"观众列表";
            break;
        case WBIMSysMsgAnchorCoinsChange: // 主播金币变化
            typeInfo = @"主播金币变化";
            break;
        default:
            break;
    }
    return typeInfo;
}
@end

