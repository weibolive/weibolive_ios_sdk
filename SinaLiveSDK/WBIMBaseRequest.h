//
//  WBIMBaseRequest.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBIMBaseRequest : NSObject

@end

@interface WBIMJoinRoomRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID

@end

@interface WBIMExitRoomRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID

@end

@interface WBIMCreateRoomRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *name; //房间名
@property (nonatomic, copy) NSString *intro; //简介
@property (nonatomic, copy) NSString *noti; //公告
@property (nonatomic, assign) NSInteger maxMember; //最大人数

@end

@interface WBIMModifyRoomRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *name; //房间名
@property (nonatomic, copy) NSString *intro; //简介
@property (nonatomic, copy) NSString *noti; //公告
@property (nonatomic, assign) NSInteger maxMember; //最大人数

@end

@interface WBIMFetchRoomUserListRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) NSInteger cursor; //查询游标，选填，默认为0
@property (nonatomic, assign) NSInteger count; //查询数量，选填，默认全部
@property (nonatomic, strong) NSArray *roleFilter; //角色过滤，选填，默认全部
@property (nonatomic, strong) NSArray *memberInfoFilter; //成员信息过滤，选填，默认全部

@end

@interface WBIMFetchRoomForbiddenListRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID

@end

@interface WBIMSendMsgRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *content; //消息内容
@property (nonatomic, assign) long long offset; //距离直播开始的时间间隔
@property (nonatomic, assign) NSInteger type; //0：普通消息 1：弹幕
@property (nonatomic, copy) NSString *extension; //扩展字段

@end

@interface WBIMLikeRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) long long praiseCount; //赞数
@property (nonatomic, copy) NSString *extension; //扩展字段

@end

@interface WBIMFollowAnchorRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) long long uid; //主播uid
@property (nonatomic, assign) long long offset; //距离直播开始的时间间隔

@end

@interface WBIMForbidMsgRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) long long offset; //距离直播开始的时间间隔
@property (nonatomic, strong) NSArray *members; //禁言的用户WBIMUser数组,uid必填，其他可选
@property (nonatomic, assign) NSInteger shutupTime; //禁言时长，0为取消禁言

@end

@interface WBIMShareRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *content; //分享内容
@property (nonatomic, copy) NSString *extension; //扩展字段

@end

@interface WBIMAddToCartRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *content; //购物内容
@property (nonatomic, copy) NSString *extension; //扩展字段

@end

@interface WBIMRewardRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *content; //打赏金额
@property (nonatomic, copy) NSString *extension; //扩展字段

@end

@interface WBIMAdministratorRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) long long offset; //距离直播开始的时间间隔
@property (nonatomic, assign) long long uid; //管理员的uid
@property (nonatomic, copy) NSString *userSystem;//管理员所属系统
@property (nonatomic, assign) NSInteger type; //1：增加 2：删除
@property (nonatomic, copy) NSString *nickName;//用户昵称，当添加第三方账号(即 user_system不等于0 并且 type等于1) 时需要带上用户昵称，便于端上显示
@property (nonatomic, copy) NSString *avatar;//用户头像url，当添加第三方账号(即 user_system不等于0 并且 type等于1) 时需要带上用户头像，便于端上显示

@end

@interface WBIMCustomActionRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *content; //打赏金额
@property (nonatomic, copy) NSString *extension; //扩展字段
@property (nonatomic, assign) long long offset; //发送消息时间距离字幕开始的时间间隔

@end

@interface WBIMPlaybackRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, copy) NSString *source; //申请应用时分配的AppKey，调用接口时候代表应用的唯一身份（采用OAuth授权方式不需要此参数）
@property (nonatomic, copy) NSString *extension; //扩展字段
@property (nonatomic, assign) long long startOffset; //开始的offset，单位是s，default为0，demo：10,表示直播开始后第10s
@property (nonatomic, copy) NSString *testRequestUrl; //请求url

@end

@interface WBIMSendGiftRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) long long offset;//发消息时距离字幕开始时的间隔，默认0，表示不支持回放，单位是s
@property (nonatomic, assign) NSInteger finish; //默认为1，用来表示连击礼物时，客户端通知连击效果结束，1表示正常请求，2表示连击结束
@property (nonatomic, copy) NSString *giftId; //礼物ID(必填)
@property (nonatomic, copy) NSString *giftPrice; //单个礼物价格，用来校验礼物价格是否变化(必填)
@property (nonatomic, assign) NSInteger giftNum; //预留字段，购买礼物个数，finish为1时有效(必填)
@property (nonatomic, copy) NSString *secData; //签名信息，用来透传给多媒体(必填)
@property (nonatomic, copy) NSString *extension; //扩展字段

@end


@interface WBIMStickCommentRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) NSInteger type; //操作类型 1 置顶 2 取消置顶
@property (nonatomic, assign) long long mid; //comment id,评论信息的唯一标识

@end

@interface WBIMPraiseCommentRequest : WBIMBaseRequest

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) NSInteger type; //操作类型 1 点赞 2 取消赞
@property (nonatomic, assign) long long mid; //comment id,评论信息的唯一标识

@end


