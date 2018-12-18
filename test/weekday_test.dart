import 'package:test/test.dart';

import 'package:libvplan/libvplan.dart';

void main() {
  test('WeekdayConverter fromStringDE() correct input', () {
    expect(WeekdayConverter.fromStringDE('Montag'), equals(Weekday.Monday));
    expect(WeekdayConverter.fromStringDE('Dienstag'), equals(Weekday.Tuesday));
    expect(WeekdayConverter.fromStringDE('Mittwoch'), equals(Weekday.Wednesday));
    expect(WeekdayConverter.fromStringDE('Donnerstag'), equals(Weekday.Thursday));
    expect(WeekdayConverter.fromStringDE('Freitag'), equals(Weekday.Friday));
  });

  test('WeekdayConverter fromStringDE() incorrect input', () {
    expect(() => WeekdayConverter.fromStringDE('Samstag'), throwsA(equals('Invalid day of week!')));
  });

  test('WeekdayConverter fromStringEN() correct input', () {
    expect(WeekdayConverter.fromStringEN('Monday'), equals(Weekday.Monday));
    expect(WeekdayConverter.fromStringEN('Tuesday'), equals(Weekday.Tuesday));
    expect(WeekdayConverter.fromStringEN('Wednesday'), equals(Weekday.Wednesday));
    expect(WeekdayConverter.fromStringEN('Thursday'), equals(Weekday.Thursday));
    expect(WeekdayConverter.fromStringEN('Friday'), equals(Weekday.Friday));
  });

  test('WeekdayConverter fromStringEN() incorrect input', () {
    expect(() => WeekdayConverter.fromStringEN('Saturday'), throwsA(equals('Invalid day of week!')));
  });
}
