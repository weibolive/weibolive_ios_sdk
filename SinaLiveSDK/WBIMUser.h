//
//  WBIMUser.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"

typedef NS_ENUM(NSInteger, WBIMUserAuthType) {
    WBIMUserNotV,
    WBIMUserBlueV,
    WBIMUserYellowV,
};

@interface WBIMUser : WBIMBaseModel

@property (nonatomic, assign) long long uid; //用户ID
@property (nonatomic, copy) NSString *nickname; //昵称
@property (nonatomic, copy) NSString *avatar; //头像
@property (nonatomic, copy) NSString *token; //用户token，仅限微博内部用户
@property (nonatomic, copy) NSString *desc; //用户简介
@property (nonatomic, copy) NSString *verifiedReason; //微认证
@property (nonatomic, assign) NSUInteger statusesCount; //微博数
@property (nonatomic, assign) long long followersCount; //粉丝数
@property (nonatomic, assign) long long attentionCount; //用户关注数
@property (nonatomic, assign) NSInteger level; //用户等级
@property (nonatomic, assign) long long joinTime; //进入房间时间
@property (nonatomic, assign) NSInteger role; //0：主播 1：普通成员
@property (nonatomic, assign) long long silenceTime; //禁言剩余时间
@property (nonatomic, assign) BOOL isFollowed; //是否关注了该用户
@property (nonatomic, assign) BOOL isVIP; //是否是微博会员
@property (nonatomic, assign) WBIMUserAuthType userAuthType; //微博认证大V 0：不是 1：蓝V 2：黄V
@property (nonatomic, copy) NSString *userSystem; //用户所属系统

@end
