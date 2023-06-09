import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harry_potter_app/services/auth/firebase_auth_provider.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_bloc.dart';
import 'package:harry_potter_app/ui/bloc/auth/auth_event.dart';
import 'package:harry_potter_app/ui/view/auth/auth_center.dart';

import 'ui/bloc/app/app_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const HarryPotterApp());
}

class HarryPotterApp extends StatelessWidget {
  const HarryPotterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authProvider: FirebaseAuthProvider())
            ..add(const AuthEventInitializeFirebase()),
        ),
        BlocProvider(
          create: (context) => AppBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthCenter(),
      ),
    );
  }
}
