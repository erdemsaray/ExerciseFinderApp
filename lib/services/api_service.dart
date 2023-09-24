import 'package:exercise_finder_app/models/exercise.dart';
import 'package:exercise_finder_app/utils/connection.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Exercise>> fetchExercises(String? name, String? type, String? muscle) async {
    String connectionValue = Connection.api;
    if (name != '' || name != null) {
      connectionValue = "$connectionValue?name=$name";
    }
    if (type != "Select") {
      connectionValue = "$connectionValue&type=$type";
    }
    if (muscle != "Select") {
      connectionValue = "$connectionValue&muscle=$muscle";
    }

    Uri uri = Uri.parse(connectionValue);

    final response = await http.get(uri, headers: Connection.headers);

    if (response.statusCode == 200) {

      return exerciseFromJson(response.body);
    } else {
      return [];
    }
  }
}
