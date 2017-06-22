//
//  WBIMSendMessageModel.h
//  SinaLiveSDK
//
//  Created by lizhi7 on 2017/3/17.
//  Copyright © 2017年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"
#import "WBIMUser.h"

@interface WBIMSendMessageModel : WBIMBaseModel

@property (nonatomic, copy) NSString *roomId;               //房间ID
@property (nonatomic, assign) long long roomSysId; //
@property (nonatomic, strong) WBIMUser *senderInfo;         //发送方用户信息
@property (nonatomic, assign) long long messageId;                //消息id
@property (nonatomic, copy) NSString *content;              //消息内容
@property (nonatomic, assign) NSTimeInterval createdAt;     // 创建时间

@end
