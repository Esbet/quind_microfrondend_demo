// javascript_utils.dart
import '../../../core/theme/colors.dart';

 String loginjsScript = '''
document.querySelector('[data-testid="minimal-nav-head"]').style.display = 'none';
document.querySelector('.warp-dwg-locale-selector-plank').style.display = 'none';
document.querySelector('.dwg-flex-grid').style.display = 'none';
document.querySelector('._form-header_6mkyf_19._left-align_6mkyf_65').style.display = 'none';

var buttons = document.getElementsByClassName('email-submit-button');
if (buttons.length > 0) {
  buttons[0].style.backgroundColor = '${firstColor.toCssString()}';
  buttons[0].style.borderColor = '${firstColor.toCssString()}';
  buttons[0].addEventListener('click', function () {
    // Add your click event code here
  });
}

var buttons = document.getElementsByClassName('_login-button_1fel4_21');
if (buttons.length > 0) {
  buttons[0].style.backgroundColor = '${firstColor.toCssString()}';
  buttons[0].style.borderColor = '${firstColor.toCssString()}';
  buttons[0].addEventListener('click', function () {
    // Add your click event code here
  });
}
''';
