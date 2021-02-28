
import 'package:Mobile/users/data_provider/data_provider.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:meta/meta.dart';


class UsesrRepository {
  final UserDataProvider dataProvider;

  UsesrRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<User> createUser(User user) async {
    return await dataProvider.createMedia(user);
  }

  Future<List<User>> getUsers() async {
    return await dataProvider.getMedias();
  }

  Future<User> getUserById(String id) async {
    return await dataProvider.getMediaById(id);
  }

  Future<void> updateUser(User user) async {
    await dataProvider.updateMedia(user);
  }

  Future<void> deleteUser(String id) async {
    await dataProvider.deleteMedia(id);
  }
}