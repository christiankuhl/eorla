const Map<dynamic, List<String>> _paths = {
  null: ["attr", "activatable", "belongings"],
  "attr": ["values"],
  "activatable": [],
  "belongings": ["items"],
  "belongings>items": [],
};

class Optolith {
  Map<String, dynamic> data;

  Optolith(this.data);

  Map<dynamic, dynamic> toJson(Map<dynamic, dynamic> character) {
    for (var pathspec in _paths.entries) {
      var optr = data;
      var cptr = character;
      if (pathspec.key != null) {
        for (var field in pathspec.key.toString().split(">")) {
          if (!cptr.containsKey(field)) {
            cptr[field] = {};
          }
          optr = optr[field];
          cptr = cptr[field];
        }
      }
      for (var item in optr.entries) {
        if (pathspec.value.contains(item.key)) {
          continue;
        }
        cptr[item.key] = item.value;
      }
    }
    return character;
  }
}
