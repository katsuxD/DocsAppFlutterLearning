// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_flutter_learning/colors.dart';
import 'package:google_docs_flutter_learning/repository/auth_repository.dart';
import 'package:google_docs_flutter_learning/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);
  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    //avoid not to use buildcontext off the async app, below is using context before async call
    final sMessenger = ScaffoldMessenger.of(context);
    final errorModel =
        await ref.read(AuthRepositoryProvider).signInWithGoogle();
    final navigator = Navigator.of(context);
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      sMessenger.showSnackBar(
        SnackBar(
          content: Text(
            errorModel.error!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(AuthRepositoryProvider).signInWithGoogle();
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => signInWithGoogle(ref, context),
          icon: Image.asset(
            'assets/images/g-logo-2.png',
            height: 20,
          ),
          label: const Text(
            "Sign in with Google",
            style: TextStyle(
              color: kBlackColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kWhiteColor,
            minimumSize: const Size(150, 50),
          ),
        ),
      ),
    );
  }
}
