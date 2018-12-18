import 'package:test/test.dart';

import 'package:libvplan/libvplan.dart';

void main() {
  test('WeekTypeConverter fromStringDE() correct input', () {
    expect(WeekTypeConverter.fromStringDE('A-Woche'), equals(WeekType.A));
    expect(WeekTypeConverter.fromStringDE('B-Woche'), equals(WeekType.B));
  });

  test('WeekTypeConverter fromStringDE() incorrect input', () {
    expect(() => WeekTypeConverter.fromStringDE('C-Woche'), throwsA(equals('Invalid type of week!')));
  });
}
