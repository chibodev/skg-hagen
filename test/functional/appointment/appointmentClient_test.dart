import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/appointment/dto/appointments.dart';
import 'package:skg_hagen/src/appointment/repository/appointmentClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late AppointmentClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();
  final Map<String, dynamic> queryParams = Map<String, dynamic>();

  setUpAll(() {
    subject = AppointmentClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AppointmentClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(httpClient.getQueryParameters(index: any))
        .thenReturn(queryParams);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        queryParameters: queryParams,
        path: AppointmentClient.PATH,
        object: Appointments,
        cacheData: AppointmentClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'appointments.json'));

    final Appointments? appointments = await subject
        .getAppointments(httpClient, network, index: 0, refresh: true);

    expect(appointments!.appointments!.first.title, 'EAT & PRAY');
    expect(appointments.appointments!.first.occurrence,
        DateTime.parse('2019-11-02'));
    expect(appointments.appointments!.first.time, '12:00:00');
    expect(appointments.appointments!.first.endOccurrence, isNull);
    expect(appointments.appointments!.first.endTime, isNull);
    expect(appointments.appointments!.first.placeName, 'johanniskirche');
    expect(appointments.appointments!.first.street, 'Johanniskirchplatz');
    expect(appointments.appointments!.first.houseNumber, '10');
    expect(appointments.appointments!.first.zip, '58095');
    expect(appointments.appointments!.first.city, 'Hagen');
    expect(appointments.appointments!.first.country, 'DE');
    expect(appointments.appointments!.first.urlFormat, null);
    expect(appointments.appointments!.first.url, null);
    expect(appointments.appointments!.last.title, 'Kindergartengottesdienst');
    expect(appointments.appointments!.last.occurrence,
        DateTime.parse('2019-11-06'));
    expect(appointments.appointments!.last.endOccurrence,
        DateTime.parse('2019-11-06'));
    expect(appointments.appointments!.last.time, '14:15:00');
    expect(appointments.appointments!.last.endTime, '16:15:00');
    expect(appointments.appointments!.last.placeName, 'markuskirche');
    expect(appointments.appointments!.last.street, 'Rheinstraße');
    expect(appointments.appointments!.last.houseNumber, '26');
    expect(appointments.appointments!.last.zip, '58097');
    expect(appointments.appointments!.last.city, 'Hagen');
    expect(appointments.appointments!.last.country, 'DE');
    expect(appointments.appointments!.last.url, 'https://somelink');
    expect(appointments.appointments!.last.urlFormat, 'audio');
  });

  test('AppointmentClient fails and throws Exception', () async {
    dynamic error;

    when(httpClient.setOptions(httpClient, network, any))
        .thenAnswer((_) async => options);
    when(httpClient.getQueryParameters(index: any))
        .thenReturn(queryParams);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        queryParameters: queryParams,
        path: AppointmentClient.PATH,
        object: Appointments,
        cacheData: AppointmentClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getAppointments(httpClient, network,
          index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is NoSuchMethodError, isTrue);
  });
}
