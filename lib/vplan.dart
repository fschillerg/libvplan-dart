import 'weekday.dart';
import 'weektype.dart';

/// A complete timetable change document.
class Vplan {
  /// The day of week the document is for.
  Weekday weekDay;

  /// The day the document is for.
  VplanDate date;

  /// The last time the document was changed.
  DateTime changed;

  /// A list of days off from school.
  List<DateTime> daysOff;

  /// The actual list of changes.
  List<Change> changes;

  /// Additional information.
  List<String> info;

  Vplan(this.weekDay, this.date, this.changed, this.daysOff, this.changes, this.info);
}

/// A single change.
class Change {
  /// The form getting a change.
  String form;

  /// The lesson for which the change happens.
  String lesson;

  /// The (new) subject.
  String subject;

  /// The (new) teacher.
  String teacher;

  /// The (new) room.
  String room;

  /// Additional information.
  String info;

  Change(this.form, this.lesson, this.subject, this.teacher, this.room, this.info);
}

/// A date type specific to the timetable change.
class VplanDate {

  /// The date for which the timetable change is.
  DateTime date;

  /// The type of week (A or B) the day is in.
  WeekType weekType;

  VplanDate(this.date, this.weekType);
}
