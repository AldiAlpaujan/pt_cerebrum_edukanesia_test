// user
import 'package:aldi_test/model/user.dart';
import 'package:get/get.dart';

final _user = Rx<User?>(null);

User? get user => _user.value;
set user(User? value) => _user.value = value;
