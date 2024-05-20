import 'dart:convert';

import 'package:exam/models/album.dart';
import 'package:http/http.dart' as http;

class AlbumService {
  static const String baseUrl =
      'https://jsonplaceholder.typicode.com/albums/1/photos';
  static Future<List<Album>> fetchAlbums() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl'));

      if (response.statusCode == 200) {
        final List<dynamic> result = jsonDecode(response.body);

        List<Album> albums =
            result.map((albumjson) => Album.fromJson(albumjson)).toList();
        return albums;
      } else {
        throw Exception('failed to load albums');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

// import 'dart:convert';

// import 'package:exam/models/album.dart';
// import 'package:http/http.dart' as http;

// class AlbumService {
//   static const String baseUrl =
//       'https://jsonplaceholder.typicode.com/albums/1/photos';
//   static Future<List<Album>> fetchAlbum() async{
//     try{
//       final response = await http.get(Uri.parse('$baseUrl'));
//       final body = response.body;
//       final result = jsonDecode(body);
//       List<Album> albums = List<Album>.from{
//         result['data'].map(
//           (album) => Album.fromJson(album),
//         );  
//       };
//       return albums;
//     } catch (e) {
//       throw Exception(e.toString());
//     }
//   }
//   static fetchAlbums() {}
// }
