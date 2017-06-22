
#import "WeiboLiveSDK.h"

#import <CommonCrypto/CommonCrypto.h>

NSString * const WBSDKCreateLiveUrl = @"https://api.weibo.com/2/proxy/live/create";
NSString * const WBSDKUpdateLiveUrl = @"https://api.weibo.com/2/proxy/live/update";
NSString * const WBSDKDeleteLiveUrl = @"https://api.weibo.com/2/proxy/live/delete";
NSString * const WBSDKShowLiveUrl   = @"https://api.weibo.com/2/proxy/live/show";
NSString * const WBSDKUploadPicLiveUrl = @"https://api.weibo.com/statuses/upload_pic.json";
NSString * const WBSDKMessageSync = @"https://api.weibo.com/2/liveim/message/sync.json";
NSString * const WBSDKMessagePull = @"https://barrage.api.weibo.com/2/liveim/message/pull.stream";
NSString * const WBSDKAuthen = @"https://api.weibo.com/2/proxy/live2/user/authed";

@interface WeiboLiveSDK()

- (NSString *) httpSynRequest:(NSString*)dataSource method:(NSString*)methods content:(NSData *)content;
- (BOOL) WBliveDetAuthority:(NSString *)access_token;
- (BOOL) openAuthScheme:(NSString *)scheme;


- (NSString *) createLive:(NSString *)access_token data:(NSData *)data;
- (NSString *) updateLive:(NSString *)access_token data:(NSData *)data;
- (NSString *) deleteLive:(NSString *)access_token data:(NSData *)data;
- (NSString *) showLive:(NSString *)access_token data:(NSData *)data;


- (NSString *) createLive:(NSData *)data;
- (NSString *) updateLive:(NSData *)data;
- (NSString *) deleteLive:(NSData *)data;
- (NSString *) showLive:(NSData *)data;
- (NSString *) uploadPic:(NSData *)data;
- (NSString *) messageSync:(NSData *)data;

- (NSString *) uploadPic:(NSString *)access_token data:(NSData *)data;
- (NSString *) messageSync:(NSString *)access_token data:(NSData *)data;


- (NSString *) uploadPic:(NSString *)access_token
                     pic:(NSData*)pic
              print_mark:(int)print_mark
                     ori:(int)ori;

- (NSString *) messageSync:(NSString *)access_token
                   room_id:(NSString*)room_id
                        ts:(long)ts
                  msg_type:(int)msg_type
                   content:(NSString*)content
                       uid:(long)uid
                  nickname:(NSString*)nickname
                    avatar:(NSString*)avatar
                      sign:(NSString*)sign
                 extension:(NSString*)extension
                    offset:(long)offset;

////
- (NSString *) messageSync:(NSString *)access_token
                   room_id:(NSString*)room_id
                        ts:(long)ts
                  msg_type:(int)msg_type
                   content:(NSString*)content
                       uid:(long)uid
                  nickname:(NSString*)nickname
                    avatar:(NSString*)avatar
                 appsecret:(NSString*)appsecret
                 extension:(NSString*)extension
                    offset:(long)offset;

////
- (NSString *) generateMessageSyncSignData:(NSString *)access_token
                                   room_id:(NSString*)room_id
                                        ts:(long)ts
                                  msg_type:(int)msg_type
                                   content:(NSString*)content
                                       uid:(long)uid
                                  nickname:(NSString*)nickname
                                    avatar:(NSString*)avatar
                                 extension:(NSString*)extension
                                    offset:(long)offset;

-(NSString*) signMessageSyncData:(NSString*)data appsecret:(NSString*)appsecret;


@end

@implementation WeiboLiveSDK

- (instancetype) init {
    self = [super init];
    return self;
}

- (NSString *) createLive:(NSData *)data{
    NSString* result =  [self httpSynRequest:WBSDKCreateLiveUrl method:@"post" content:data];
    NSLog(@"%@", result);
    return result;
}

- (NSString *) updateLive:(NSData *)data{
    NSString* result = [self httpSynRequest:WBSDKUpdateLiveUrl method:@"post" content:data];
    NSLog(@"%@", result);
    return result;
}

- (NSString *) deleteLive:(NSData *)data{
    NSString* result = [self httpSynRequest:WBSDKDeleteLiveUrl method:@"post" content:data];
    NSLog(@"%@", result);
    return result;
}

- (NSString *) showLive:(NSData *)data{
    NSString* result = [self httpSynRequest:WBSDKShowLiveUrl method:@"post" content:data];
    NSLog(@"%@", result);
    return result;
}

- (NSString *) uploadPic:(NSData *)data{
    NSString* result = [self httpSynRequest:WBSDKUploadPicLiveUrl method:@"post" content:data];
    NSLog(@"%@", result);
    return result;
}

- (NSString *) messageSync:(NSData *)data{
    NSString* result = [self httpSynRequest:WBSDKMessageSync method:@"post" content:data];
    NSLog(@"%@", result);
    return result;
}


- (NSString *) createLive:(NSString *)access_token data:(NSData *)data{
    if(![self WBliveDetAuthority:access_token]){
        return nil;
    }
    
    return [self createLive:data];
}

- (NSString *) updateLive:(NSString *)access_token data:(NSData *)data{
    /*if(![self WBliveDetAuthority:access_token]){
        return nil;
    }
    */
    return [self updateLive:data];
}

- (NSString *) deleteLive:(NSString *)access_token data:(NSData *)data{
   /* if(![self WBliveDetAuthority:access_token]){
        return nil;
    }*/
    
    return [self deleteLive:data];
}

- (NSString *) showLive:(NSString *)access_token data:(NSData *)data{
    /*if(![self WBliveDetAuthority:access_token]){
        return nil;
    }*/
    
    return [self showLive:data];
}

- (NSString *) uploadPic:(NSString *)access_token data:(NSData *)data{
    if(![self WBliveDetAuthority:access_token]){
        return nil;
    }
    
    return [self uploadPic:data];
}

- (NSString *) messageSync:(NSString *)access_token data:(NSData *)data{
    if(![self WBliveDetAuthority:access_token]){
        return nil;
    }
    
    return [self uploadPic:data];
}



- (NSString *) createLive:(NSString *)access_token
                    title:(NSString*)title
                    width:(NSString*)width
                   height:(NSString*)height
                  summary:(NSString*)summary
                published:(NSString*)published
                    image:(NSString*)image
                   replay:(NSString*)replay
              is_panolive:(NSString*)is_panolive{
    
    NSString *request = [NSString stringWithFormat:@"access_token=%@&title=%@&width=%@&height=%@", access_token, title, width, height];
    if(summary != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&summary=%@", summary]];
    }
    if(published != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&published=%@", published]];
    }
    if(image != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&image=%@", image]];
    }if(replay != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&replay=%@", replay]];
    }if(is_panolive != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&is_panolive=%@", is_panolive]];
    }
    NSLog(@"%@", request);
    NSData* rd = [request dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self createLive:access_token data:rd];
}


- (NSString *) updateLive:(NSString *)access_token
                   liveid:(NSString*)liveid
                    title:(NSString*)title
                  summary:(NSString*)summary
                published:(NSString*)published
                    image:(NSString*)image
                     stop:(NSString*)stop
               replay_url:(NSString*)replay_url{
    
    NSString *request = [NSString stringWithFormat:@"access_token=%@&id=%@", access_token, liveid];
    if(title != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&title=%@", title]];
    }
    if(summary != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&summary=%@", summary]];
    }
    if(published != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&published=%@", published]];
    }
    if(image != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&image=%@", image]];
    }
    if(stop != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&stop=%@", stop]];
    }
    if(replay_url != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&replay_url=%@", replay_url]];
    }
    NSLog(@"%@", request);
    NSData* rd = [request dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self updateLive:access_token data:rd];
}


- (NSString *) deleteLive:(NSString *)access_token
                   liveid:(NSString*)liveid{

    NSString *request = [NSString stringWithFormat:@"access_token=%@&id=%@", access_token, liveid];
    NSLog(@"%@", request);
    NSData* rd = [request dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self deleteLive:access_token data:rd];

}


- (NSString *) showLive:(NSString *)access_token
                 liveid:(NSString*)liveid
                 detail:(NSString*)detail{
    
    NSString *request = [NSString stringWithFormat:@"access_token=%@&id=%@", access_token, liveid];
    if(detail != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&detail=%@", detail]];
    }
    NSLog(@"%@", request);
    NSData* rd = [request dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self showLive:access_token data:rd];
}


- (NSString *) uploadPic:(NSString *)access_token
                     pic:(NSData*)pic
              print_mark:(int)print_mark
                     ori:(int)ori{

    NSString *tokenpic = [NSString stringWithFormat:@"access_token=%@&pic=", access_token];
    NSData * tokenpicd =[tokenpic dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableData* rd = [NSMutableData alloc];
    [rd appendBytes:tokenpicd.bytes length:tokenpicd.length];
    [rd appendBytes:pic.bytes length:pic.length];
    
    if(print_mark == 0 || print_mark == 1){
        NSString *printmarks = [NSString stringWithFormat:@"&print_mark=%d", print_mark];
        NSData * printmarkd = [printmarks dataUsingEncoding:NSUTF8StringEncoding];
        [rd appendBytes:printmarkd.bytes length:printmarkd.length];

    }
    
    if(ori == 0 || ori == 1){
        NSString *oris = [NSString stringWithFormat:@"&ori=%d", ori];
        NSData * orid = [oris dataUsingEncoding:NSUTF8StringEncoding];
        [rd appendBytes:orid.bytes length:orid.length];
    }
    
    
    return [self uploadPic:access_token data:rd];
}

- (NSString *) messageSync:(NSString *)access_token
                   room_id:(NSString*)room_id
                        ts:(long)ts
                  msg_type:(int)msg_type
                   content:(NSString*)content
                       uid:(long)uid
                  nickname:(NSString*)nickname
                    avatar:(NSString*)avatar
                      sign:(NSString*)sign
                 extension:(NSString*)extension
                    offset:(long)offset{
    
    NSString* request = [self generateMessageSyncSignData:access_token room_id:room_id ts:ts msg_type:msg_type content:content uid:uid nickname:nickname avatar:avatar extension:extension offset:offset];
    
    request = [request stringByAppendingString:[NSString stringWithFormat:@"&sign=%@", sign]];
    NSLog(@"%@", request);
    NSData* rd = [request dataUsingEncoding:NSUTF8StringEncoding];
    
    return [self messageSync:access_token data:rd];
}

- (NSString *) messageSync:(NSString *)access_token
                   room_id:(NSString*)room_id
                        ts:(long)ts
                  msg_type:(int)msg_type
                   content:(NSString*)content
                       uid:(long)uid
                  nickname:(NSString*)nickname
                    avatar:(NSString*)avatar
                 appsecret:(NSString*)appsecret
                 extension:(NSString*)extension
                    offset:(long)offset{
    
    NSString* request = [self generateMessageSyncSignData:access_token room_id:room_id ts:ts msg_type:msg_type content:content uid:uid nickname:nickname avatar:avatar extension:extension offset:offset];
    
    NSString* sign = [self signMessageSyncData:request appsecret:appsecret];
 
    return [self messageSync:access_token room_id:room_id ts:ts msg_type:msg_type content:content uid:uid nickname:nickname avatar:avatar sign:sign extension:extension offset:offset];
}

- (NSString *) generateMessageSyncSignData:(NSString *)access_token
                                   room_id:(NSString*)room_id
                                        ts:(long)ts
                                  msg_type:(int)msg_type
                                   content:(NSString*)content
                                       uid:(long)uid
                                  nickname:(NSString*)nickname
                                    avatar:(NSString*)avatar
                                 extension:(NSString*)extension
                                    offset:(long)offset{
    NSString *request = [NSString stringWithFormat:@"access_token=%@&avatar=%@&content=%@", access_token, avatar,content];
    if(extension != nil){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&extension=%@", extension]];
    }
    
    request = [request stringByAppendingString:[NSString stringWithFormat:@"&msg_type=%d&nickname=%@", msg_type, nickname]];
    
    if(offset > 0){
        request = [request stringByAppendingString:[NSString stringWithFormat:@"&offset=%ld", offset]];
    }
    
    request = [request stringByAppendingString:[NSString stringWithFormat:@"&room_id=%@&ts=%ld&uid=%ld", room_id,ts,uid]];
    
    return request;
}

-(NSString*) signMessageSyncData:(NSString*)data appsecret:(NSString*)appsecret{
    const char * ccucms =[data UTF8String];
    const char * ccak =[appsecret UTF8String];
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, ccak, strlen(ccak), ccucms, strlen(ccucms), buffer);
    
    NSData *hashdata=[NSData dataWithBytes:buffer length:CC_MD5_DIGEST_LENGTH];
    
    NSString *base64Str = [hashdata base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    
    NSMutableString * safeBase64Str = [[NSMutableString alloc]initWithString:base64Str];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    safeBase64Str = (NSMutableString * )[safeBase64Str stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    
    NSRange range = {6, 10};
    NSString *sign = [safeBase64Str substringWithRange:range];
    
    return sign;
}

- (NSString *) httpSynRequest:(NSString*)dataSource method:(NSString*)methods content:(NSData *)content{
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURL *url = [NSURL URLWithString:dataSource];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = methods;
    request.HTTPBody = content;
    
    __block NSString *result = nil;
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && (error == nil)) {
            result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        } else {
            result = nil;
        }
        dispatch_semaphore_signal(semaphore);
    }];
    
    [task resume];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    return result;
    
}

- (BOOL) openAuthScheme:(NSString *)scheme {
    
    if ([[UIApplication sharedApplication]
         canOpenURL:[NSURL URLWithString:scheme]]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:scheme]];
    }
    else{
        NSString* download = @"http://m.weibo.cn/feature/download/index";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:download]];
    }
    
    return YES;
}

- (BOOL) WBliveDetAuthority:(NSString *)access_token{
    NSString *request = [NSString stringWithFormat:@"access_token=%@", access_token];
    NSData* requestd = [request dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * result = nil;
    result =[self httpSynRequest:WBSDKAuthen method:@"post" content:requestd];
    if(result == nil){
        return NO;
    }
    
    NSData* data=[result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dataDic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSNumber * authcode = [dataDic objectForKey:@"auth_code"];
    if(authcode == nil){
        return NO;
    }
    
    int authcodeInt = [authcode intValue];
    if(authcodeInt == 1 || authcodeInt == 4 || authcodeInt == 7){
        return YES;
    }
    else if(authcodeInt == 6 || authcodeInt == 8 || authcodeInt == 9 || authcodeInt == 10 || authcodeInt == 13){
        NSString* scheme = [dataDic objectForKey:@"scheme_url"];
        if(scheme == nil){
            return NO;
        }
        else{
            [self openAuthScheme:scheme];
            return NO;
        }
    }
    else{
        //authcodeInt=2,3,5,11,12;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"此账号不能进行微博直播，请更换账号"
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        
        return NO;
    }
}


@end

