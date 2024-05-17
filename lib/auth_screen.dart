/*import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gojo/Homepage.dart';
import 'package:local_auth/local_auth.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key, required this.change});
  Function() change;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

enum SupportState {
  unknown,
  supported,
  unSupported,
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  SupportState supportstate = SupportState.unknown;
  List<BiometricType>? availableBiometrics;

  void initState() {
    auth.isDeviceSupported().then((bool isSupported) => setState(() =>
        supportstate =
            isSupported ? SupportState.supported : SupportState.unSupported));
    super.initState();
    checkBiometric();
    getAvailableBiometrics();
  }

  Future<void> checkBiometric() async {
    late bool cancheckBiometric;
    try {
      cancheckBiometric = await auth.canCheckBiometrics;
      print("Biometric supported : $cancheckBiometric");
    } on PlatformException catch (e) {
      print(e);
      cancheckBiometric = false;
    }
  }

  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> biometrictype;
    try {
      biometrictype = await auth.getAvailableBiometrics();
      print("supported biometrics $biometrictype");
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) {
      return;
    }
    setState(() {
      availableBiometrics = biometrictype;
    });
  }

  Future<void> authenticatedWithBiometrics() async {
    try {
      final authenticated = await auth.authenticate(
          localizedReason: "authenticate with fingerprint or face ID");
      options:
      const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      );
      if (!mounted) {
        return;
      }
      if (authenticated) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(change: widget.change)));
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
     
    );
  }
}*/
