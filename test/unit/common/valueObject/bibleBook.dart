import 'package:flutter_test/flutter_test.dart';
import 'package:skg_hagen/src/common/valueObject/bibleBook.dart';

void main(){
  test('BibleBook instantiation with correct parameter', (){
    final BibleBook subject = BibleBook('Psalmen');
    expect(subject.getAbbreviation(), 'Ps.');
  });

  test('BibleBook instantiation with wrong parameter', (){
    expect(() => BibleBook('unknown'), throwsException);
  });
}