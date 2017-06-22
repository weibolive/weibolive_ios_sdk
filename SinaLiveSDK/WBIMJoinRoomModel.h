//
//  WBIMJoinRoomModel.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"
#import "WBIMUser.h"
#import "WBIMRoom.h"

@interface WBIMJoinRoomModel : WBIMBaseModel

@property (nonatomic, strong) WBIMRoom *roomInfo; //房间信息
@property (nonatomic, strong) WBIMUser *ownerInfo; //主播信息，只包含uid，nickname，avatar，followersCount，level，isFollowed数据
@property (nonatomic, assign) NSInteger role; //用户角色，0:普通 1:主播 2:管理员
@property (nonatomic, assign) NSInteger isShutted; //当前用户在本房间是否被禁言
@property (nonatomic, assign) NSInteger shuttedUntil; //禁言结束的剩余时间，单位s
//@property (nonatomic, assign) NSInteger operationType; //操作类型

@end
