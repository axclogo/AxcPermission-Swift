//
//  AxcPermission+Camera.swift
//  Pods
//
//  Created by 赵新 on 2022/12/2.
//

import Contacts

/// NSContactsUsageDescription

public extension AxcPermissionLib {
    /// 获取通讯录权限状态
    static var AddressBookStatus: Status {
        var status: Status = .unknow
        let authStatus: CNAuthorizationStatus = CNContactStore.authorizationStatus(for: .contacts)
        switch authStatus {
        case .authorized: status = .authorized
        case .restricted: status = .restricted
        case .denied: status = .denied
        case .notDetermined: status = .notDetermined
        @unknown default: status = .unknow
        }
        Log("获取通讯录权限：\(status)")
        return status
    }

    /// 请求通讯录权限
    static func AddressBookRequest(_ resultBlock: StatusBlock? = nil) {
        let contactStore = CNContactStore()
        contactStore.requestAccess(for: .contacts) { bool, error in
            if let error = error {
                Log("请求通讯录权限失败！error：\(error)")
            } else {
                let status: Status = bool ? .authorized : .denied
                Log("请求通讯录权限：\(status)")
                DispatchQueue.main.async {
                    resultBlock?(status)
                }
            }
        }
    }
}
