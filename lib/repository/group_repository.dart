import '../models/icon_model.dart';

class GroupRepository {

  Map<int, String> getGroupMap() {
    return {1: "Група 1", 2: "Група 2", 3: "Група 1"};
  }

  // List<IconModel> refreshIcon(String iconName, List iconsList) {
  //   print('refresh as $iconName');
  //
  //   List<IconModel> icons = [];
  //
  //   iconsList.forEach((element) {
  //     if (element == iconName) {
  //       icons.add(IconModel(iconName: element, selected: true));
  //     } else {
  //       icons.add(IconModel(iconName: element, selected: false));
  //     }
  //   });
  //
  //   return icons;
  // }

}