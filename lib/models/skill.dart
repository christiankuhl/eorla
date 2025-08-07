import 'attributes.dart';
import 'rules.dart';
import 'generated/_skill.dart';
export 'generated/_skill.dart';

class SkillWrapper implements Trial {
  final Skill skill;

  SkillWrapper(this.skill);

  @override
  Attribute get attr1 => skill.attr1;
  @override
  Attribute get attr2 => skill.attr2;
  @override
  Attribute get attr3 => skill.attr3;
  @override
  String get name => skill.name;
}
