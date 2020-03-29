import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/pushnotification/model/pushNotifications.dart';
import 'package:skg_hagen/src/pushnotification/repository/pushNotificationClient.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  PushNotificationClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = PushNotificationClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('PushNotificationClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        object: PushNotifications,
        cacheData: anyNamed('cacheData'),
        path: 'app/push/notification',
        options: anyNamed('options'),
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'push_notification.json'));

    final PushNotifications pustNotifications = await subject
        .getPushNotifications(httpClient, network, index: 0, refresh: true);

    expect(
        pustNotifications.pushNotification.first.title, 'Appointment: Choir');
    expect(pustNotifications.pushNotification.first.validUntil,
        DateTime.parse('2020-03-29'));
    expect(pustNotifications.pushNotification.first.body,
        'Gathering of Holy Voices. Join Us');
    expect(pustNotifications.pushNotification.first.screen, '/appointment');
  });

  test('PushNotificationClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        object: PushNotifications,
        cacheData: anyNamed('cacheData'),
        path: 'app/push/notification',
        options: anyNamed('options'),
        queryParameters: anyNamed('queryParameters'),
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getPushNotifications(httpClient, network,
          index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
