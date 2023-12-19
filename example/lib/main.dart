import 'package:feature_flagix/feature_flagix.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feature_flagix Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

enum Roles {
  // Define app roles here
  user,
  admin,
  moderator,
}

enum Flags {
  // Define feature flags here
  feature1,
  feature2,
  feature3,
  feature4,
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a new instance of [AppFlagix].
  final AppFlagix appFlagix = AppFlagix();

  /// current user role
  Roles role = Roles.moderator;

  /// Create a new instance of [FlagixModel] with the given [roles].
  FlagixModel<Roles, Flags> flagixModel = FlagixModel<Roles, Flags>(
    roles: {
      Roles.user: RoleFlagix<Flags>(
        permissions: [
          Flags.feature1,
          Flags.feature2,
        ],
      ),
      Roles.admin: RoleFlagix<Flags>(
        permissions: [
          Flags.feature1,
          Flags.feature2,
          Flags.feature3,
          Flags.feature4,
        ],
      ),
      Roles.moderator: RoleFlagix<Flags>(
        permissions: [
          Flags.feature1,
          Flags.feature2,
          Flags.feature3,
        ],
      ),
    },
  );

  @override
  void initState() {
    super.initState();
    appFlagix.setCurrentRole(role);
    // Initialize the [AppFlagix] instance with the [FlagixModel] instance.
    appFlagix.setPermissions(flagixModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Feature_flagix'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          /// dropdown button to change the current user role
          DropdownButton<Roles>(
            value: role,
            onChanged: (Roles? value) {
              setState(() => role = value!);
              appFlagix.setCurrentRole(role);
            },
            items: const <DropdownMenuItem<Roles>>[
              DropdownMenuItem<Roles>(
                value: Roles.user,
                child: Text('User'),
              ),
              DropdownMenuItem<Roles>(
                value: Roles.admin,
                child: Text('Admin'),
              ),
              DropdownMenuItem<Roles>(
                value: Roles.moderator,
                child: Text('Moderator'),
              ),
            ],
          ),
          const FlagixWidget(
            flag: Flags.feature1,
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 1'),
                subtitle: Text('This is Feature 1'),
              ),
            ),
          ),
          const FlagixWidget(
            flag: Flags.feature2,
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 2'),
                subtitle: Text('This is Feature 2'),
              ),
            ),
          ),
          const FlagixWidget(
            flag: Flags.feature3,
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 3'),
                subtitle: Text('This is Feature 3'),
              ),
            ),
          ),
          const FlagixWidget(
            flag: Flags.feature4,
            child: Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 4'),
                subtitle: Text('This is Feature 4'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
