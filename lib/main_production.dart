import 'package:synapsis_survei/core/constants/config_env.dart';
// ignore: library_prefixes
import './main.dart' as M;

void main() {
  ConfigEnvironments.setEnvironment(Environment.PRODUCTION);
  M.main(['--release']);
}
