import 'package:synapsis_survei/data/models/login_success_model.dart';
import 'package:synapsis_survei/domain/entities/login_success_entity.dart';

const testLoginSuccessModel = LoginSuccessModel(
  code: 200,
  status: true,
  message: 'success',
  data: DataLoginModel(occupationLevel: 3, occupationName: 'Relawan'),
);

const testLoginSuccessEntity = LoginSuccessEntity(
  code: 200,
  status: true,
  message: 'success',
  data: DataLoginEntity(occupationLevel: 3, occupationName: 'Relawan'),
);

const testEmail = 'budimanobsight@gmail.com';
const testPassword = 'password';
