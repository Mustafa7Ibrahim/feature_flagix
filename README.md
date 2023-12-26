# Feature Flagix

Feature Flagix is a lightweight and flexible feature flags library for Flutter applications. It allows you to control the visibility of features based on roles and permissions in your application.

## Installation

To use Feature Flagix in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  feature_flagix: ^1.0.2
```

Then, run `flutter pub get` in your terminal.

## Getting Started

To start using Feature Flagix, follow these steps:

1. **Initialize Feature Flagix:**

   ```dart
   import 'package:feature_flagix/feature_flagix.dart';

   // Create an instance of FeatureFlagix
   final FeatureFlagix featureFlagix = FeatureFlagix();
   ```

2. **Define Roles and Permissions:**

   ```dart
   import 'package:example/data/fake_flags.dart';
   import 'package:feature_flagix/feature_flagix.dart';

   // Define app roles
   enum Roles {
     user,
     admin,
     moderator,
     custom,
   }

   // Define feature flags
   enum Flags {
     feature1,
     feature2,
     feature3,
     feature4,
   }

   // Create a new instance of FlagixRoles with roles and permissions
   FlagixRoles flagixModel = FlagixRoles(
     roles: {
       Roles.user: FlagixPermissions<String>(
         permissions: [
           Flags.feature1.name,
           Flags.feature2.name,
         ],
       ),
       Roles.admin: FlagixPermissions(
         permissions: [
           Flags.feature1.name,
           Flags.feature2.name,
           Flags.feature3.name,
           Flags.feature4.name,
         ],
       ),
       Roles.moderator: FlagixPermissions(
         permissions: [
           Flags.feature1.name,
           Flags.feature2.name,
           Flags.feature3.name,
         ],
       ),
       Roles.custom: FlagixPermissions(
         permissions: customFlags,
       ),
     },
   );
   ```

3. **Set Current Role:**

   ```dart
   // Set the current role for the user
   featureFlagix.setCurrentRole(Roles.user);
   ```

   - Make sure to set the current role before setting the feature flags. Otherwise, the feature flags will not be set.
   - Preferable to set the current role in the `initState()` method of your `MyApp` before any logic happened.

4. **Set Flags:**

   ```dart
   // Set the feature flags for the user
   featureFlagix.setFlags(flagixModel);
   ```

   - Make sure to set the feature flags after setting the current role. Otherwise, the Flagix() widget will throw an error.

5. **Check Permissions:**

   ```dart
   // Check if the user has a specific permission
   bool hasPermission = featureFlagix.hasPermission(Flags.feature1.name);
   ```

6. **Update UI Based on Feature Flags:**

   ```dart
   // Use FeatureFlagix to conditionally render UI elements
   Flagix(
     flag: Flags.feature1.name,
     child: const Card(
       child: ListTile(
         leading: Icon(Icons.person),
         title: Text('Feature 1'),
         subtitle: Text('This is Feature 1'),
       ),
     ),
   ),
   ```

   ```dart
   // Use FeatureFlagix to conditionally render UI elements
   Flagix(
     flag: Flags.feature1.name,
     // Use replace to replace the child widget when the user does not have the required permission (optional)
      replace: const Card(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text('Feature 1'),
          subtitle: Text('This is Feature 1'),
        ),
      ),
     child: const Card(
       child: ListTile(
         leading: Icon(Icons.person),
         title: Text('Feature 1'),
         subtitle: Text('This is Feature 1'),
       ),
     ),
   ),
   ```

## Example

See the provided example in the `example/` directory for a more detailed implementation.

## Contributing

Feel free to contribute to this project by opening issues or submitting pull requests. Please follow the [Flutter Style Guide](https://flutter.dev/docs/development/tools/formatting) when making changes.

## License

``` text
MIT License

Copyright (c) 2023 Mustafa Ibrahim.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Author

- [Mustafa Ibrahim](https://github.com/Mustafa7Ibrahim)
