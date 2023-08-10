//
//  AxcPermission+Calendar.swift
//  Pods
//
//  Created by 赵新 on 2022/12/2.
//

import EventKit

/// NSCalendarsUsageDescription

public extension AxcPermissionLib {
    /// 获取日历权限状态
    static var CalendarStatus: Status {
        var status: Status = .unknow
        let authStatus: EKAuthorizationStatus = EKEventStore.authorizationStatus(for: .reminder)
        switch authStatus {
        case .authorized: status = .authorized
        case .restricted: status = .restricted
        case .denied: status = .denied
        case .notDetermined: status = .notDetermined
        @unknown default: status = .unknow
        }
        Log("获取日历权限：\(status)")
        return status
    }

    /// 请求日历权限
    static func CalendarRequest(_ resultBlock: StatusBlock? = nil) {
        let eventStore = EKEventStore()
        eventStore.requestAccess(to: .reminder) { bool, error in
            if let error = error {
                Log("请求日历权限失败！error：\(error)")
            } else {
                let status: Status = bool ? .authorized : .denied
                Log("请求日历权限：\(status)")
                DispatchQueue.main.async {
                    resultBlock?(status)
                }
            }
        }
    }
}
