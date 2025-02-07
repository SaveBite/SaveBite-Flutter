import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/utils/app_styles.dart';

class FileUploadContainer extends StatefulWidget {
  final String? imagePath;
  final Function(String?) onPickImage;
  final VoidCallback onClearImage;

  const FileUploadContainer({
    Key? key,
    required this.imagePath,
    required this.onPickImage,
    required this.onClearImage,
  }) : super(key: key);

  @override
  _FileUploadContainerState createState() => _FileUploadContainerState();
}

class _FileUploadContainerState extends State<FileUploadContainer> {
  late String? _selectedFile;
  late bool _hasError;
  final ImagePicker _picker = ImagePicker();
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _selectedFile = widget.imagePath;
    _hasError = false;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange); // Listen to focus changes
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus; // Update focus state
    });
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = pickedFile.path;
        _hasError = false;
      });
      widget.onPickImage(pickedFile.path);
    }
  }

  void _clearImage() {
    setState(() {
      _selectedFile = null;
      _hasError = true;
    });
    widget.onClearImage();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        return _selectedFile == null ? 'Please upload a file' : null;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Focus(
              focusNode: _focusNode,
              child: GestureDetector(
                onTap: () {
                  _focusNode.requestFocus(); // Request focus when tapped
                  _pickImage(); // Open the image picker
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: state.hasError
                          ? Colors.red // Error border
                          : _isFocused
                              ? Color(0xff5EDA42) // Green border when focused
                              : Color(0xffCCCCCC), // Default border
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: _selectedFile != null
                      ? Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => _showImageDialog(context),
                                child: Text(
                                  _selectedFile!,
                                  style: AppStyles.styleMedium16,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            IconButton(
                              iconSize: 25,
                              onPressed: _clearImage,
                              icon: Icon(Icons.close, color: Color(0xff666666)),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _focusNode.requestFocus(); // Request focus
                                _pickImage(); // Open the image picker
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(100, 45),
                                backgroundColor: Colors.grey[300],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 13),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                      width: 1, color: Color(0xff666666)),
                                ),
                              ),
                              child: Text(
                                "Choose File",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Noto Scans',
                                  color: Color(0xff666666),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _selectedFile ?? "No File Chosen",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Noto Scans',
                                  color: Color(0xffcccccc),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 8),
                child: Text(
                  'Please upload a file',
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showImageDialog(BuildContext context) {
    if (_selectedFile == null) return;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Image.file(File(_selectedFile!), fit: BoxFit.cover),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close, color: Colors.white, size: 30),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
