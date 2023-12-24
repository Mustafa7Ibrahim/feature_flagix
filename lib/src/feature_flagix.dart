import 'package:feature_flagix/src/models/flagix_roles.dart';

class FeatureFlagix {
  FlagixRoles? _appFlags; // Nullable
  dynamic _currentRole;

  // Private constructor to prevent instantiation from outside the class.
  FeatureFlagix._() : _currentRole = "";

  // The single instance of the class.
  static FeatureFlagix? _instance;

  // Factory constructor to provide a controlled instance.
  factory FeatureFlagix() {
    _instance ??= FeatureFlagix._();
    return _instance as FeatureFlagix; // Cast to the correct type
  }

  dynamic get currentRole => _currentRole;

  /// Sets the app permissions
  void setFlags(FlagixRoles flags) => _appFlags = flags;

  /// Sets the current role.
  void setCurrentRole(dynamic role) => _currentRole = role;

  bool hasPermission(dynamic permission) {
    // Check if _appPermissions is initialized
    if (_appFlags == null) {
      throw Exception(
        """
        App flags not initialized. Call setFlags method.

        Make sure you call setFlags() method before calling hasPermission method.
        and call setCurrentRole() method before calling hasPermission method.

        Example:
            FeatureFlagix().setFlags(appFlags);
            FeatureFlagix().setCurrentRole('admin');
        """,
      );
    }

    // Check if the current role exists in the appPermissions
    if (_appFlags!.roles.containsKey(_currentRole)) {
      // Get the permissions associated with the current role
      final rolePermissions = _appFlags!.roles[_currentRole]!.permissions;

      // Check if the specified permission is present in the role's permissions
      return rolePermissions.contains(permission);
    }
    // If the role is not found, return false (no permission)
    return false;
  }
}
