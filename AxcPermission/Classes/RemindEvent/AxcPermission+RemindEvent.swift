//
//  AxcPermission+RemindEvent.swift
//  Pods
//
//  Created by 赵新 on 2022/12/2.
//

import EventKit

/// NSRemindersUsageDescription

public extension AxcPermissionLib {
    /// 获取提醒事项权限状态
    static var CheckRemindEventStatus: Status {
        var status: Status = .unknow
        let authStatus: EKAuthorizationStatus = EKEventStore.authorizationStatus(for: .event)
        switch authStatus {
        case .authorized: status = .authorized
        case .restricted: status = .restricted
        case .denied: status = .denied
        case .notDetermined: status = .notDetermined
        @unknown default: status = .unknow
        }
        Log("获取提醒事项权限：\(status)")
        return status
    }

    /// 请求提醒事项权限
    static func RemindEventRequest(_ resultBlock: StatusBlock? = nil) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .event) { bool, error in
            if let error = error {
                Log("请求提醒事项权限失败！error：\(error)")
            } else {
                let status: Status = bool ? .authorized : .denied
                Log("请求提醒事项权限：\(status)")
                DispatchQueue.main.async {
                    resultBlock?(status)
                }
            }
        }
    }
}
