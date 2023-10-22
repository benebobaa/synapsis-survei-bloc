// ignore: constant_identifier_names
enum Environment { DEV, PRODUCTION }

class ConfigEnvironments {
  static String currentEnvironment = Environment.DEV.name;

  static setEnvironment(Environment value) => currentEnvironment = value.name;

  static List<Map<String, String>> availableEnvironments = [
    {
      'env': Environment.DEV.name,
      'url': 'https://panel-demo.obsight.com',
    },
    {
      'env': Environment.PRODUCTION.name,
      'url': 'https://synapsis.com',
    },
  ];

  static String? getBaseUrlAPI() {
    return availableEnvironments.firstWhere(
      (d) => d['env'] == currentEnvironment,
    )['url'];
  }
}
