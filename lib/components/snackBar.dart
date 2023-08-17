import 'package:flutter/material.dart';

void showSnackBar(context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
