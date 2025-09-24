// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get apiError => 'An error occurred. Please try again later';

  @override
  String get apiErrorDescription => 'Oops! Something went wrong. Please try again later.';

  @override
  String get connectionTimeout => 'Connection Timeout';

  @override
  String get connectionTimeoutDesc => 'Oops! It seems the connection timed out. Please check your internet connection and try again.';

  @override
  String get cancel => 'Cancel';

  @override
  String get cancelDesc => 'Your request has been cancelled. Please try again.';

  @override
  String get sendTimeout => 'Connection Timeout';

  @override
  String get sendTimeoutDesc => 'Oops! It seems the connection timed out. Please check your internet connection and try again.';

  @override
  String get receiveTimeout => 'Data Reception Issue';

  @override
  String get receiveTimeoutDesc => 'Oops! We\'re having trouble receiving data right now. Please try again later.';

  @override
  String get badCertificate => 'Security Certificate Problem';

  @override
  String get badCertificateDesc => 'Sorry, there\'s a problem with the security certificate. Please contact support for assistance.';

  @override
  String get badResponse => 'Unexpected Server Response';

  @override
  String get badResponseDesc => 'Oh no! We received an unexpected response from the server. Please try again later.';

  @override
  String get reqCancel => 'Request Cancelled';

  @override
  String get reqCancelDesc => 'Your request has been cancelled. Please try again.';

  @override
  String get connectionError => 'Connection Issue';

  @override
  String get connectionErrorDesc => 'We\'re having trouble connecting to the server. Please check your internet connection and try again.';

  @override
  String get unknown => 'Unknown Error';

  @override
  String get unknownDesc => 'Oops! Something went wrong. Please try again later.';

  @override
  String get code200 => 'The request was successful.';

  @override
  String get code201 => 'A new resource was created successfully.';

  @override
  String get code202 => 'The request was accepted for processing, but the processing has not been completed.';

  @override
  String get code301 => 'The resource has been permanently moved to a new location.';

  @override
  String get code302 => 'The resource has been temporarily moved to a new location.';

  @override
  String get code304 => 'The resource has not been modified since the last request.';

  @override
  String get code400 => 'The server could not understand the request due to malformed syntax.';

  @override
  String get code401 => 'The request requires user authentication.';

  @override
  String get code403 => 'The server understood the request, but refuses to fulfill it.';

  @override
  String get code404 => 'The requested resource could not be found.';

  @override
  String get code405 => 'The method specified in the request is not allowed for the requested resource.';

  @override
  String get code409 => 'The request could not be completed due to a conflict with the current state of the resource.';

  @override
  String get code500 => 'The server encountered an unexpected condition which prevented it from fulfilling the request.';

  @override
  String get code503 => 'The server is currently unable to handle the request.';

  @override
  String get daysAgo => 'days ago';

  @override
  String get hoursAgo => 'hours ago';

  @override
  String get monthsAgo => 'months ago';

  @override
  String get yearsAgo => 'years ago';

  @override
  String get minutesAgo => 'minutes ago';

  @override
  String get justNow => 'Just now';
}
