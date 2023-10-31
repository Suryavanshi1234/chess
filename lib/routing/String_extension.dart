import 'package:chess_bot/routing/routing_data.dart';
import 'package:flutter/material.dart';

extension StringExtension on String {
  RoutingData get getRoutingData{
    var uriData = Uri.parse(this);
    print("queryParameters: ${uriData.queryParameters} path: ${uriData.path}");
    return RoutingData(
      queryParameters: uriData.queryParameters,
      route: uriData.path
    );
  }
}