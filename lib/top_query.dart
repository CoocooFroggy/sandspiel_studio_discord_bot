import 'dart:convert';

import 'package:http/http.dart';

import 'objects/ss_query.dart';

class TopQuery {
  static Future<SSQuery> fetchTop() async {
    Uri uri = Uri.https('studio.sandspiel.club', '/api/query', {
      'order': 'top',
      'days': '30',
      'edit': 'false',
      'admin': 'true',
      'featured': 'true',
      'take': '10',
      'skip': '10',
    });

    var response = await get(uri);
    return SSQuery.fromJson(jsonDecode(response.body));
  }
}
