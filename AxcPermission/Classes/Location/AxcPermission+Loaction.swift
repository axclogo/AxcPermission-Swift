//
//  AxcPermissionLib+Loaction.swift
//  Pods
//
//  Created by 赵新 on 2022/12/2.
//

import AxcBedrock
import CoreLocation

// NSLocationAlwaysAndWhenInUseUsageDescription  => 总是
// NSLocationWhenInUseUsageDescription => 使用时

public extension AxcPermissionLib {
    /// 获取定位权限状态同步
    static var LocationStatus: Status {
        var status: Status = .unknow
        // 手机的定位权限
        if !CLLocationManager.locationServicesEnabled() {
            status = .denied
        }
        // 应用的定位权限
        let authStatus = CLLocationManager.authorizationStatus()
        switch authStatus {
        case .authorizedAlways: status = .authorized
        case .authorizedWhenInUse: status = .authorized
        case .denied: status = .denied
        case .notDetermined: status = .notDetermined
        case .restricted: status = .restricted
        @unknown default: status = .unknow
        }
        Log("获取定位权限：\(status)")
        return status
    }

    /// 请求定位权限
    static func LocationRequest(_ resultBlock: StatusBlock? = nil) {
        guard LocationStatus != .denied else {
            resultBlock?(.denied)
            return
        }
        // 先设置好回调
        Shared.locationDelegateResultBlock = { status in
            guard status != .notDetermined else { return } // 等待用户选择
            Log("请求定位权限：\(status)")
            resultBlock?(status)
        }
        Shared.locationManager.requestAlwaysAuthorization()
        Shared.locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - AxcPermissionLib + CLLocationManagerDelegate

extension AxcPermissionLib: CLLocationManagerDelegate {
    /// iOS14以下支持
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        let status: Status = AxcPermissionLib.judgeAuthorizationStatus(status)
        locationDelegateResultBlock?(status)
    }

    /// iOS14支持
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        var status: Status = .unknow
        DispatchQueue.main.async { [weak self] in
            guard let weakSelf = self else { return }
            if #available(iOS 14.0, *) {
                status = AxcPermissionLib.judgeAuthorizationStatus(manager.authorizationStatus)
                weakSelf.locationDelegateResultBlock?(status)
            } else {
                weakSelf.locationDelegateResultBlock?(.unknow)
            }
        }
    }

    fileprivate static func judgeAuthorizationStatus(_ status: CLAuthorizationStatus) -> Status {
        var result: Status = .unknow
        switch status {
        case .authorizedAlways: result = .authorized
        case .authorizedWhenInUse: result = .authorized
        case .denied: result = .denied
        case .notDetermined: result = .notDetermined
        case .restricted: result = .restricted
        @unknown default: result = .unknow
        }
        return result
    }
}

private var k_locationManager = "k_fileprivate.axc.authorize.locationManager"
private var k_locationDelegateResultBlock = "k_fileprivate.axc.authorize.locationDelegateResultBlock"

extension AxcPermissionLib {
    /// 位置管理
    var locationManager: CLLocationManager {
        set { AxcRuntime.Set(object: self, key: &k_locationManager, value: newValue) }
        get {
            guard let locationManager: CLLocationManager = AxcRuntime.GetObject(self, key: &k_locationManager) else {
                let locationManager = CLLocationManager()
                locationManager.delegate = self
                self.locationManager = locationManager
                return locationManager
            }
            return locationManager
        }
    }

    /// 地理定位结果回调
    var locationDelegateResultBlock: StatusBlock? {
        set { AxcRuntime.Set(object: self, key: &k_locationDelegateResultBlock, value: newValue) }
        get { return AxcRuntime.GetObject(self, key: &k_locationDelegateResultBlock) }
    }
}
