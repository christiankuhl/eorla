class ExplainedValue {
  final int value;
  final List<ComponentWithExplanation> explanation;

  ExplainedValue(this.value, this.explanation);

  factory ExplainedValue.base(int value, String explanation) {
    return ExplainedValue(value, [ComponentWithExplanation(value, explanation, false)]);
  }

  ExplainedValue add(int mod, String expl, bool isMod) {
    int newValue = value + mod;
    List<ComponentWithExplanation> newExplain = explanation;
    newExplain.add(ComponentWithExplanation(mod, expl, isMod));
    return ExplainedValue(newValue, newExplain);
  }

  ExplainedValue addNontrivial(int mod, String expl, bool isMod) {
    if (mod != 0) {
      return add(mod, expl, isMod);
    } else {
      return this;
    }
  }

  ExplainedValue andThen(List<ComponentWithExplanation> components) {
    int newValue = value;
    List<ComponentWithExplanation> newExplain = explanation;
    for (var comp in components) {
      newValue += comp.value;
      newExplain.add(comp);
    }
    return ExplainedValue(newValue, newExplain);
  }
}

class ComponentWithExplanation {
  final int value;
  final String explanation;
  final bool isMod;

  ComponentWithExplanation(this.value, this.explanation, this.isMod);

  @override
  String toString() {
    String sign;
    if (value > 0) {
      sign = '+';
    } else {
      sign = '';
    }
    return "$sign$value\t$explanation";
  }
}
