import 'package:awesome_notifications/awesome_notifications.dart';

notificationTrigger({required String location}) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      actionType: ActionType.Default,
      title: 'Impulse Buying Alert',
      body:
          'You have reached $location. Kindly check your budget before you make any purchase',
    ),
  );
}
