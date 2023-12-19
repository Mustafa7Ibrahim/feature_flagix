import 'package:feature_flagix/src/flagix_models.dart';

class AppFlagix {
  late FlagixModel _appPermissions;
  late String _currentRole;

  // Private constructor to prevent instantiation from outside the class.
  AppFlagix._();

  // The single instance of the class.
  static AppFlagix? _instance;

  // Factory constructor to provide a controlled instance.
  factory AppFlagix() {
    _instance ??= AppFlagix._();
    return _instance!;
  }

  String get currentRole => _currentRole;

  void setPermissions(FlagixModel permissions) {
    _appPermissions = permissions;
  }

  void setCurrentRole(String role) {
    _currentRole = role;
  }

  bool hasPermission(String permission) {
    // Check if the current role exists in the appPermissions
    if (_appPermissions.roles.containsKey(_currentRole)) {
      // Get the permissions associated with the current role
      final rolePermissions = _appPermissions.roles[_currentRole]!.permissions;

      // Check if the specified permission is present in the role's permissions
      return rolePermissions.contains(permission);
    }

    // If the role is not found, return false (no permission)
    return false;
  }
}
