#
# Be sure to run `pod lib lint AxcPermission.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AxcPermission'
    s.version          = '0.1.0'
    s.summary          = 'This is a tool library for checking/requesting system permissions in iOS and macOS'
    
    s.description      = <<-DESC
    This is a tool library for checking/requesting system permissions in iOS and macOS
    DESC
    
    s.homepage         = 'https://github.com/AxcLogo/AxcPermission-Swift'
    
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    
    s.author           = { 'AxcLogo' => 'axclogo@163.com' }
    
    s.source           = { :git => 'https://github.com/AxcLogo/AxcPermission.git', :tag => s.version.to_s }
    
    s.ios.deployment_target = '10.0'
    
    fileType = "{swift,h,m,mm,cpp}"
    
    s.source_files = "AxcPermission/Classes/**/*.#{fileType}"
    s.pod_target_xcconfig = {
        'CODE_SIGNING_ALLOWED' => 'NO'
    }
    
    s.swift_version = '5.0'

    s.dependency 'AxcBedrock/Core'
    
    # 核心
    s.subspec 'Core' do |c|
        c.source_files = "AxcPermission/Classes/Core/**/*.#{fileType}"
        s.dependency 'AxcBedrock/Core'
    end
    
    # 相机
    s.subspec 'Camera' do |c|
        c.source_files = "AxcPermission/Classes/Camera/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # Idfa
    s.subspec 'Idfa' do |c|
        c.source_files = "AxcPermission/Classes/Idfa/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # 定位
    s.subspec 'Location' do |c|
        c.source_files = "AxcPermission/Classes/Location/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # 麦克风
    s.subspec 'Microphone' do |c|
        c.source_files = "AxcPermission/Classes/Microphone/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # 通知
    s.subspec 'Notification' do |c|
        c.source_files = "AxcPermission/Classes/Notification/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # 相册
    s.subspec 'PhotoAlbum' do |c|
        c.source_files = "AxcPermission/Classes/PhotoAlbum/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # 通讯录
    s.subspec 'AddressBook' do |c|
        c.source_files = "AxcPermission/Classes/AddressBook/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # 日历
    s.subspec 'Calendar' do |c|
        c.source_files = "AxcPermission/Classes/Calendar/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    # 提醒事项
    s.subspec 'RemindEvent' do |c|
        c.source_files = "AxcPermission/Classes/RemindEvent/**/*.#{fileType}"
        c.dependency 'AxcPermission/Core'
    end
    
    
end
