import 'package:example/data/fake_flags.dart';
import 'package:feature_flagix/feature_flagix.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Create a new instance of [AppFlagix].
  final FeatureFlagix featureFlagix = FeatureFlagix();

  /// Create a new instance of [FlagixRoles] with the given [roles].
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

  @override
  void initState() {
    super.initState();
    featureFlagix.setCurrentRole(Roles.user);
    // Initialize the [AppFlagix] instance with the [FlagixModel] instance.
    featureFlagix.setPermissions(flagixModel);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feature_flagix Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
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
  final FeatureFlagix featureFlagix = FeatureFlagix();

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
              setState(() => role = value!);
              featureFlagix.setCurrentRole(role);
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
          ),
        ],
      ),
    );
  }
}

/// a page to show the current feature flags
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
          Flagix(
            flag: Flags.feature2.name,
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 2'),
                subtitle: Text('This is Feature 2'),
              ),
            ),
          ),
          Flagix(
            flag: Flags.feature3.name,
            child: const Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Feature 3'),
                subtitle: Text('This is Feature 3'),
              ),
            ),
          ),
          Flagix(
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
