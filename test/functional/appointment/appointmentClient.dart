import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/appointment/model/appointments.dart';
import 'package:skg_hagen/src/appointment/repository/appointmentClient.dart';
import 'package:skg_hagen/src/common/model/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';

import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  AppointmentClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = AppointmentClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AppointmentClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.get(
            path: 'app/appointments',
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async => HTTPClientMock.getRequest(
            statusCode: HttpStatus.ok, path: 'appointments.json'));

    final Appointments appointments = await subject
        .getAppointments(httpClient, network, index: 0, refresh: true);

    expect(appointments.appointments.first.title, 'EAT & PRAY');
    expect(appointments.appointments.first.occurrence,
        DateTime.parse('2019-11-02'));
    expect(appointments.appointments.first.time, '12:00:00');
    expect(appointments.appointments.first.placeName, 'johanniskirche');
    expect(appointments.appointments.first.street, 'Johanniskirchplatz');
    expect(appointments.appointments.first.houseNumber, '10');
    expect(appointments.appointments.first.zip, '58095');
    expect(appointments.appointments.first.city, 'Hagen');
    expect(appointments.appointments.first.country, 'DE');
    expect(appointments.appointments.last.title, 'Kindergartengottesdienst');
    expect(appointments.appointments.last.occurrence,
        DateTime.parse('2019-11-06'));
    expect(appointments.appointments.last.time, '14:15:00');
    expect(appointments.appointments.last.placeName, 'markuskirche');
    expect(appointments.appointments.last.street, 'Rheinstraße');
    expect(appointments.appointments.last.houseNumber, '26');
    expect(appointments.appointments.last.zip, '58097');
    expect(appointments.appointments.last.city, 'Hagen');
    expect(appointments.appointments.last.country, 'DE');
  });

  test('AppointmentClient fails and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.get(
            path: 'app/appointments',
            options: anyNamed('options'),
            queryParameters: anyNamed('queryParameters')))
        .thenAnswer((_) async =>
            HTTPClientMock.getRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getAppointments(httpClient, network,
          index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });
}
