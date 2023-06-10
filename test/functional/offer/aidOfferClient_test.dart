import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:skg_hagen/src/offer/dto/aid.dart';
import 'package:skg_hagen/src/offer/dto/helper.dart';
import 'package:skg_hagen/src/offer/repository/aidOfferClient.dart';

import '../../mock/httpClientMock.dart';

void main() {
  late AidOfferClient subject;
  late MockDioHTTPClient httpClient;
  late MockNetwork network;
  final Options options = Options();

  setUpAll(() {
    subject = AidOfferClient();
    httpClient = MockDioHTTPClient();
    network = MockNetwork();
  });

  test('AidOfferClient successfully retrieves data', () async {
    when(network.hasInternet()).thenAnswer((_) async => true);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: AidOfferClient.PATH,
        object: Aid,
        cacheData: AidOfferClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.ok, path: 'aid_offer.json'));

    final Aid? aid = await subject.getAidOffer(httpClient, network, refresh: true);

    expect(aid!.offer!.title, 'Helfer');
    expect(aid.offer!.description, 'Ja, DICH suchen wir');
    expect(aid.offer!.phone, '02795 80989');
    expect(aid.offer!.email, 'emaile@email.de');

    expect(aid.receive!.title, 'Hilfe-Suchende');
    expect(aid.receive!.description, 'Liebe Gemeindemitglieder');
    expect(aid.receive!.phone, '02795 80989');
    expect(aid.receive!.email, 'email@email.de');

    expect(aid.offerQuestion, isNotEmpty);
    expect(aid.offerQuestion!.length, 2);
    expect(aid.offerQuestion!.first.question, 'Was ich machen kann');
    expect(aid.offerQuestion!.first.type, 'checkbox');
    expect(aid.offerQuestion!.first.option![0], 'Einkäufe');
    expect(aid.offerQuestion!.first.option![1], 'Besorgungen');
    expect(aid.offerQuestion!.last.question, 'Über mich');
    expect(aid.offerQuestion!.last.type, 'text');
    expect(aid.offerQuestion!.last.option![0], 'Name');
    expect(aid.offerQuestion!.last.option![1], 'Alter');
    expect(aid.offerQuestion!.last.option![2], 'Wohnort (Ortteil)');
    expect(aid.offerQuestion!.last.option![3], 'Sie erreichen mich');
  });

  test('AidOfferClient fails ', () async {
    final Aid? result;

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, any)).thenAnswer((_) async => options);
    when(
      httpClient.getJSONResponse(
        http: httpClient,
        options: options,
        path: AidOfferClient.PATH,
        object: Aid,
        cacheData: AidOfferClient.CACHE_DATA,
      ),
    ).thenAnswer((_) async => HTTPClientMock.getJSONRequest(statusCode: HttpStatus.unauthorized));

    result = await subject.getAidOffer(httpClient, network, index: 0, refresh: false);

    expect(result?.offer, isNull);
    expect(result?.receive, isNull);
    expect(result?.offerQuestion, isNull);
  });

  test('AidOfferClient successfully sends aid offer', () async {
    final Helper helper = Helper(shopping: true, errands: false, animalWalk: true, name: 'Ali D', age: '29', city: 'D-Town', contact: 'd@town.de');
    final Map<String, dynamic> payload = helper.toJson();

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, false)).thenAnswer((_) async => options);

    when(httpClient.postJSON(http: httpClient, path: AidOfferClient.PATH, data: payload, options: options))
        .thenAnswer((_) async => HTTPClientMock.formPost(statusCode: HttpStatus.ok, path: AidOfferClient.PATH));

    final bool response = await subject.saveHelper(httpClient, network, helper);

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
    final Helper helper = Helper(shopping: true, errands: false, animalWalk: true, name: '', age: '', city: '', contact: '');
    final Map<String, dynamic> payload = helper.toJson();

    when(network.hasInternet()).thenAnswer((_) async => false);
    when(httpClient.setOptions(httpClient, network, false)).thenAnswer((_) async => options);

    when(httpClient.postJSON(http: httpClient, path: AidOfferClient.PATH, data: payload, options: options))
        .thenAnswer((_) async => HTTPClientMock.formPost(statusCode: HttpStatus.badRequest, path: AidOfferClient.PATH));

    final bool response = await subject.saveHelper(httpClient, network, helper);

    expect(response, isFalse);
  });
}
