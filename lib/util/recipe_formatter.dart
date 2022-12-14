// import 'package:intl/intl.dart';
class RecipeFormat {
  static String reformatPage(String recipe) {
    String result = recipe.replaceAll("</li> <li>", "\n");
    return result;
  }

  static String reformatDetail(String recipe) {
    // String result = recipe.replaceAll("</li> <li>", "\n");
    final splitted = recipe.split('</li> <li>');
    String result = "";
    for (int i = 0; i < splitted.length; i++) {
      result += "${i+1}. ";
      result += splitted[i];
      result += "\n";
    }
    return result;
  }
}
