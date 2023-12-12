import 'variable.dart';
import 'dart:convert';
//https://dart.dev/samples
//https://dart.dev/guides/language/language-tour#variables

void main() {
  print('hello banh mi SG');
  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }
  /** Convert List to String JSON*/
  String jsonTutorial = jsonEncode(flybyObject);
  print('Json String ==> ${jsonTutorial}');

  final json = jsonDecode(jsonTutorial);
  print('Json ==> ${json}');
  /** array */
  // for (final object in flybyObject) {
  //   print(object);
  // }
  /** month */
  // for (int month = 1; month <= 12; month++) {
  //   print(month);
  // }
  /** year */
  // while (year < 2016) {
  //   year += 1;
  // }
  /** fibonacci */
  var result = fibonacci(20);
  print('fibonacci ${result}');

  flybyObject.where((name) => name.contains('turn')).forEach(print);

  var voyager = Spacecraft('Voyager I', DateTime(1954, 9, 5));
  voyager.describe();

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();
}
