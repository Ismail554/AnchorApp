import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:wynante/core/app_colors.dart';
import 'package:wynante/core/app_padding.dart';
import 'package:wynante/core/font_manager.dart';

class EditableTagsSection extends StatefulWidget {
  final String title;
  final List<String> initialTags;
  final String hintText;

  const EditableTagsSection({
    super.key,
    required this.title,
    required this.initialTags,
    this.hintText = "Add new...",
  });

  @override
  State<EditableTagsSection> createState() => _EditableTagsSectionState();
}

class _EditableTagsSectionState extends State<EditableTagsSection> {
  late TextfieldTagsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextfieldTagsController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.title, style: FontManager.heading3(fontSize: 16)),
            const SizedBox(width: 8),
            // The icon can be part of the design, but TextFieldTags automatically handles input
            const Icon(Icons.edit_outlined, size: 18, color: AppColors.grey),
          ],
        ),
        const SizedBox(height: 12),
        TextFieldTags(
          textfieldTagsController: _controller,
          initialTags: widget.initialTags,
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (tag) {
            if (tag == 'php') {
              return 'No, please';
            } else if (_controller.getTags!.contains(tag)) {
              return 'You already entered that';
            }
            return null;
          },
          inputFieldBuilder: (context, inputFieldValues) {
            return TextField(
              controller: inputFieldValues.textEditingController,
              focusNode: inputFieldValues.focusNode,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: (_controller.getTags?.isNotEmpty ?? false)
                    ? ''
                    : widget.hintText,
                errorText: inputFieldValues.error,
                prefixIconConstraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                prefixIcon: _controller.getTags?.isNotEmpty ?? false
                    ? SingleChildScrollView(
                        controller: _controller.getScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _controller.getTags!
                              .map((tag) {
                                return Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                    color: AppColors.primaryColor,
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 5.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Text(
                                          '#$tag',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          // print("$tag selected");
                                        },
                                      ),
                                      const SizedBox(width: 4.0),
                                      InkWell(
                                        child: const Icon(
                                          Icons.cancel,
                                          size: 14.0,
                                          color: Color.fromARGB(
                                            255,
                                            233,
                                            233,
                                            233,
                                          ),
                                        ),
                                        onTap: () {
                                          _controller.removeTag(tag as String);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              })
                              .toList()
                              .cast<Widget>(),
                        ),
                      )
                    : null,
              ),
              onChanged: inputFieldValues.onTagChanged,
              onSubmitted: inputFieldValues.onTagSubmitted,
            );
          },
        ),
      ],
    );
  }
}
