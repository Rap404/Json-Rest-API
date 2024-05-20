import 'package:flutter/material.dart';
import 'package:exam/models/album.dart';
import 'package:exam/services/service.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<homePage> {
  List<Album> albums = [];
  bool isLoading = true;

  void fetchAlbums() async {
    final result = await AlbumService.fetchAlbums();
    albums = result;
    setState(() {});
    isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchAlbums();
  }

  void deleteAlbum(int index) {
    setState(() {
      albums.removeAt(index);
    });
  }

  void editAlbum(
      int index, String newTitle, String newUrl, String newThumbnailUrl) {
    setState(() {
      albums[index].title = newTitle;
      albums[index].url = newUrl;
      albums[index].thumbnailUrl = newThumbnailUrl;
    });
  }

  void showEditDialog(BuildContext context, int index) {
    TextEditingController albumidController =
        TextEditingController(text: albums[index].title.toString());
    TextEditingController urlController =
        TextEditingController(text: albums[index].url);
    TextEditingController thumbnailUrlController =
        TextEditingController(text: albums[index].thumbnailUrl);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Album'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: albumidController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: urlController,
                decoration: InputDecoration(labelText: 'URL'),
              ),
              TextField(
                controller: thumbnailUrlController,
                decoration: InputDecoration(labelText: 'Thumbnail URL'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () {
                editAlbum(index, albumidController.text, urlController.text,
                    thumbnailUrlController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Exam json & rest api'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  final album = albums[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(album.thumbnailUrl),
                      ),
                      title: Text(
                        '${album.id}. ${album.title}',
                      ),
                      subtitle: Text(
                        album.url,
                        style: TextStyle(fontSize: 15),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                showEditDialog(context, index);
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                deleteAlbum(index);
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                }));
  }
}
