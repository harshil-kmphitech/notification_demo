import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class AppText extends Text {
  const AppText(
    super.data, {
    super.key,
    required super.style,
    super.maxLines,
  });
}

class CenterText extends Text {
  const CenterText(
    super.data, {
    super.key,
    required super.style,
    super.textAlign = TextAlign.center,
    super.maxLines,
  });
}

class AppRichText extends RichText {
  AppRichText({
    super.key,
    super.textAlign = TextAlign.center,
    TextStyle? style,
    super.maxLines,
    required List<AppSpan> spans,
  })  : assert(spans.isNotEmpty, 'spans cannot be empty'),
        super(
          text: TextSpan(
            text: spans[0].text,
            style: style ?? spans[0].style,
            recognizer: spans[0].recognizer,
            children: spans.length > 1
                ? spans.sublist(1).map(
                    (e) {
                      if (e.style != null) return e;
                      return e;
                    },
                  ).toList()
                : null,
          ),
        );
}

class AppSpan extends TextSpan {
  const AppSpan({
    super.text,
    super.style,
    super.recognizer,
  });

  AppSpan copyWith({
    String? text,
    TextStyle? style,
    GestureRecognizer? recognizer,
  }) {
    return AppSpan(
      text: text ?? this.text,
      style: style ?? this.style,
      recognizer: recognizer ?? this.recognizer,
    );
  }
}
