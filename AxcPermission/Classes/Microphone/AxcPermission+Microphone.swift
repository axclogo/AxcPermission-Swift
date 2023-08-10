//
//  AxcPermission+Microphone.swift
//  Pods
//
//  Created by 赵新 on 2022/12/2.
//

import AVFoundation

/// NSMicrophoneUsageDescription

public extension AxcPermissionLib {
    /// 获取麦克风权限状态
    static var MicrophoneStatus: Status {
        var status: Status = .unknow
        let authStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch authStatus {
        case .authorized: status = .authorized
        case .restricted: status = .restricted
        case .denied: status = .denied
        case .notDetermined: status = .notDetermined
        @unknown default: status = .unknow
        }
        Log("获取摄像头权限：\(status)")
        return status
    }

    /// 请求摄像头权限
    static func MicrophoneRequest(_ resultBlock: StatusBlock? = nil) {
        AVCaptureDevice.requestAccess(for: .audio) { bool in
            DispatchQueue.main.async {
                let status: Status = bool ? .authorized : .denied
                Log("请求摄像头权限：\(status)")
                resultBlock?(status)
            }
        }
    }
}
