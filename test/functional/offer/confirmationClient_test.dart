import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/offer/dto/confirmation.dart';
import 'package:skg_hagen/src/offer/repository/confirmationClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late ConfirmationClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = ConfirmationClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('ConfirmationClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: ConfirmationClient.PATH,
        object: Confirmation,
        cacheData: ConfirmationClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.ok, path: 'confirmation.json'));

    final Confirmation? confirmation = await subject.getConfirmation(httpClient, network, refresh: true);

    expect(confirmation!.appointment, isNotEmpty);
    expect(confirmation.appointment!.first.title, 'Osternacht (inkl. Passahmahl mit Gottesdienst am Ostersonntag)');
    expect(confirmation.appointment!.first.occurrence, DateTime.parse('2020-04-11'));
    expect(confirmation.appointment!.first.time, '17:00:00');
    expect(confirmation.appointment!.first.endOccurrence, DateTime.parse('2020-04-12'));
    expect(confirmation.appointment!.first.endTime, '12:00:00');
    expect(confirmation.appointment!.first.infoTitle, null);
    expect(confirmation.appointment!.first.placeName, 'markuskirche');
    expect(confirmation.appointment!.first.room, '');
    expect(confirmation.appointment!.first.organizer, null);
    expect(confirmation.appointment!.first.email, null);
    expect(confirmation.appointment!.first.name, 'markuskirche');
    expect(confirmation.appointment!.first.street, 'Rheinstraße');
    expect(confirmation.appointment!.first.houseNumber, '26');
    expect(confirmation.appointment!.first.zip, '58097');
    expect(confirmation.appointment!.first.city, 'Hagen');
    expect(confirmation.appointment!.first.country, 'DE');
    expect(confirmation.appointment!.last.endOccurrence, null);
    expect(confirmation.appointment!.last.endTime, null);
    expect(confirmation.appointment!.length, 2);

    expect(confirmation.concept, isNotEmpty);
    expect(confirmation.concept!.first.description.contains('Konfirmandenarbeit in unserer Gemeinde'), true);
    expect(confirmation.concept!.length, 1);

    expect(confirmation.quote, isNotEmpty);
    expect(confirmation.quote!.first.text.contains('Ich bin die Auferstehung und das Leben.'), true);
    expect(confirmation.quote!.first.book, 'Johannes');
    expect(confirmation.quote!.first.chapter, '11');
    expect(confirmation.quote!.first.verse, '25');
    expect(confirmation.quote!.first.text.contains('Wer an mich glaubt, der wird leben, auch wenn er stirbt.'), true);
    expect(confirmation.quote!.last.book, 'Jeremia');
    expect(confirmation.quote!.last.chapter, '29');
    expect(confirmation.quote!.last.verse, '13+14');
    expect(confirmation.quote!.length, 3);
  });

  test('ConfirmationClient fails and throws Exception', () async {
    final Confirmation? confirmation;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        path: ConfirmationClient.PATH,
        object: Confirmation,
        options: options,
        cacheData: ConfirmationClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    confirmation = await subject.getConfirmation(httpClient, network, index: 0, refresh: false);

    expect(confirmation, isNotNull);
    expect(confirmation?.appointment, isNull);
    expect(confirmation?.concept, isNull);
    expect(confirmation?.quote, isNull);
  });
}
