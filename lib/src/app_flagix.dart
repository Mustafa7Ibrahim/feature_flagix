import 'dart:developer';

import 'package:feature_flagix/src/flagix_models.dart';

class AppFlagix<P> {
  late FlagixModel _appPermissions;
  late P _currentRole;

  // Private constructor to prevent instantiation from outside the class.
  AppFlagix._() : _currentRole = "defaultRole" as P;

  // The single instance of the class.
  static AppFlagix? _instance;

  // Factory constructor to provide a controlled instance.
  // Factory constructor to provide a controlled instance.
  factory AppFlagix() {
    _instance ??= AppFlagix._();
    return _instance as AppFlagix<P>; // Cast to the correct type
  }

  P get currentRole => _currentRole;

  void setPermissions(FlagixModel permissions) {
    _appPermissions = permissions;
  }

  void setCurrentRole(P role) {
    _currentRole = role;
  }

  bool hasPermission(P permission) {
    log("Checking permission: $permission");
    log("Current role: $_currentRole");
    log("App permissions: ${_appPermissions.roles}");
    // Check if the current role exists in the appPermissions
    if (_appPermissions.roles.containsKey(_currentRole)) {
      log("Current role: $_currentRole");
      // Get the permissions associated with the current role
      final rolePermissions = _appPermissions.roles[_currentRole]!.permissions;
      log("Role permissions: $rolePermissions");

      // Check if the specified permission is present in the role's permissions
      return rolePermissions.contains(permission);
    }
    log("Role not found");
    // If the role is not found, return false (no permission)
    return false;
  }
}
