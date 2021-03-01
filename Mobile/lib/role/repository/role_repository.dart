
import 'package:Mobile/role/data_provider/role_data.dart';
import 'package:Mobile/role/model/models.dar.dart';
import 'package:meta/meta.dart';


class RoleRepository {
  final RoleDataProvider dataProvider;

  RoleRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Role> createMedia(Role role) async {
    return await dataProvider.createMedia(role);
  }

  Future<List<Role>> getMedias() async {
    return await dataProvider.getRoles();
  }

  Future<Role> getMediaById(String id) async {
    return await dataProvider.getRoleById(id);
  }

  Future<void> updateMedia(Role role) async {
    await dataProvider.updateRole(role);
  }

  Future<void> deleteMedia(String id) async {
    await dataProvider.deleteRole(id);
  }
}