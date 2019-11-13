class AgeRange {
  final int start;
  final int end;

  AgeRange({this.start, this.end});

  String getFormatted() {
    final List<int> ageRange = <int>[start, end];
    return ageRange.join(" - ");
  }
}
