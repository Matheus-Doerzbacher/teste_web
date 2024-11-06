import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:teste_web/core/config.dart';

import 'package:teste_web/modules/auth/data/datasources/usuario_datasource.dart';

class GetImageBackgroundDatasourceImp implements GetImageBackgroundDatasource {
  @override
  Future<String> call() async {
    const photoPerPage = 15;
    final randomPage = Random().nextInt(5);

    final url = Uri.parse(
      'https://api.pexels.com/v1/search?query=nature&size=small&per_page=$photoPerPage&page=$randomPage',
    );

    const token = Config.tokenApiImage;

    try {
      final response = await http.get(url, headers: {'Authorization': token});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final photos = data['photos'];
        final randomPhoto = photos[Random().nextInt(photoPerPage)];
        final url = randomPhoto['src']['original'];
        return url;
      }
    } catch (error) {
      throw Exception('Erro ao buscar imagem de background');
    }
    return '';
  }
}
