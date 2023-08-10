//
//  AxcPermissionLib.swift
//  AxcPermissionLib
//
//  Created by 赵新 on 2022/8/10.
//

import Foundation
import AxcBedrock

// MARK: - [AxcPermissionLib.StatusBlock]

public extension AxcPermissionLib {
    /// 状态回调
    typealias StatusBlock = (Status) -> Void
}

// MARK: - [AxcPermissionLib.Status]

public extension AxcPermissionLib {
    /// 授权状态
    enum Status {
        /// 授权访问
        case authorized
        /// 拒绝访问
        case denied
        /// 部分访问
        case limited
        /// 限制访问，用户不能改变客户机的状态,可能由于活跃的限制,如家长控制
        case restricted
        /// 尚未选择，表明用户尚未选择关于客户端是否可以访问硬件
        case notDetermined
        /// 未知
        case unknow

        public struct Info {
            /// 描述
            var description: String
            /// 是否可用
            var isAvailable: Bool
        }

        public var info: Info {
            switch self {
            case .authorized:
                return .init(description: "授权访问",
                             isAvailable: true)
            case .denied:
                return .init(description: "拒绝访问",
                             isAvailable: false)
            case .limited:
                return .init(description: "部分访问",
                             isAvailable: true)
            case .restricted:
                return .init(description: "限制访问，用户不能改变客户机的状态,可能由于活跃的限制,如家长控制",
                             isAvailable: true)
            case .notDetermined:
                return .init(description: "尚未选择，表明用户尚未选择关于客户端是否可以访问硬件",
                             isAvailable: false)
            case .unknow:
                return .init(description: "授权访问",
                             isAvailable: false)
            }
        }
    }
}

// MARK: - [AxcPermissionLib]

open class AxcPermissionLib: NSObject, AxcLibraryTarget {
    
    public var moduleName: String {
        return "AxcPermission"
    }

    public var moduleEmoji: String? {
        return "🔐"
    }
    
}

/*
 1.⚠️必须在info.plst，配置权限，否则崩溃

 NSPhotoLibraryUsageDescription App需要您的同意,才能访问相册
 NSCameraUsageDescription App需要您的同意,才能访问相机
 NSMicrophoneUsageDescription App需要您的同意,才能访问麦克风
 NSLocationUsageDescription App需要您的同意,才能访问位置
 NSCalendarsUsageDescription App需要您的同意,才能访问日历
 NSRemindersUsageDescription App需要您的同意,才能访问提醒事项
 NSMotionUsageDescription App需要您的同意,才能访问运动与健身
 NSHealthUpdateUsageDescription App需要您的同意,才能访问健康更新
 NSHealthShareUsageDescription App需要您的同意,才能访问健康分享
 NSBluetoothPeripheralUsageDescription App需要您的同意,才能访问蓝牙
 NSAppleMusicUsageDescription App需要您的同意,才能访问媒体资料库
 NSLocationUsageDescription App需要您的同意,才能在使用期间访问位置
 NSLocationWhenInUseUsageDescription App需要您的同意,才能在使用期间访问位置
 NSLocationAlwaysUsageDescription App需要您的同意,才能始终访问位置
 NSContactsUsageDescription 需要您的同意,才能访问通讯录

  */

/*

 // MARK: - 跳转系统设置界面
 func ag_OpenURL(_ type: AGpermissionsType? = nil) {
     let title = "权限无法访问"
     var message = "请点击“前往”，允许访问权限"
     let appName: String = (Bundle.main.infoDictionary!["CFBundleDisplayName"] ?? "") as! String //App 名称
     if type == .camera { // 相机
         message = "请在\"设置-隐私-相机\"选项中，允许\"\(appName)\"访问你的相机"
     } else if type == .photo { // 相册
         message = "请在\"设置-隐私-照片\"选项中，允许\"\(appName)\"访问你的相册"
     } else if type == .location { // 位置
         message = "请在\"设置-隐私-定位服务\"选项中，允许\"\(appName)\"访问您的位置，获得更多商品信息"
     } else if type == .network { // 网络
         message = "请在\"设置-蜂窝移动网络\"选项中，允许\"\(appName)\"访问你的移动网络"
     } else if type == .microphone { // 麦克风
         message = "请在\"设置-隐私-麦克风\"选项中，允许\"\(appName)\"访问你的麦克风"
     }
     let url = URL(string: UIApplication.openSettingsURLString)
     let alertController = UIAlertController(title: title,
                                             message: message,
                                             preferredStyle: .alert)
     let cancelAction = UIAlertAction(title:"取消", style: .cancel, handler:nil)
     let settingsAction = UIAlertAction(title:"前往", style: .default, handler: {
         (action) -> Void in
         if  UIApplication.shared.canOpenURL(url!) {
             if #available(iOS 10, *) {
                 UIApplication.shared.open(url!, options: [:],completionHandler: {(success) in})
             } else {
                 UIApplication.shared.openURL(url!)
             }
         }
     })
     alertController.addAction(cancelAction)
     alertController.addAction(settingsAction)
     UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
 }
 */
