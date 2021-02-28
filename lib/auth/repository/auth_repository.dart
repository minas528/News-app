

import 'package:Mobile/auth/data_provider/auth_data.dart';
import 'package:Mobile/users/model/User.dart';
import 'package:meta/meta.dart';

enum AuthenticationStatus { unKnown, authenticated, unauthenticated }

class AuthRepository {
 final AuthDataProvider authDataProvider;
 AuthRepository({@required this.authDataProvider});

 Future<User> logIn({
   @required String username,
   @required String password,
 }) async {
   return await authDataProvider.signInWithUsernameAndPassword(
       username, password);
 }

 Future<bool> register({
   @required User user
 }) async {
   return await authDataProvider.signUpWithUsernameAndPassword(user);
 }

 Future<User> getCurrentUser() async {
   return await authDataProvider.getCurrentUser();
 }

 void logOut() {
   authDataProvider.signOut();
 }
}