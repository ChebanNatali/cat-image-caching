import 'dart:io';
import 'package:catimage/features/domain/entities/cat_entity.dart';
import 'package:flutter/material.dart';

class FullscreenPage extends StatelessWidget {
  final CatEntity cat;

  const FullscreenPage({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(
            File(cat.localPath!),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
