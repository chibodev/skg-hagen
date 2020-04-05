import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/common/service/client/dioHttpClient.dart';
import 'package:skg_hagen/src/common/service/network.dart';
import 'package:skg_hagen/src/offer/dto/aid.dart';
import 'package:skg_hagen/src/offer/dto/helper.dart';
import 'package:skg_hagen/src/offer/repository/aidOfferClient.dart';

import '../../mock/httpClientFormMock.dart';
import '../../mock/httpClientMock.dart';

class MockDioHTTPClient extends Mock implements DioHTTPClient {}

class MockNetwork extends Mock implements Network {}

void main() {
  AidOfferClient subject;
  MockDioHTTPClient httpClient;
  MockNetwork network;

  setUpAll(() {
    subject = AidOfferClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AidOfferClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => true);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        path: 'app/aid_offer',
        object: Aid,
        options: anyNamed('options'),
        cacheData: 'app/aid_offer/data',
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(
        statusCode: HttpStatus.ok, path: 'aid_offer.json'));

    final Aid aid =
        await subject.getAidOffer(httpClient, network, refresh: true);

    expect(aid.offer.title, 'Helfer');
    expect(aid.offer.description, 'Ja, DICH suchen wir');
    expect(aid.offer.phone, '02795 80989');
    expect(aid.offer.email, 'emaile@email.de');

    expect(aid.receive.title, 'Hilfe-Suchende');
    expect(aid.receive.description, 'Liebe Gemeindemitglieder');
    expect(aid.receive.phone, '02795 80989');
    expect(aid.receive.email, 'email@email.de');

    expect(aid.offerQuestion, isNotEmpty);
    expect(aid.offerQuestion.length, 2);
    expect(aid.offerQuestion.first.question, 'Was ich machen kann');
    expect(aid.offerQuestion.first.type, 'checkbox');
    expect(aid.offerQuestion.first.option[0], 'Einkäufe');
    expect(aid.offerQuestion.first.option[1], 'Besorgungen');
    expect(aid.offerQuestion.last.question, 'Über mich');
    expect(aid.offerQuestion.last.type, 'text');
    expect(aid.offerQuestion.last.option[0], 'Name');
    expect(aid.offerQuestion.last.option[1], 'Alter');
    expect(aid.offerQuestion.last.option[2], 'Wohnort (Ortteil)');
    expect(aid.offerQuestion.last.option[3], 'Sie erreichen mich');
  });

  test('AidOfferClient fails to get data and throws Exception', () async {
    DioError error;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        path: 'app/aid_offer',
        object: Aid,
        options: anyNamed('options'),
        cacheData: 'app/aid_offer/data',
      ),
    ).thenAnswer((_) async =>
        HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    try {
      await subject.getAidOffer(httpClient, network, index: 0, refresh: false);
    } catch (e) {
      error = e;
    }

    expect(error, isNotNull);
    expect(error is Exception, isTrue);
    expect(error.error.statusCode, HttpStatus.unauthorized);
  });

  test('AidOfferClient successfully sends aid offer', () async {
    final Helper helper = Helper(
        shopping: true,
        errands: false,
        animalWalk: true,
        name: 'Ali D',
        age: '29',
        city: 'D-Town',
        contact: 'd@town.de');

    when(httpClient.postJSON(
            http: httpClient,
            path: 'app/aid_offer',
            data: anyNamed('data'),
            options: anyNamed('options')))
        .thenAnswer((_) async =>
            HTTPClientFormMock.formPost(statusCode: HttpStatus.ok));

    final bool response =
        await subject.saveHelper(httpClient, Network(), helper);
    final Map<String, dynamic> payload = helper.toJson();

    expect(payload['shopping'], 1);
    expect(payload['errands'], 0);
    expect(payload['animal_walk'], 1);
    expect(payload['name'], 'Ali D');
    expect(payload['age'], '29');
    expect(payload['city'], 'D-Town');
    expect(payload['contact'], 'd@town.de');
    expect(payload['reason'], null);
    expect(response, isTrue);
  });

  test('AidOfferClient fails to send offer aid', () async {
    when(httpClient.postJSON(
            http: httpClient,
            path: 'app/aid_offer',
            data: anyNamed('data'),
            options: anyNamed('options')))
        .thenAnswer((_) async =>
            HTTPClientFormMock.formPost(statusCode: HttpStatus.badRequest));

    final bool response =
        await subject.saveHelper(httpClient, Network(), Helper());

    expect(response, isFalse);
  });
}
