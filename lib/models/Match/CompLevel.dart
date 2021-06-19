import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class CompLevel extends Equatable {
  final String simple;
  final String detailed;
  CompLevel({this.simple, this.detailed});

  factory CompLevel.simple(String compLevel) {
    String detailed;
    switch (compLevel) {
      case "qm":
        detailed = "Qualification Match";
        break;
      case "qf":
        detailed = "Quarter Finals";
        break;
      case "sf":
        detailed = "Semi Finals";
        break;
      case "f":
        detailed = "Finals";
        break;
      default:
    }
    return CompLevel(simple: compLevel, detailed: detailed);
  }
  @override
  List<Object> get props => [this.simple, this.detailed];
}
