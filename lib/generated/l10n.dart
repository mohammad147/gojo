// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get Username {
    return Intl.message(
      'Username',
      name: 'Username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Create New Account`
  String get SignUp {
    return Intl.message(
      'Create New Account',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Forgot My Password`
  String get forgetPass {
    return Intl.message(
      'Forgot My Password',
      name: 'forgetPass',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get Age {
    return Intl.message(
      'Age',
      name: 'Age',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get Weight {
    return Intl.message(
      'Weight',
      name: 'Weight',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get Email {
    return Intl.message(
      'Email Address',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get height {
    return Intl.message(
      'Height',
      name: 'height',
      desc: '',
      args: [],
    );
  }

  /// `Create An Account`
  String get ceateAnAccount {
    return Intl.message(
      'Create An Account',
      name: 'ceateAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `عربي`
  String get language {
    return Intl.message(
      'عربي',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Start You Trip`
  String get generate {
    return Intl.message(
      'Start You Trip',
      name: 'generate',
      desc: '',
      args: [],
    );
  }

  /// `Previous Trips`
  String get previousTrips {
    return Intl.message(
      'Previous Trips',
      name: 'previousTrips',
      desc: '',
      args: [],
    );
  }

  /// `Jordan`
  String get home {
    return Intl.message(
      'Jordan',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Trip`
  String get trip {
    return Intl.message(
      'Trip',
      name: 'trip',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Edit My Profile`
  String get editProfile {
    return Intl.message(
      'Edit My Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Terms Of Use`
  String get terms {
    return Intl.message(
      'Terms Of Use',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `privacy Policy`
  String get privary {
    return Intl.message(
      'privacy Policy',
      name: 'privary',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSettings {
    return Intl.message(
      'Account Settings',
      name: 'accountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_name {
    return Intl.message(
      'Language',
      name: 'language_name',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get fname {
    return Intl.message(
      'First Name',
      name: 'fname',
      desc: '',
      args: [],
    );
  }

  /// `Family Name`
  String get lname {
    return Intl.message(
      'Family Name',
      name: 'lname',
      desc: '',
      args: [],
    );
  }

  /// `please fill the form`
  String get fill {
    return Intl.message(
      'please fill the form',
      name: 'fill',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Edit My Profile`
  String get edit_my_prof_button {
    return Intl.message(
      'Edit My Profile',
      name: 'edit_my_prof_button',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Trip Details`
  String get Trip_Details {
    return Intl.message(
      'Trip Details',
      name: 'Trip_Details',
      desc: '',
      args: [],
    );
  }

  /// `Please rate this place`
  String get please_rate {
    return Intl.message(
      'Please rate this place',
      name: 'please_rate',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get Ok {
    return Intl.message(
      'Ok',
      name: 'Ok',
      desc: '',
      args: [],
    );
  }

  /// `how we use your data`
  String get how_we_use_your_data {
    return Intl.message(
      'how we use your data',
      name: 'how_we_use_your_data',
      desc: '',
      args: [],
    );
  }

  /// `privacy policy`
  String get privacy_policy {
    return Intl.message(
      'privacy policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `please update your info`
  String get pleaseUpdate {
    return Intl.message(
      'please update your info',
      name: 'pleaseUpdate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a value`
  String get errormsgpleaseenteravlue {
    return Intl.message(
      'Please enter a value',
      name: 'errormsgpleaseenteravlue',
      desc: '',
      args: [],
    );
  }

  /// `Age should be between 14 and 70 years old`
  String get ageerror {
    return Intl.message(
      'Age should be between 14 and 70 years old',
      name: 'ageerror',
      desc: '',
      args: [],
    );
  }

  /// `height should be between 135 and 220`
  String get heighterror {
    return Intl.message(
      'height should be between 135 and 220',
      name: 'heighterror',
      desc: '',
      args: [],
    );
  }

  /// `weight should be between 36 and 149`
  String get weighterror {
    return Intl.message(
      'weight should be between 36 and 149',
      name: 'weighterror',
      desc: '',
      args: [],
    );
  }

  /// `provinces`
  String get jordanpage {
    return Intl.message(
      'provinces',
      name: 'jordanpage',
      desc: '',
      args: [],
    );
  }

  /// `generate a trip`
  String get generate_trip {
    return Intl.message(
      'generate a trip',
      name: 'generate_trip',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
