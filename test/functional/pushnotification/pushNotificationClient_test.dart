import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/pushnotification/dto/pushNotifications.dart';
import 'package:skg_hagen/src/pushnotification/repository/pushNotificationClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late PushNotificationClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();
  final Map<String, dynamic> queryParams = Map<String, dynamic>();

  setUpAll(() {
    subject = PushNotificationClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('PushNotificationClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(httpClient.getQueryParameters(index: any)).thenReturn(queryParams);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        queryParameters: queryParams,
        path: PushNotificationClient.PATH,
        object: PushNotifications,
        cacheData: PushNotificationClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.ok, path: 'push_notification.json'));

    final PushNotifications? pushNotifications = await subject.getPushNotifications(httpClient, network, index: 0, refresh: true);

    expect(pushNotifications!.pushNotification.first.title, 'Appointment: Choir');
    expect(pushNotifications.pushNotification.first.validUntil, DateTime.parse('2020-03-29'));
    expect(pushNotifications.pushNotification.first.body, 'Gathering of Holy Voices. Join Us');
    expect(pushNotifications.pushNotification.first.screen, '/appointment');
  });

  test('PushNotificationClient fails and throws Exception', () async {
    dynamic error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(httpClient.getQueryParameters(index: any)).thenReturn(queryParams);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        queryParameters: queryParams,
        path: PushNotificationClient.PATH,
        object: PushNotifications,
        cacheData: PushNotificationClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getPushNotifications(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is NoSuchMethodError, isTrue);
  });
}
