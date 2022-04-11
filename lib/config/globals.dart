library globals;

import 'package:http/http.dart' as http;

// Creates global variable of an http client to be set and stored for testing
http.Client httpClient = http.Client();