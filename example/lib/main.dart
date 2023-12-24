import 'dart:developer';

import 'package:example/data/fake_flags.dart';
import 'package:feature_flagix/feature_flagix.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create a new instance of [AppFlagix].
  final AppFlagix appFlagix = AppFlagix();

  /// Create a new instance of [FlagixModel] with the given [roles].
  FlagixModel flagixModel = FlagixModel(
    roles: {
      Roles.user: RoleFlagix<String>(
        permissions: [
          Flags.feature1.name,
          Flags.feature2.name,
        ],
      ),
      Roles.admin: RoleFlagix(
        permissions: [
          Flags.feature1.name,
          Flags.feature2.name,
          Flags.feature3.name,
          Flags.feature4.name,
        ],
      ),
      Roles.moderator: RoleFlagix(
        permissions: [
          Flags.feature1.name,
          Flags.feature2.name,
          Flags.feature3.name,
        ],
      ),
      Roles.custom: RoleFlagix(
        permissions: flags,
      ),
    },
  );

  @override
  void initState() {
    super.initState();
    appFlagix.setCurrentRole(Roles.user);
    // Initialize the [AppFlagix] instance with the [FlagixModel] instance.
    appFlagix.setPermissions(flagixModel);
  }

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
  custom,
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
  late Roles role;

  @override
  void initState() {
    super.initState();
    role = Roles.user;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// dropdown button to change the current user role
          DropdownButton<Roles>(
            value: role,
            onChanged: (Roles? value) {
              setState(() {
                role = value!;
                appFlagix.setCurrentRole(role);
              });
              log('Current role setter: $value');
              log('Current role: $role');
              log('Current role: ${appFlagix.currentRole}');
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
              DropdownMenuItem<Roles>(
                value: Roles.custom,
                child: Text('Custom'),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
            width: double.infinity,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const FlagsClass(),
                ),
              );
            },
            child: const Text('Go to Flags Page'),
          )
        ],
      ),
    );
  }
}

class FlagsClass extends StatelessWidget {
  const FlagsClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Feature_flagix'),
      ),
      body: ListView(
        children: [
          FlagixWidget(
            flag: Flags.feature1.name,
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 1'),
                subtitle: Text('This is Feature 1'),
              ),
            ),
          ),
          FlagixWidget(
            flag: Flags.feature2.name,
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 2'),
                subtitle: Text('This is Feature 2'),
              ),
            ),
          ),
          FlagixWidget(
            flag: Flags.feature3.name,
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 3'),
                subtitle: Text('This is Feature 3'),
              ),
            ),
          ),
          FlagixWidget(
            flag: Flags.feature4.name,
            child: const Card(
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
