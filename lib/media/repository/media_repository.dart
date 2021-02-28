import 'package:Mobile/media/data_provider/media_data.dart';
import 'package:Mobile/media/model/Media.dart';
import 'package:meta/meta.dart';


class MediaRepository {
  final MediaDataProvider dataProvider;

  MediaRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Media> createMedia(Media media) async {
    return await dataProvider.createMedia(media);
  }

  Future<List<Media>> getMedias() async {
    return await dataProvider.getMedias();
  }

  Future<Media> getMediaById(String id) async {
    return await dataProvider.getMediaById(id);
  }

  Future<void> updateMedia(Media media) async {
    await dataProvider.updateMedia(media);
  }

  Future<void> deleteMedia(String id) async {
    await dataProvider.deleteMedia(id);
  }
}