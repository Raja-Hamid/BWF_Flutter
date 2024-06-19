import 'dart:async';

abstract class Animal {
  String name;
  int age;

  Animal(this.name, this.age);

  void makeSound();
}

class Dog extends Animal {
  Dog(String name, int age) : super(name, age);

  @override
  void makeSound() {
    print('$name says: Woof!');
  }
}

class AgeException implements Exception {
  String errMsg() => 'Age must be positive';
}

class Person {
  String name;
  int age;

  Person(this.name, this.age) {
    if (age <= 0) {
      throw AgeException();
    }
  }

  void printInfo() {
    print('Name: $name, Age: $age');
  }
}


Stream<int> numberStream(int max) async* {
  for (int i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 100));
    yield i;
  }
}

List<int> modifyList(List<int> list, int Function(int) modify) {
  List<int> result = [];
  for (var item in list) {
    result.add(modify(item));
  }
  return result;
}

void main() async {

  List<String> names = ['Ali', 'Bobby', 'Arsalan'];
  

  if (names.contains('Ali')) {
    print('Ali is in the list.');
  }


  for (String name in names) {
    print(name);
  }

  Map<String, int> ages = {'Ali': 30, 'Bobby': 25, 'Arsalan': 35};

  ages.forEach((key, value) {
    print('$key is $value years old.');
  });

  try {
    Person p = Person('Arsalan', -5);
    p.printInfo();
  } catch (e) {
    print(e);
  }


  Dog dog = Dog('Buddy', 4);
  dog.makeSound();


  await printNumbers();


  await for (int num in numberStream(5)) {
    print('Stream number: $num');
  }


  List<int> numbers = [1, 2, 3, 4, 5];
  List<int> squaredNumbers = modifyList(numbers, (n) => n * n);
  print('Squared Numbers: $squaredNumbers');
}

Future<void> printNumbers() async {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    print('Number: $i');
  }
}