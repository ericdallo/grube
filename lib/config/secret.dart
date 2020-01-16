import 'dart:async' show Future;
import 'dart:convert' show json;

import 'package:flutter/services.dart' show rootBundle;

class SecretManager {
  static Secret _secret;

  SecretManager._();

  static void init() async {
    _secret = await loadConfig();
  }

  static Future<Secret> loadConfig() async {
    return rootBundle.loadStructuredData<Secret>("assets/secrets.json",
        (jsonStr) async {
      return Secret.fromJson(json.decode(jsonStr));
    });
  }

  static Secret get secrets => _secret;
}

class Secret {
  final String apiURL;

  Secret({
    this.apiURL = "",
  });

  factory Secret.fromJson(Map<String, dynamic> json) {
    return new Secret(apiURL: json["api_url"]);
  }
}
