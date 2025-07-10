import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../../core/network/auth_local_data_source.dart';

class TrackingAddEditPage extends StatefulWidget {
  const TrackingAddEditPage({super.key});

  @override
  State<TrackingAddEditPage> createState() => _TrackingAddEditPageState();
}

class _TrackingAddEditPageState extends State<TrackingAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberIdController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _labelController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  File? _selectedImage;
  bool _isSubmitting = false;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      await _extractDatesFromImage(_selectedImage!);
    }
  }

  Future<void> _extractDatesFromImage(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse('https://savebite-edr.hossamohsen.me/api/capture'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"image_data": "data:image/jpeg;base64,$base64Image"}),
    );

    debugPrint('Capture API: ${response.statusCode}');
    debugPrint(response.body);
  }

  Future<void> _testUploadApi() async {
    if (_selectedImage == null) return;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://savebite-edr.hossamohsen.me/api/upload'),
    );

    request.files.add(await http.MultipartFile.fromPath('file', _selectedImage!.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('Upload API: ${response.statusCode}');
    debugPrint(response.body);
  }

  Future<void> _testProcessApi() async {
    if (_selectedImage == null) return;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://savebite-edr.hossamohsen.me/api/process'),
    );

    request.files.add(await http.MultipartFile.fromPath('file', _selectedImage!.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    debugPrint('Process API: ${response.statusCode}');
    debugPrint(response.body);
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedImage == null) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      final user = await AuthLocalDataSource.getUser();
      final token = user?.token;

      if (token == null) throw Exception('❌ No authentication token available.');


      final uri = Uri.parse('https://save-bite.ghonim.makkah.solutions/api/v1/mobile/tracking-products');
      final request = http.MultipartRequest('POST', uri);

      request.fields['name'] = _nameController.text;
      request.fields['numberId'] = _numberIdController.text;
      request.fields['category'] = _categoryController.text;
      request.fields['label'] = _labelController.text;
      request.fields['start_date'] = _startDateController.text;
      request.fields['end_date'] = _expiryDateController.text;
      request.fields['quantity'] = _quantityController.text;

      request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));
      request.headers['Authorization'] = 'Bearer $token';

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Product added successfully')),
        );
        debugPrint('Success: $data');
      } else {
        throw Exception('❌ Failed to add product: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add/Edit Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _numberIdController,
                decoration: const InputDecoration(labelText: 'Number ID'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _labelController,
                decoration: const InputDecoration(labelText: 'Label'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _startDateController,
                decoration: const InputDecoration(labelText: 'Start Date'),
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(labelText: 'Expiration Date'),
                validator: (value) => value!.isEmpty ? 'Expiration date required' : null,
              ),
              const SizedBox(height: 16),
              _selectedImage != null
                  ? Image.file(_selectedImage!, height: 150)
                  : const Text('No image selected'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _selectedImage == null ? null : _testUploadApi,
                child: const Text('Test Upload API'),
              ),
              ElevatedButton(
                onPressed: _selectedImage == null ? null : _testProcessApi,
                child: const Text('Test Process API'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
