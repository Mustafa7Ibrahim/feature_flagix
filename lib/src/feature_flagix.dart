import 'package:feature_flagix/src/models/flagix_roles.dart';

class FeatureFlagix<P> {
  late FlagixRoles _appPermissions;
  late P _currentRole;

  // Private constructor to prevent instantiation from outside the class.
  FeatureFlagix._() : _currentRole = "Role" as P;

  // The single instance of the class.
  static FeatureFlagix? _instance;

  // Factory constructor to provide a controlled instance.
  factory FeatureFlagix() {
    _instance ??= FeatureFlagix._();
    return _instance as FeatureFlagix<P>; // Cast to the correct type
  }

  P get currentRole => _currentRole;

  /// Sets the app permissions
  void setPermissions(FlagixRoles permissions) {
    _appPermissions = permissions;
  }

  /// Sets the current role.
  void setCurrentRole(P role) => _currentRole = role;

  bool hasPermission(P permission) {
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