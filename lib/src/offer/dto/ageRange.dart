class AgeRange {
  final int? start;
  final int? end;

  AgeRange({this.start, this.end});

  String getFormatted() {
    if (start != null || end != null) {
      final List<int?> ageRange = <int?>[start, end];
      return ageRange.join(" - ");
    }
    return "";
  }
}
