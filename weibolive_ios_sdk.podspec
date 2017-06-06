Pod::Spec.new do |s|
  s.name         = "WeiboLiveSDK"
  s.homepage     = "https://github.com/weibolive/weibolive_ios_sdk"
  s.summary      = "WeiboLiveSDK on iOS."
  s.author       = { "guilu" => "guilu@staff.weibo.com" }
  s.version      = "0.0.1"
  s.source       = { :git => "https://github.com/weibolive/weibolive_ios_sdk.git", :tag => "0.0.1" }
  s.platform     = :ios, '6.0'
  s.requires_arc = false
  s.license      = 'MIT'
  s.source_files = 'libWeiboLiveSDK/*.{h,m}'
  s.vendored_libraries  = 'libWeiboLiveSDK/libWeiboLiveSDK.a'
end