//
//  AxcPermission.swift
//  AxcPermission
//
//  Created by 赵新 on 2022/8/10.
//

import CoreTelephony

public extension AxcPermissionLib {
    /// 获取蜂窝网络权限状态
    static var CheckNetworkStatus: Status {
        var status: Status = .unknow
        let state = CTCellularData().restrictedState
        switch state {
        case .restrictedStateUnknown: status = .unknow
        case .restricted: status = .denied
        case .notRestricted: status = .authorized
        @unknown default: status = .unknow
        }
        Log("获取网络权限：\(status)")
        return status
    }
}
