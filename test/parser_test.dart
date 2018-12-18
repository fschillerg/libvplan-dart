import 'dart:io';

import 'package:test/test.dart';

import 'package:libvplan/libvplan.dart';

void main() {
  test('Parser parse() correct input', () async {
    expect(await parse('correct_1.xml'), const TypeMatcher<Vplan>());
    expect(await parse('correct_2.xml'), const TypeMatcher<Vplan>());
    expect(await parse('correct_3.xml'), const TypeMatcher<Vplan>());
  });

  test('Parser parse() incorrect input', () async {
    expect(parse('incorrect_1.xml'), throwsA(const TypeMatcher<ParserError>()));
    expect(parse('incorrect_2.xml'), throwsA(const TypeMatcher<ParserError>()));
    expect(parse('incorrect_3.xml'), throwsA(const TypeMatcher<ParserError>()));
  });
}

Future<Vplan> parse(String file) async {
  String input = await new File('test/data/${file}').readAsString();

  try {
    return Parser.parse(input);
  } catch (error) {
    rethrow;
  }
}
