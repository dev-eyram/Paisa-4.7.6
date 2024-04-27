import 'package:flutter/material.dart';
import 'package:geofence_foreground_service/exports.dart';
import 'package:geofence_foreground_service/geofence_foreground_service.dart';
import 'package:geofence_foreground_service/models/notification_icon_data.dart';
import 'package:geofence_foreground_service/models/zone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sika_purse/main.dart';

class GeoFencing extends ChangeNotifier {
  // final List<LatLng> workPlacePolygon = [
  //   const LatLng(5.644152, -0.154851),
  //   // const LatLng(-0.154851, 5.644152),
  //   // const LatLng(40.757881, -73.985493),
  //   // const LatLng(40.757956, -73.985688),
  // ];
  final List<LatLng> jesusIsLord = [const LatLng(5.800360, -0.119380)];
  final List<LatLng> prinkleMart = [const LatLng(5.801420, -0.121520)];
  final List<LatLng> otisPharmacy = [const LatLng(5.799130, -0.127560)];
  final List<LatLng> jJNorteyGroceries = [const LatLng(5.797840, -0.120230)];
  final List<LatLng> mABediakoGroceries = [const LatLng(5.798730, -0.120830)];
  final List<LatLng> valleyViewBakery = [const LatLng(5.797670, -0.126260)];

  GeoFencing() {
    print("Starting GeoFence");
    initPlatformState();
    print("Ending GeoFence");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      await Permission.location.request();
      await Permission.locationAlways.request();
      await Permission.notification.request();

      bool hasServiceStarted =
          await GeofenceForegroundService().startGeofencingService(
        contentTitle: 'Notification Active',
        contentText:
            'Notification alert is active to inform you about impulse buying at some known locations',
        notificationChannelId: 'com.app.geofencing_notifications_channel',
        serviceId: 525600,
        isInDebugMode: false, //DEBUG
        notificationIconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
        callbackDispatcher: callbackDispatcher,
      );

      print("Service $hasServiceStarted");

      if (hasServiceStarted) {
        await GeofenceForegroundService().addGeofenceZone(
          zone: Zone(
            id: 'Jesus Is Lord',
            radius: 150,
            coordinates: jesusIsLord,
          ),
        );
        await GeofenceForegroundService().addGeofenceZone(
          zone: Zone(
            id: 'Prinkle Mart',
            radius: 150,
            coordinates: prinkleMart,
          ),
        );
        await GeofenceForegroundService().addGeofenceZone(
          zone: Zone(
            id: 'Otis Pharmacy',
            radius: 150,
            coordinates: otisPharmacy,
          ),
        );
        await GeofenceForegroundService().addGeofenceZone(
          zone: Zone(
            id: 'JJ Nortey Groceries',
            radius: 150,
            coordinates: jJNorteyGroceries,
          ),
        );
        await GeofenceForegroundService().addGeofenceZone(
          zone: Zone(
            id: 'MA Bediako Groceries',
            radius: 150,
            coordinates: mABediakoGroceries,
          ),
        );
        // await GeofenceForegroundService().addGeofenceZone(
        //   zone: Zone(
        //     id: 'Valley View Bakery',
        //     radius: 150,
        //     coordinates: valleyViewBakery,
        //   ),
        // );
      }

      print('${hasServiceStarted.toString()} : hasServiceStarted');
    } catch (error) {
      print(error.toString());
    }
  }
}
