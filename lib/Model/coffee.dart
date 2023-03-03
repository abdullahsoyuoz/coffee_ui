import 'package:flutter/material.dart';

class Coffee {
  Coffee({
    required this.name,
    this.path = "assets/img/coffee.png",
  });

  late String name;
  late String path;
}

List<Coffee> coffee = [
  Coffee(name: 'Macchiato', path: 'assets/img/macchiato.png'),
  Coffee(name: 'Frappé', path: 'assets/img/frappe.png'),
  Coffee(name: 'Mocha', path: 'assets/img/mocha.png'),
];

ValueNotifier<Coffee> currentCoffee = ValueNotifier<Coffee>(coffee.first);
