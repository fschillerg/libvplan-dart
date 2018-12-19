/// An enum representing the type of week.
enum WeekType {
  A,
  B
}

/// A dummy class holding static methods for `WeekType` <-> `String` conversions.
class WeekTypeConverter {
  /// Converts a German string into a `WeekType`.
  /// Errors if given type of week is not valid.
  static WeekType fromStringDE(String input) {
    switch (input) {
      case 'A-Woche':
        return WeekType.A;
        break;

      case 'B-Woche':
        return WeekType.B;
        break;

      default:
        throw 'Invalid type of week!';
    }
  }

  /// Converts a `WeekType` to the corresponding German string.
  static String toStringDE(WeekType input) {
    String name;

    switch (input) {
      case WeekType.A:
        name = 'A-Woche';
        break;

      case WeekType.B:
        name = 'B-Woche';
        break;
    }

    return name;
  }
}
