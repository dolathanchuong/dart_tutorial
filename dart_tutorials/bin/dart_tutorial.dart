// ignore: depend_on_referenced_packages
// <- required or firstWhereOrNull is not defined
///new python to dart
///11111111111111111111
import 'package:webdriver/sync_io.dart';
import 'dart:convert';
import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:http/http.dart' as http;

// void main(List<String> arguments) {
//   print('\n---\n');
//   print('Hello world: ${banhmi.calculate()}!');
//   print('\n---\n');
//   // forEach()
//   var arr = banhmi.banhmi();
//   for (var fruit in arr) {
//     print(fruit);
//   }
//   print('\n---\n');
//   // map()
//   var mappedFruits = arr.map((fruit) => 'I love $fruit').toList();
//   print(mappedFruits);
//   print('\n---\n');
//   // contains()
//   var numbers = [1, 3, 2, 5, 4];
//   print(numbers.contains(2)); // => true

//   print('\n---\n');

//   // sort
//   numbers.sort((num1, num2) => num1 - num2);
//   print(numbers); // => [1, 2, 3, 4, 5]

//   print('\n---\n');

//   // reduce(), fold()
//   var sum = numbers.reduce((current, next) => current + next);
//   print(sum); // => 15

//   const initialValue = 10;
//   var sum2 = numbers.fold(initialValue, (current, next) => current + next);
//   print(sum2); // => 25

//   print('\n---\n');

//   // every()
//   List<Map<String, dynamic>> users = [
//     {"name": 'Jane', "age": 18},
//     {"name": 'Jim', "age": 21},
//     {"name": 'Mary', "age": 23},
//   ];
//   var is18AndOver = users.every((user) => user["age"] >= 18);
//   print(is18AndOver); // => true

//   var hasNamesWithJ = users.every((user) => user["name"].startsWith('J'));
//   print(hasNamesWithJ); // => false

//   print('\n---\n');

//   // where(), firstWhere(), singleWhere()
//   var over21s = users.where((user) => user["age"] > 21);
//   print(over21s.length); // => 1

//   var under18s = users.singleWhereOrNull((user) => user["age"] < 18);
//   print(under18s); // => null

//   var nameJ = users.firstWhere((user) => user["name"].startsWith('J'));
//   print(nameJ); // => {name: Jane, age: 18}

//   print('\n---\n');

//   // take(), skip()
//   var fiboNumbers = [1, 2, 3, 5, 8, 13, 21];
//   print(fiboNumbers.take(3).toList()); // => [1, 2, 3]
//   print(fiboNumbers.skip(5).toList()); // => [13, 21]
//   print(fiboNumbers.take(3).skip(2).take(1).toList()); // => [3]

//   print('\n---\n');

//   // List.from()
//   var clonedFiboNumbers = List.from(fiboNumbers);
//   print(clonedFiboNumbers); // => [1, 2, 3, 5, 8, 13, 21]

//   print('\n---\n');

//   // expand()
//   var pairs = [
//     [1, 2],
//     [3, 4]
//   ];
//   var flattened = pairs.expand((pair) => pair).toList();
//   print('Flattened result: $flattened'); // => [1, 2, 3, 4]

//   var input = [1, 2, 3];
//   var duplicated = input.expand((i) => [i, i + 1]).toList();
//   print(duplicated); // => [1, 1, 2, 2, 3, 3, 4, 4]

//   print('\n---\n');
// }

Future<void> main(List<String> arguments) async {
  try {
    TikTok tk = TikTok();
    var uuu = await tk.oneVideoInfo('');
    print(uuu);
  } catch (e) {
    print('Error: $e');
  }
}

class TikTok {
  late WebDriver driver;
  late Map<String, String> headers;

  TikTok() {
    Uri customUri = Uri.parse('http://127.0.0.1:3333/wd/hub');
    // driver = createDriver(desired: Capabilities.chrome);
    driver = createDriver(uri: customUri);
    headers = {
      "user-agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
    };
  }

  Future<String> videoShareLinkConvert(String shareLink) async {
    var temp = shareLink.split("com/")[1].split("/")[0];
    var shareUrl = Uri.parse("https://v.douyin.com/$temp");

    var response = await http.get(shareUrl, headers: headers);
    var awemeId = response.request!.url.toString().split('/')[5];

    return "https://www.douyin.com/video/$awemeId";
  }

  Future<String> oneVideoInfo(String url) async {
    print('banh mi SG');
    url = "https://www.douyin.com/video/6915675899241450760";
    driver.get(url);
    var html = driver.pageSource;

    BeautifulSoup soup = BeautifulSoup(html);
    var list = soup.findAll("source");

    var videoRealUrl = list[2].attributes['src'];
    var temp = videoRealUrl!.split('&')[0];
    videoRealUrl = "https:$temp&ratio=1080p&line=0";

    return videoRealUrl;
  }

  Future<String> userShareLinkConvert(String shareLink) async {
    var temp = shareLink.split("com/")[1].split("/")[0];
    var shareUrl = Uri.parse("https://v.douyin.com/$temp");

    var response = await http.get(shareUrl, headers: headers);
    var userId =
        response.request!.url.toString().split("?")[0].split("user/")[1];

    return "https://www.douyin.com/user/$userId";
  }

  Future<Map> userVideoInfo(String url) async {
    driver.get(url);
    var html = driver.pageSource;

    BeautifulSoup soup = BeautifulSoup(html);
    var scripts = soup.findAll('script');
    var data = '';
    for (var script in scripts) {
      if (script.text.contains("gon.user_profile")) {
        data = script.text;
        break;
      }
    }
    data = data.split("gon.user_profile = ")[1].split(";")[0];
    var result = json.decode(data);
    return result;
  }
}
