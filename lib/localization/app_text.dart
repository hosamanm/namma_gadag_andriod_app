
import 'language_controller.dart';

class AppText{
 static String title()=>LanguageController.isKannada ? "ಗದಗ ಪ್ರವಾಸಿ ಸ್ಥಳಗಳು":"Gadag Tourist Places";
 static String login()=>LanguageController.isKannada ? "ಲಾಗಿನ್":"Login";
 static String profile()=>LanguageController.isKannada ? "ಪ್ರೊಫೈಲ್":"Profile";
 static String changeLang()=>LanguageController.isKannada ? "ಭಾಷೆ ಬದಲಾಯಿಸಿ":"Change Language";
}
