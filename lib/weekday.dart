/// A simple enum for a day of the (working) week.
enum Weekday {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday
}

/// A dummy class holding static methods for `Weekday` <-> `String` conversions.
class WeekdayConverter {
  /// Converts a German string into a `Weekday` (case-insensetive).
  /// Errors if given day of week is not valid.
  static Weekday fromStringDE(String input) {
    switch (input.toLowerCase()) {
      case 'montag':
        return Weekday.Monday;
        break;

      case 'dienstag':
        return Weekday.Tuesday;
        break;

      case 'mittwoch':
        return Weekday.Wednesday;
        break;

      case 'donnerstag':
        return Weekday.Thursday;
        break;

      case 'freitag':
        return Weekday.Friday;
        break;

      default:
        throw 'Invalid day of week!';
    }
  }

  /// Converts an English string into a `Weekday` (case-insensetive).
  /// Errors if given day of week is not valid.
  static Weekday fromStringEN(String input) {
    switch (input.toLowerCase()) {
      case 'monday':
        return Weekday.Monday;
        break;

      case 'tuesday':
        return Weekday.Tuesday;
        break;

      case 'wednesday':
        return Weekday.Wednesday;
        break;

      case 'thursday':
        return Weekday.Thursday;
        break;

      case 'friday':
        return Weekday.Friday;
        break;

      default:
        throw 'Invalid day of week!';
    }
  }

  /// Converts JSON into a `Weekday`.
  /// Errors if given JSON representation is invalid.
  static Weekday fromJson(dynamic json) {
    switch (json) {
      case 0:
        return Weekday.Monday;
        break;

      case 1:
        return Weekday.Tuesday;
        break;

      case 2:
        return Weekday.Wednesday;
        break;

      case 3:
        return Weekday.Thursday;
        break;

      case 4:
        return Weekday.Friday;
        break;

      default:
        throw 'Invalid JSON representation!';
    }
  }

  /// Converts a `Weekday` to the corresponding German string.
  static String toStringDE(Weekday input) {
    String name;

    switch (input) {
      case Weekday.Monday:
        name = 'Montag';
        break;

      case Weekday.Tuesday:
        name = 'Dienstag';
        break;

      case Weekday.Wednesday:
        name = 'Mittwoch';
        break;

      case Weekday.Thursday:
        name = 'Donnerstag';
        break;

      case Weekday.Friday:
        name = 'Freitag';
        break;
    }

    return name;
  }

  /// Converts a `Weekday` to the corresponding English string.
  static String toStringEN(Weekday input) {
    String name;

    switch (input) {
      case Weekday.Monday:
        name = 'Monday';
        break;

      case Weekday.Tuesday:
        name = 'Tuesday';
        break;

      case Weekday.Wednesday:
        name = 'Wednesday';
        break;

      case Weekday.Thursday:
        name = 'Thursday';
        break;

      case Weekday.Friday:
        name = 'Friday';
        break;
    }

    return name;
  }

  /// Converts a `Weekday` to JSON.
  static dynamic toJson(Weekday input) {
    switch (input) {
      case Weekday.Monday:
        return 0;
        break;

      case Weekday.Tuesday:
        return 1;
        break;

      case Weekday.Wednesday:
        return 2;
        break;

      case Weekday.Thursday:
        return 3;
        break;

      case Weekday.Friday:
        return 4;
        break;
    }
  }
}
