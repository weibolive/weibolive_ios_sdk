//
//  WBIMSendGiftModel.h
//  SinaLiveSDK
//
//  Created by lizhi7 on 2017/2/27.
//  Copyright © 2017年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"


@interface WBIMSendGiftInfoModel : WBIMBaseModel

@property (nonatomic, copy) NSString *giftId; //礼物id
@property (nonatomic, copy) NSString *name; //礼物名字，以id为准，礼物名字在最后一次下发可能为空
@property (nonatomic, assign) int type; //礼物类型，1表示普通礼物，2表示连击礼物
@property (nonatomic, assign) int totalNum; //当前总共送出有效礼物数 type=2时才有效

@end


@interface WBIMSendGiftModel : WBIMBaseModel

@property (nonatomic, assign) long long currentCoins; //当前金币数，无变化为-1
@property (nonatomic, assign) long long giftAvailableNum; //礼物可购买数，无变化为-1
@property (nonatomic, assign) unsigned long long anchorCoins; //主播金币数
@property (nonatomic, strong) WBIMSendGiftInfoModel *giftInfo;

@end
