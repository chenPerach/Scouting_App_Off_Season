import 'package:equatable/equatable.dart';

abstract class Model {
  Map<String, dynamic> toJson();
}

abstract class EquatableModel extends Equatable implements Model {}
