import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// No description provided for @apiError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again later'**
  String get apiError;

  /// No description provided for @apiErrorDescription.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong. Please try again later.'**
  String get apiErrorDescription;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection Timeout'**
  String get connectionTimeout;

  /// No description provided for @connectionTimeoutDesc.
  ///
  /// In en, this message translates to:
  /// **'Oops! It seems the connection timed out. Please check your internet connection and try again.'**
  String get connectionTimeoutDesc;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancelDesc.
  ///
  /// In en, this message translates to:
  /// **'Your request has been cancelled. Please try again.'**
  String get cancelDesc;

  /// No description provided for @sendTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection Timeout'**
  String get sendTimeout;

  /// No description provided for @sendTimeoutDesc.
  ///
  /// In en, this message translates to:
  /// **'Oops! It seems the connection timed out. Please check your internet connection and try again.'**
  String get sendTimeoutDesc;

  /// No description provided for @receiveTimeout.
  ///
  /// In en, this message translates to:
  /// **'Data Reception Issue'**
  String get receiveTimeout;

  /// No description provided for @receiveTimeoutDesc.
  ///
  /// In en, this message translates to:
  /// **'Oops! We\'re having trouble receiving data right now. Please try again later.'**
  String get receiveTimeoutDesc;

  /// No description provided for @badCertificate.
  ///
  /// In en, this message translates to:
  /// **'Security Certificate Problem'**
  String get badCertificate;

  /// No description provided for @badCertificateDesc.
  ///
  /// In en, this message translates to:
  /// **'Sorry, there\'s a problem with the security certificate. Please contact support for assistance.'**
  String get badCertificateDesc;

  /// No description provided for @badResponse.
  ///
  /// In en, this message translates to:
  /// **'Unexpected Server Response'**
  String get badResponse;

  /// No description provided for @badResponseDesc.
  ///
  /// In en, this message translates to:
  /// **'Oh no! We received an unexpected response from the server. Please try again later.'**
  String get badResponseDesc;

  /// No description provided for @reqCancel.
  ///
  /// In en, this message translates to:
  /// **'Request Cancelled'**
  String get reqCancel;

  /// No description provided for @reqCancelDesc.
  ///
  /// In en, this message translates to:
  /// **'Your request has been cancelled. Please try again.'**
  String get reqCancelDesc;

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection Issue'**
  String get connectionError;

  /// No description provided for @connectionErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'We\'re having trouble connecting to the server. Please check your internet connection and try again.'**
  String get connectionErrorDesc;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error'**
  String get unknown;

  /// No description provided for @unknownDesc.
  ///
  /// In en, this message translates to:
  /// **'Oops! Something went wrong. Please try again later.'**
  String get unknownDesc;

  /// No description provided for @code200.
  ///
  /// In en, this message translates to:
  /// **'The request was successful.'**
  String get code200;

  /// No description provided for @code201.
  ///
  /// In en, this message translates to:
  /// **'A new resource was created successfully.'**
  String get code201;

  /// No description provided for @code202.
  ///
  /// In en, this message translates to:
  /// **'The request was accepted for processing, but the processing has not been completed.'**
  String get code202;

  /// No description provided for @code301.
  ///
  /// In en, this message translates to:
  /// **'The resource has been permanently moved to a new location.'**
  String get code301;

  /// No description provided for @code302.
  ///
  /// In en, this message translates to:
  /// **'The resource has been temporarily moved to a new location.'**
  String get code302;

  /// No description provided for @code304.
  ///
  /// In en, this message translates to:
  /// **'The resource has not been modified since the last request.'**
  String get code304;

  /// No description provided for @code400.
  ///
  /// In en, this message translates to:
  /// **'The server could not understand the request due to malformed syntax.'**
  String get code400;

  /// No description provided for @code401.
  ///
  /// In en, this message translates to:
  /// **'The request requires user authentication.'**
  String get code401;

  /// No description provided for @code403.
  ///
  /// In en, this message translates to:
  /// **'The server understood the request, but refuses to fulfill it.'**
  String get code403;

  /// No description provided for @code404.
  ///
  /// In en, this message translates to:
  /// **'The requested resource could not be found.'**
  String get code404;

  /// No description provided for @code405.
  ///
  /// In en, this message translates to:
  /// **'The method specified in the request is not allowed for the requested resource.'**
  String get code405;

  /// No description provided for @code409.
  ///
  /// In en, this message translates to:
  /// **'The request could not be completed due to a conflict with the current state of the resource.'**
  String get code409;

  /// No description provided for @code500.
  ///
  /// In en, this message translates to:
  /// **'The server encountered an unexpected condition which prevented it from fulfilling the request.'**
  String get code500;

  /// No description provided for @code503.
  ///
  /// In en, this message translates to:
  /// **'The server is currently unable to handle the request.'**
  String get code503;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'days ago'**
  String get daysAgo;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'hours ago'**
  String get hoursAgo;

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'months ago'**
  String get monthsAgo;

  /// No description provided for @yearsAgo.
  ///
  /// In en, this message translates to:
  /// **'years ago'**
  String get yearsAgo;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'minutes ago'**
  String get minutesAgo;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
