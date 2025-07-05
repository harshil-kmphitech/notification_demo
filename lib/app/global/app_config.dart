
class AppConfig {
  AppConfig._();

  static const baseUrl = 'https://cdcc1lvs-3030.inc1.devtunnels.ms';
  static const apiUrl = '$baseUrl/api/';

  static const sendTime = Duration(minutes: 1);
  static const receiveTime = Duration(minutes: 1);
  static const connectTime = Duration(seconds: 20);

}

class EndPoints {
  EndPoints._();

  static const pushNotification = 'auth/pushNotification';
  static const getNotifications = 'auth/getNotifications?page={page}&limit={limit}';
}