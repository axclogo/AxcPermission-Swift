//
//  Notification.swift
//  Pods
//
//  Created by 赵新 on 2022/12/3.
//

import UserNotifications

public extension AxcPermissionLib {
    /// 获取通知权限状态（同步）
    /// 异步转同步，第一次会卡线程，非必要不建议使用
    static var NotificationStatus: Status {
        var status: Status = .unknow
        let queue = DispatchQueue(label: "com.AxcPermission.NotificationStatus")
        let semaphore = DispatchSemaphore(value: 0)
        queue.async {
            NotificationStatus { _status in
                status = _status
                semaphore.signal()
            }
        }
        semaphore.wait()
        return status
    }

    /// 获取通知权限状态（异步）
    static func NotificationStatus(_ statusBlock: @escaping StatusBlock) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            var status: Status = .unknow
            switch settings.authorizationStatus {
            case .notDetermined: status = .notDetermined
            case .denied: status = .denied
            case .authorized: status = .authorized
            case .provisional: status = .restricted
            case .ephemeral: status = .restricted
            @unknown default: status = .unknow
            }
            Log("获取通知权限：\(status)")
            statusBlock(status)
        }
    }

    /// 通知请求权限
    static func NotificationRequest(_ resultBlock: StatusBlock? = nil) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { bool, error in
            if let error = error {
                Log("请求通知权限失败！error：\(error)")
            } else {
                let status: Status = bool ? .authorized : .denied
                Log("请求通知权限：\(status)")
                DispatchQueue.main.async {
                    resultBlock?(status)
                }
            }
        }
    }
}
