import 'package:intl/intl.dart' as intl;
import 'package:intl/date_symbol_data_local.dart' as intlSymbol;
import 'package:xml/xml.dart' as xml;

import 'vplan.dart';
import 'weekday.dart';
import 'weektype.dart';

/// Indicates why parsing went wrong.
enum ParserErrorKind {
  /// Parsing of the actual XML went wrong.
  XMLParserError,
  /// Important elements such as date were not found and the document is therefor not valid.
  MissingElements,
  /// Parsing of dates from the document went wrong.
  DateParsingError
}

/// An error while parsing.
class ParserError {
  /// What went wrong.
  ParserErrorKind kind;
  /// Detailed (upstream) error.
  var error;

  ParserError(this.kind, this.error);
}

/// A dummy class holding the static method for parsing timetable changes.
class Parser {
  /// Parses an XML string into a `Vplan` structure.
  /// Throws `ParserError`.
  static Future<Vplan> parse(String input) async {
    await intlSymbol.initializeDateFormatting('de', null);

    xml.XmlDocument document;

    try {
      document = xml.parse(input);
    } catch (error) {
      throw ParserError(ParserErrorKind.XMLParserError, error);
    }

    Weekday weekday = null;
    VplanDate date = null;

    for (xml.XmlElement node in document.findAllElements('titel')) {
      List<String> split = node.text.trim().split(', ');

      if (split.length != 2) {
        throw ParserError(ParserErrorKind.MissingElements, 'Incomplete date!');
      }

      try {
        weekday = WeekdayConverter.fromStringDE(split[0]);
      } catch (error) {
        throw ParserError(ParserErrorKind.DateParsingError, error);
      }

      String dateString = split[1];

      WeekType weektype;

      try {
        weektype = WeekTypeConverter.fromStringDE(dateString.substring(dateString.length - 8, dateString.length - 1));
      } catch (error) {
        throw ParserError(ParserErrorKind.DateParsingError, error);
      }

      dateString = dateString.substring(0, dateString.length - 10);

      intl.DateFormat format = new intl.DateFormat.yMMMMd('de');
      DateTime dateTime;

      try {
        dateTime = format.parse(dateString);
      } catch (error) {
        throw ParserError(ParserErrorKind.DateParsingError, error);
      }

      date = VplanDate(dateTime, weektype);
    }

    if (weekday == null) {
      throw ParserError(ParserErrorKind.MissingElements, 'Weekday not found!');
    }

    if (date == null) {
      throw ParserError(ParserErrorKind.MissingElements, 'Date not found!');
    }

    DateTime changed;

    for (xml.XmlElement node in document.findAllElements('datum')) {
      intl.DateFormat format = new intl.DateFormat.yMd('de').add_jm();

      try {
        changed = format.parse(node.text.replaceAll(new RegExp(r','), ''));
      } catch (error) {
        throw ParserError(ParserErrorKind.DateParsingError, error);
      }
    }

    if (changed == null) {
      throw ParserError(ParserErrorKind.DateParsingError, 'Date changed not found!');
    }

    List<DateTime> daysOff = new List();

    for (xml.XmlElement node in document.findAllElements('ft')) {
      DateTime dayOff;

      try {
        dayOff = DateTime.parse('20${node.text}');
      } catch (error) {
        throw ParserError(ParserErrorKind.DateParsingError, error);
      }

      daysOff.add(dayOff);
    }

    List<Change> changes = new List();

    for (xml.XmlElement node in document.findAllElements('aktion')) {
      String form = '';
      String lesson = '';
      String subject = '';
      String teacher = '';
      String room = '';
      String info = '';

      for (xml.XmlElement node in node.findElements('klasse')) {
        form = node.text;
      }

      for (xml.XmlElement node in node.findElements('stunde')) {
        lesson = node.text;
      }

      for (xml.XmlElement node in node.findElements('fach')) {
        subject = node.text;
      }

      for (xml.XmlElement node in node.findElements('lehrer')) {
        teacher = node.text;
      }

      for (xml.XmlElement node in node.findElements('raum')) {
        room = node.text;
      }

      for (xml.XmlElement node in node.findElements('info')) {
        info = node.text;
      }

      changes.add(Change(form, lesson, subject, teacher, room, info));
    }

    List<String> info = new List();

    for (xml.XmlElement node in document.findAllElements('fussinfo')) {
      if (node.text.length > 0) {
        info.add(node.text);
      }
    }

    return Vplan(weekday, date, changed, daysOff, changes, info);
  }
}
