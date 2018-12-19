import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import 'parser.dart';
import 'vplan.dart';
import 'weekday.dart';

/// A client to retrieve timetable changes.
class Client {
  http.Client _client;
  String _url;
  String _authentication;

  /// Creates a client for the specified URL.
  Client(String url) {
    this._client = new http.Client();
    this._url = url;
    this._authentication = null;
  }

  /// Creates a client for the specified URL, using the given `Authentication` header.
  Client.withAuthentication(String url, String authentication) {
    this._client = new http.Client();
    this._url = url;
    this._authentication = authentication;
  }

  /// Creates a client for the specified URL, using HTTP `Basic` authentication.
  Client.withCredentials(String url, String username, String password) {
    String auth = Base64Encoder().convert(Utf8Encoder().convert('${username}:${password}'));
    this._client = new http.Client();
    this._url = url;
    this._authentication = 'Basic ${auth}';
  }

  /// Returns the raw response body for the given day of week.
  Future<String> getString(Weekday day) async {
    String url;

    switch (day) {
      case Weekday.Monday:
        url = path.join(this._url, 'tag_Mo.xml');
        break;

      case Weekday.Tuesday:
        url = path.join(this._url, 'tag_Di.xml');
        break;

      case Weekday.Wednesday:
        url = path.join(this._url, 'tag_Mi.xml');
        break;

      case Weekday.Thursday:
        url = path.join(this._url, 'tag_Do.xml');
        break;

      case Weekday.Friday:
        url = path.join(this._url, 'tag_Fr.xml');
        break;
    }

    http.Response response;

    if (this._authentication == null) {
      response = await this._client.get(url);
    } else {
      response = await this._client.get(url, headers: { 'Authorization': this._authentication });
    }

    return utf8.decode(response.bodyBytes);
  }

  /// Retrieves the timetable changes for the given day of week.
  Future<Vplan> get(Weekday day) async {
    String response = await this.getString(day);
    return Parser.parse(response);
  }
}
