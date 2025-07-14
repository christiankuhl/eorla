class ExplainedValue {
  final int value;
  final List<ComponentWithExplanation> explanation;

  ExplainedValue(this.value, this.explanation);

  factory ExplainedValue.empty() {
    return ExplainedValue(0, []);
  }

  factory ExplainedValue.base(int value, String explanation) {
    return ExplainedValue(value, [
      ComponentWithExplanation(value, explanation, false),
    ]);
  }

  ExplainedValue addUnconditional(int mod, String expl, bool isMod) {
    int newValue = value + mod;
    List<ComponentWithExplanation> newExplain = explanation;
    newExplain.add(ComponentWithExplanation(mod, expl, isMod));
    return ExplainedValue(newValue, newExplain);
  }

  ExplainedValue add(int mod, String expl, bool isMod) {
    if (mod != 0) {
      return addUnconditional(mod, expl, isMod);
    } else {
      return this;
    }
  }

  ExplainedValue mul(double mod, String expl) {
    if (mod != 1) {
      int newValue = (value * mod).round();
      List<ComponentWithExplanation> newExplain = explanation;
      newExplain.add(
        ComponentWithExplanation(mod, expl, false, op: Operator.mul),
      );
      return ExplainedValue(newValue, newExplain);
    } else {
      return this;
    }
  }

  ExplainedValue andThen(List<ComponentWithExplanation> components) {
    int newValue = value;
    List<ComponentWithExplanation> newExplain = explanation;
    for (var comp in components) {
      if (comp.op != Operator.add) {
        throw UnimplementedError("Multiplicative entries not supported in ExplainedValue.andThen()");
      }
      newValue += comp.value.round();
      newExplain.add(comp);
    }
    return ExplainedValue(newValue, newExplain);
  }
}

enum Operator { add, mul }

class ComponentWithExplanation {
  final num value;
  final String explanation;
  final bool isMod;
  final Operator op;

  ComponentWithExplanation(
    this.value,
    this.explanation,
    this.isMod, {
    this.op = Operator.add,
  });

  @override
  String toString() {
    String signOrOp;
    if (op == Operator.mul) {
      signOrOp = "*";
    } else {
      if (value > 0) {
        signOrOp = '+';
      } else {
        signOrOp = '';
      }
    }
    return "$signOrOp$value\t$explanation";
  }
}

class DiceValue {
  final int value;
  final int? confirmationThrow;

  const DiceValue(this.value, {this.confirmationThrow});

  DiceValue operator +(Object other) {
    final int otherVal = _unwrap(other);
    return DiceValue(value + otherVal, confirmationThrow: null);
  }

  DiceValue operator -(Object other) {
    final int otherVal = _unwrap(other);
    return DiceValue(value - otherVal, confirmationThrow: null);
  }

  DiceValue operator *(Object other) {
    final int otherVal = _unwrap(other);
    return DiceValue(value * otherVal, confirmationThrow: null);
  }

  @override
  bool operator ==(Object other) => other is DiceValue && other.value == value;

  @override
  int get hashCode => value.hashCode;

  int toInt() => value;

  @override
  String toString() => confirmationThrow != null
      ? '$value ($confirmationThrow)'
      : value.toString();

  int _unwrap(Object other) {
    if (other is int) return other;
    if (other is DiceValue) return other.value;
    throw ArgumentError('Unsupported operand: $other');
  }
}
