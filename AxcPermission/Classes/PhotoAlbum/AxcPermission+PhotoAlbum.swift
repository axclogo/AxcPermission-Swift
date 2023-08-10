//
//  Notification.swift
//  Pods
//
//  Created by 赵新 on 2022/12/3.
//

import Photos

/// NSPhotoLibraryUsageDescription  访问相册
/// NSPhotoLibraryAddUsageDescription 添加图片到相册

public extension AxcPermissionLib {
    /// 获取相册权限状态
    static var PhotoAlbumStatus: Status {
        var status: Status = .unknow
        if #available(iOS 14, *) {
            let authStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            status = judgePhotoAlbumStatus(authStatus)
        } else {
            let authStatus = PHPhotoLibrary.authorizationStatus()
            status = judgePhotoAlbumStatus(authStatus)
        }
        Log("获取相册权限：\(status)")
        return status
    }

    /// 请求相册权限
    static func PhotoAlbumRequest(_ resultBlock: StatusBlock? = nil) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (authStatus) in
                let status = judgePhotoAlbumStatus(authStatus)
                Log("请求相册权限：\(status)")
                DispatchQueue.main.async {
                    resultBlock?(status)
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization { authStatus in
                let status = judgePhotoAlbumStatus(authStatus)
                Log("请求相册权限：\(status)")
                DispatchQueue.main.async {
                    resultBlock?(status)
                }
            }
        }
    }

    private static func judgePhotoAlbumStatus(_ authorizationStatus: PHAuthorizationStatus) -> Status {
        var status: Status = .unknow
        switch authorizationStatus {
        case .authorized: status = .authorized
        case .limited: status = .limited
        case .restricted: status = .restricted
        case .denied: status = .denied
        case .notDetermined: status = .notDetermined
        @unknown default: status = .unknow
        }
        return status
    }
}
