import 'package:flutter/material.dart';

class PainterAnimationController {
  static final PainterAnimationController _instance =
      PainterAnimationController._internal();
  factory PainterAnimationController() => _instance;
  PainterAnimationController._internal();

  late AnimationController animationController;

  Future<void> forward(VoidCallback action) async {
    PainterAnimationController().animationController.forward().whenComplete(() => action.call());
  }

  Future<void> reverse(VoidCallback action) async {
    PainterAnimationController().animationController.reverse().whenComplete(() => action.call());
  }

  AnimationController get controller => animationController;
}
