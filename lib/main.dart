import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:geofence_foreground_service/constants/geofence_event_type.dart';
import 'package:geofence_foreground_service/geofence_foreground_service.dart';
import 'package:get_it/get_it.dart';
import 'package:sika_purse/src/core/notification.dart';

import 'src/app.dart';
import 'src/di/di.dart';
import 'src/domain/recurring/repository/recurring_repository.dart';

@pragma('vm:entry-point')
void callbackDispatcher() async {
  GeofenceForegroundService().handleTrigger(
    backgroundTriggerHandler: (zoneID, triggerType) {
      print('$zoneID zoneID');
      if (triggerType == GeofenceEventType.enter) {
        print('enter triggerType');
        notificationTrigger(location: zoneID);
      } else if (triggerType == GeofenceEventType.exit) {
        print('exit triggerType');
      } else if (triggerType == GeofenceEventType.dwell) {
        print('dwell triggerType');
      } else {
        print('unknown triggerType');
      }

      return Future.value(true);
    },
  );
}

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configInjector(getIt);
  getIt.get<RecurringRepository>().checkForRecurring();

  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      // channelGroups: [
      //   NotificationChannelGroup(
      //       channelGroupKey: 'basic_channel_group',
      //       channelGroupName: 'Basic group')
      // ],
      debug: false); // DEBUG

  runApp(const SikaPurseApp());
}
