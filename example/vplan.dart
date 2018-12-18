import 'dart:io';

import 'package:args/args.dart';
import 'package:libvplan/libvplan.dart' as libvplan;

void main(List<String> arguments) {
  final ArgParser argParser = new ArgParser()
    ..addOption('username', abbr: 'u')
    ..addOption('password', abbr: 'p')
    ..addOption('weekday', abbr: 'w');

  var args = argParser.parse(arguments);

  libvplan.Weekday day;

  try {
    day = libvplan.WeekdayConverter.fromStringEN(args['weekday']);
  } catch (error) {
    print(error);
    exit(1);
  }

  var client = libvplan.VplanClient.withCredentials('https://fssgym.de/vplan', args['username'], args['password']);
  client.get(day).then((vplan) {
    print('${vplan.date.date.day}.${vplan.date.date.month}.${vplan.date.date.year} (${libvplan.WeekTypeConverter.toStringDE(vplan.date.weekType)})\n');

    for (var change in vplan.changes) {
      print('${change.form}: ${change.lesson} ${change.subject} ${change.teacher} ${change.room} ${change.info}');
    }

    print('');

    for (var info in vplan.info) {
      print('${info}\n');
    }

    exit(0);
  }).catchError((error) {
    print(error);
    exit(1);
  });
}
