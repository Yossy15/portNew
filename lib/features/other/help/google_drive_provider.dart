import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

const _folderId = '1fwNHZkkTZ-5uzjRuhwvjoqBtjqloZFZC';
const _apiKey = 'YOUR_GOOGLE_API_KEY'; // ใส่ API Key ของคุณ

final googleDriveImagesProvider = FutureProvider<List<String>>((ref) async {
  final url = Uri.parse(
    'https://www.googleapis.com/drive/v3/files'
    '?q=%271fwNHZkkTZ-5uzjRuhwvjoqBtjqloZFZC%27+in+parents'
    '+and+mimeType+contains+%27image/%27'
    '+and+trashed=false'
    '&fields=files(id,name)'
    '&key=$_apiKey',
  );

  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception('Failed to load images: ${response.body}');
  }

  final data = jsonDecode(response.body) as Map<String, dynamic>;
  final files = data['files'] as List<dynamic>;

  return files
      .map((f) => 'https://drive.google.com/uc?export=view&id=${f['id']}')
      .toList();
});