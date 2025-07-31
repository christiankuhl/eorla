import '../widgets/widget_helpers.dart';
import 'generated/_advantages.dart';
export 'generated/_advantages.dart';

class Activatable {
  final ActivatableBase type;
  final int? tier;
  final String? selectedOption;

  Activatable(this.type, this.tier, this.selectedOption);

  @override
  String toString() {
    String result = type.name;
    if (type.id != "ADV_0" && type.id != "DISADV_0") {
      if (tier != null) {
        result += " ${roman(tier!)}";
      }
      if (selectedOption != null) {
        result += " (${selectedOption!})";
      }
    } else {
      result = selectedOption ?? "";
      if (tier != null) {
        result += " ${roman(tier!)}";
      }
    }
    return result;
  }
}
