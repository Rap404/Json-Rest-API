// ignore_for_file: public_member_api_docs, sort_constructors_first
class Album {
  final int albumId;
  final int id;
  String title;
  String url;
  String thumbnailUrl;

  Album({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        albumId: json['albumId'],
        id: json['id'],
        title: json['title'],
        url: json['url'],
        thumbnailUrl: json['thumbnailUrl']);
  }
}
