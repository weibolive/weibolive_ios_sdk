//
//  WBIMPushMessageModel.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"
#import "WBIMRoom.h"
#import "WBIMUser.h"

typedef NS_ENUM(NSInteger, WBIMMsgType) {
    WBIMMsgText = 1,                //聊天信息
    WBIMMsgPraise = 2,              //赞
    WBIMMsgLightAnchor = 3,         //点亮主播
    WBIMMsgShutup = 4,              //禁言
    WBIMMsgRoomStatus = 5,          //礼物消息
    WBIMMsgNotification = 6,        //公告消息
    WBIMMsgShareLiveRoom = 7,       //分享直播消息
    WBIMMsgAttendAnchor = 8,        //关注主播消息
    WBIMMsgAddToChartm = 9,         //加入购物车deprecated
    WBIMMsgCommodity = 10,          //商品消息deprecated
    WBIMMsgLiveStatusChange = 11,   //直播状态变更
    WBIMMsgJoinOrExitRoom = 12,     //加入/退出房间
    WBIMMsgReward = 13,             //打赏消息
    WBIMMsgAdminChange = 14,        //管理员变更消息
    WBIMMsgSystem = 15,             //系统消息
    WBIMMsgCustom = 100,            //自定义消息
};

typedef NS_ENUM(NSInteger, WBIMSysMsgType) {
    WBIMSysMsgShowcase = 1,                 //橱窗
    WBIMSysMsgStreamMode= 2,                //流状态
    WBIMSysMsgDepositIssue = 3,             //充值下发
    WBIMSysMsgReview = 4,                   //审核消息
    WBIMSysMsgActivityMark = 5,             //活动角标
    WBIMSysMsgUserList = 6,                 //用户列表
    WBIMSysMsgAnchorCoinsChange = 7,        //主播金币编号
    WBIMSysMsgOther = 99,                    //其他
};

typedef NS_ENUM(NSInteger, WBIMMsgFormmat) {
    WBIMMsgNormal,                  //普通消息
    WBIMMsgBarrage,                 //弹幕
    WBIMMsgStick,                 //置顶
    WBIMMsgCancelStick,                 //取消置顶
};

@interface WBIMShutInfo : WBIMBaseModel

@property (nonatomic, assign) NSInteger shuttedUntil;
@property (nonatomic, strong) NSArray *members;

@end

@interface WBIMAdminInfo : WBIMBaseModel

@property (nonatomic, strong) WBIMUser *admin;
@property (nonatomic, assign) NSInteger type;

@end

@interface WBIMGiftInfo : WBIMBaseModel

@property (nonatomic, copy) NSString *giftId;       //礼物id
@property (nonatomic, copy) NSString *name;         //礼物名字，以id为准，礼物名字在最后一次下发可能为空
@property (nonatomic, assign) NSInteger type;       //礼物类型，1表示普通礼物，2表示连击礼物
@property (nonatomic, assign) NSInteger totalNum;   //当前总共送出有效礼物数 type=2时才有效
@property (nonatomic, assign) NSInteger incInterval;//礼物增加的时间间隔，单位为ms  type=2时才有效
@property (nonatomic, assign) NSInteger incNum;     //在inc_interval时间内，增加多少个礼物  type=2时才有效

@end


@interface WBIMPushMessageModel : WBIMBaseModel

@property (nonatomic, copy) NSString *roomId;               //房间ID
@property (nonatomic, assign) WBIMMsgType type;             //消息类型
@property (nonatomic, assign) WBIMSysMsgType sysMsgType;    //系统消息子类型
@property (nonatomic, assign) long long messageId;          //消息ID
@property (nonatomic, strong) WBIMUser *senderInfo;         //发送方用户信息
@property (nonatomic, copy) NSString *content;              //消息内容
@property (nonatomic, copy) NSString *extension;            //消息扩展字段
@property (nonatomic, assign) long long offset;             //距离直播开始的时间间隔
@property (nonatomic, assign) WBIMMsgFormmat formmat;       //消息格式，分为普通消息和弹幕
@property (nonatomic, assign) long long praiseCount;        //type=2时，当前总赞数
@property (nonatomic, assign) long long praiseIncrement;    //用户点赞次数
@property (nonatomic, assign) NSInteger liveStatus;         //type=11时，表示直播状态
@property (nonatomic, assign) NSInteger joinOrExit;         //type为12时生效，0：退出 1：进入
@property (nonatomic, strong) WBIMShutInfo *shutInfo;       //被禁言的用户信息
@property (nonatomic, strong) WBIMAdminInfo *adminInfo;     //被增加或删除的用户信息
@property (nonatomic, strong) WBIMRoom *roomInfo;           //房间信息
@property (nonatomic, assign) long long timestamp;          //时间戳
@property (nonatomic, assign) long long praiseInterval;     //赞间隔
@property (nonatomic, assign) long long praiseNum;          //间隔内飘的赞数
@property (nonatomic, assign) long long anchorCoins;        //主播金币信息
@property (nonatomic, strong) WBIMGiftInfo *giftInfo;       //礼物信息
@property (nonatomic, strong) NSDictionary *contentCss;           //消息显示样式
@property (nonatomic, assign) uint32_t praiseStatus;        //消息点赞状态   0或者该字段不存在：未点赞，1为已点赞

@end
