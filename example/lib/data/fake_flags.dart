List<String> flags = ['feature1', 'feature2'];

/// create a fake function to get the current user flags
/// it should return a list of flags
/// and the flags should be a string
/// this function is a fake function that return a future

Future<List<String>> getUserFlags() async {
  await Future.delayed(const Duration(seconds: 2));
  return flags;
}
