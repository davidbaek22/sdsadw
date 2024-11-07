import 'dart:math';

class Character {
  String name;
  int health;
  int attackPower;
  int defense;

  Character(this.name, this.health, this.attackPower, this.defense);

  // 공격 메서드
  void attackMonster(Monster monster) {
    int damage = max(0, attackPower - monster.defense);
    monster.health = max(0, monster.health - damage);
    print('$name이(가) ${monster.name}에게 $damage의 피해를 입혔습니다.');
  }

  // 방어 메서드
  void defend(int damage) {
    health += damage;
    print('$name이(가) 방어하여 체력이 $damage만큼 회복되었습니다.');
  }

  // 상태 출력 메서드
  void showStatus() {
    print('캐릭터 상태 - 이름: $name, 체력: $health, 공격력: $attackPower, 방어력: $defense');
  }
}

class Monster {
  String name;
  int health;
  int maxAttackPower;
  int defense = 0;
  int attackPower;

  Monster(this.name, this.health, this.maxAttackPower, int characterDefense)
      : attackPower =
            max(characterDefense, Random().nextInt(maxAttackPower) + 1);

  // 공격 메서드
  void attackCharacter(Character character) {
    int damage = max(0, attackPower - character.defense);
    character.health = max(0, character.health - damage);
    print('$name이(가) ${character.name}에게 $damage의 피해를 입혔습니다.');
  }

  // 상태 출력 메서드
  void showStatus() {
    print('몬스터 상태 - 이름: $name, 체력: $health, 공격력: $attackPower');
  }
}

// 캐릭터 데이터 로드 함수 (웹 환경에서는 하드코딩)
Character loadCharacterStats(String name) {
  try {
    // 예시 하드코딩 데이터
    int health = 50;
    int attackPower = 10;
    int defense = 5;
    return Character(name, health, attackPower, defense);
  } catch (e) {
    print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
    return Character("기본 캐릭터", 50, 10, 5); // 기본 캐릭터 데이터 반환
  }
}

// 몬스터 데이터 로드 함수 (웹 환경에서는 하드코딩)
List<Monster> loadMonsterStats(int characterDefense) {
  List<Monster> monsters = [
    Monster("Batman", 30, 20, characterDefense),
    Monster("Spiderman", 20, 30, characterDefense),
    Monster("Superman", 30, 10, characterDefense)
  ];
  return monsters;
}

// 게임 결과 저장 함수 (웹에서는 콘솔 출력으로 대체)
void saveGameResult(Character character, bool victory) {
  print("게임 결과를 저장합니다:");
  String result = victory ? '승리' : '패배';
  print(
      '캐릭터 이름: ${character.name}, 남은 체력: ${character.health}, 게임 결과: $result');
}

void main() {
  // 웹 환경에서 캐릭터 이름 입력받기
  String name = "영웅"; // 기본 이름 (필요시 HTML에서 입력값을 받을 수 있습니다.)

  // 캐릭터와 몬스터 데이터 로드
  Character hero = loadCharacterStats(name);
  List<Monster> monsters = loadMonsterStats(hero.defense);

  // 예시로 첫 번째 몬스터와 전투 진행
  Monster monster = monsters[0];

  hero.showStatus();
  monster.showStatus();

  hero.attackMonster(monster);
  monster.showStatus();

  monster.attackCharacter(hero);
  hero.showStatus();

  // 방어 시 캐릭터의 체력을 회복
  hero.defend(5); // 예시로 5 데미지만큼 체력 회복
  hero.showStatus();

  // 게임 결과 저장
  bool victory = monster.health <= 0; // 첫 번째 몬스터를 처치했는지 여부로 결정
  saveGameResult(hero, victory);
}
