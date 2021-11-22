import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'src/app.dart';
import 'src/core/dependency_injection/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies(environment: Environment.dev);

  runApp(const MyApp());
}
