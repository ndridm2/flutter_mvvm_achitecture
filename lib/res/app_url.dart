class AppUrl {
  static var baseUrl = 'https://reqres.in/';
  static var loginUrl = '${baseUrl}api/login';
  static var registerUrl = '${baseUrl}api/register';
  static var randomUser = '${baseUrl}api/users?page=1';
  static String randomSingle(int id) => '${baseUrl}api/users/$id';
}
