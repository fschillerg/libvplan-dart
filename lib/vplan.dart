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

  /// Converts JSON into a `Vplan`.
  static Vplan fromJson(dynamic json) {
    return Vplan(
      WeekdayConverter.fromJson(json['weekday']),
      VplanDate.fromJson(json['date']),
      DateTime.fromMillisecondsSinceEpoch(json['changed']),
      (json['days_off'] as List).map((dayOff) => DateTime.fromMillisecondsSinceEpoch(dayOff)),
      (json['changes'] as List).map((change) => Change.fromJson(change)),
      json['info'] as List
    );
  }

  /// Converts a `Vplan` to JSON.
  dynamic toJson() => {
    'weekday': WeekdayConverter.toJson(this.weekDay),
    'date': this.date.toJson(),
    'changed': this.changed.millisecondsSinceEpoch,
    'days_off': this.daysOff.map((dayOff) => dayOff.millisecondsSinceEpoch),
    'changes': this.changes.map((change) => change.toJson()),
    'info': this.info
  };
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

  /// Converts JSON into a `Change`.
  static Change fromJson(dynamic json) {
    return Change(
      json['form'],
      json['lesson'],
      json['subject'],
      json['teacher'],
      json['room'],
      json['info']
    );
  }

  /// Converts a `Change` to JSON.
  dynamic toJson() => {
    'form': this.form,
    'lesson': this.lesson,
    'subject': this.subject,
    'teacher': this.teacher,
    'room': this.room,
    'info': this.info
  };
}

/// A date type specific to the timetable change.
class VplanDate {

  /// The date for which the timetable change is.
  DateTime date;

  /// The type of week (A or B) the day is in.
  WeekType weekType;

  VplanDate(this.date, this.weekType);

  /// Converts JSON into a `VplanDate`.
  static VplanDate fromJson(dynamic json) {
    return VplanDate(
      DateTime.fromMillisecondsSinceEpoch(json['date']),
      WeekTypeConverter.fromJson(json['week_type'])
    );
  }

  /// Converts a `VplanDate` to JSON.
  dynamic toJson() => {
    'date': this.date.millisecondsSinceEpoch,
    'week_type': WeekTypeConverter.toJson(this.weekType)
  };
}
