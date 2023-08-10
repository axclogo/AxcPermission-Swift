//
//  AxcPermission+Idfa.swift
//  Pods
//
//  Created by 赵新 on 2022/12/2.
//

import AdSupport
import AppTrackingTransparency

/// NSUserTrackingUsageDescription

public extension AxcPermissionLib {
    /// 获取广告标识符权限状态
    static var IdfaStatus: Status {
        var status: Status = .unknow
        if #available(iOS 14, *) {
            let trackingStatus = ATTrackingManager.trackingAuthorizationStatus
            status = judgeIdfaStatus(trackingStatus)
        } else { // iOS13及之前版本，继续用以前的方式
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                status = .authorized
            } else {
                status = .denied
            }
        }
        Log("获取广告标识符Idfa权限：\(status)")
        return status
    }

    /// IDFA请求权限
    static func IdfaRequest(_ resultBlock: StatusBlock? = nil) {
        var status: Status = .unknow
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { (authStatus) in
                status = judgeIdfaStatus(authStatus)
            }
        } else { // iOS13及之前版本，继续用以前的方式
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                status = .authorized
            } else {
                status = .denied
            }
        }
        Log("请求广告标识符Idfa权限：\(status)")
        DispatchQueue.main.async {
            resultBlock?(status)
        }
    }

    @available(iOS 14, *)
    fileprivate static func judgeIdfaStatus(_ authorizationStatus: ATTrackingManager.AuthorizationStatus) -> Status {
        var result: Status = .unknow
        switch authorizationStatus {
        case .authorized: result = .authorized
        case .restricted: result = .restricted
        case .denied: result = .denied
        case .notDetermined: result = .notDetermined
        @unknown default: result = .unknow
        }
        return result
    }
}
