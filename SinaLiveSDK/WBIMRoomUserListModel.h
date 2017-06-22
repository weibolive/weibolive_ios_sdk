//
//  WBIMRoomUserListModel.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"

@interface WBIMRoomUserListModel : WBIMBaseModel

@property (nonatomic, assign) NSInteger memCount; //房间用户数
@property (nonatomic, strong) NSArray *members; //WBIMUser类型的数组，只包含uid，nickname，avater，level，joinTime，role数据，其它数据均为空

@end
