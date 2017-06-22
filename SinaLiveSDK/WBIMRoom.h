//
//  WBIMRoom.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/11.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"

@interface WBIMRoomSetting : WBIMBaseModel

@property (nonatomic, assign) long long maxOnlines; // 房间允许的最大在线人数
@property (nonatomic, assign) BOOL allowComment; //是否允许发言,0-不允许，1-允许

@end

@interface WBIMRoomCounters : WBIMBaseModel

@property (nonatomic, assign) long long onlines; //当前在线人数
@property (nonatomic, assign) long long praiseCount; //点赞数
@property (nonatomic, assign) NSInteger playCount; //累计播放次数

@end

@interface WBIMRoomOwnerInfo : WBIMBaseModel

@property (nonatomic, assign) long long uid; //主播uid
@property (nonatomic, copy) NSString *userSystem; // 主播所在的用户体系，"0"表示微博

@end

@interface WBIMRoom : WBIMBaseModel

@property (nonatomic, copy) NSString *roomId; //房间ID
@property (nonatomic, assign) long long roomSysId; //
@property (nonatomic, copy) NSString *name; //名称
@property (nonatomic, copy) NSString *picUrl; //
@property (nonatomic, copy) NSString *intro; //简介
@property (nonatomic, copy) NSString *noti; //公告
@property (nonatomic, assign) NSInteger type; //
@property (nonatomic, assign) NSInteger status; //房间当前的状态，0-未开始，1-正在直播，2-已删除，3-结束（可回放），4-推迟，5-结束（不可回放），6-主播离线
@property (nonatomic, assign) NSTimeInterval createdAt; // 创建时间，距离1970-01-01 00:00:00的毫秒数
@property (nonatomic, assign) NSTimeInterval updateTime; // 最后一次更新时间，单位与创建时间相同
@property (nonatomic, strong) WBIMRoomOwnerInfo *ownerInfo; // 主播的信息
@property (nonatomic, strong) WBIMRoomCounters *counters; //统计信息
@property (nonatomic, strong) WBIMRoomSetting *setting; //设置信息

@end
