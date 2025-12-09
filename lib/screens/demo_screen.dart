import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/audio_service.dart';
import '../services/voice_narration.dart';
import '../services/language_provider.dart';

class DemoScreen extends StatelessWidget {

  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // 🌍 Language provider
    final lang = context.watch<LanguageProvider>();

    //--------------------------------------------------------------
    // Localized text sample
    //--------------------------------------------------------------
    final text = lang.isKannada
        ? "ತ್ರಿಕೂಟೇಶ್ವರ ದೇವಸ್ಥಾನವು ಗದಗ ಜಿಲ್ಲೆಯ ಪ್ರಸಿದ್ಧ ಐತಿಹಾಸಿಕ ತಾಣವಾಗಿದೆ."
        : "Trikuteshwara Temple is a famous heritage site of Gadag district.";

    //--------------------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: Text("🌼 Gadag Tourist Guide"),
        actions: [

          //------------------------------------------------------
          // 🌐 LANGUAGE SWITCH TOGGLE
          //------------------------------------------------------
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: lang.toggleLanguage,
            tooltip: lang.currentLanguage,
          ),
        ],
      ),

      body: Container(

        //----------------------------------------------------------
        // 🎨 Background Gradient
        //----------------------------------------------------------
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.teal,
              Colors.lightBlue,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            //------------------------------------------------------
            // 🖼️ IMAGE CARD
            //------------------------------------------------------
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  "assets/images/trikuteshwara.jpg",
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            //------------------------------------------------------
            // 📝 RICH TEXT DESCRIPTION
            //------------------------------------------------------
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),

                children: [

                  //--------------------------------------------------
                  TextSpan(
                    text: lang.isKannada
                        ? "📜 ಇತಿಹಾಸ ಮಾಹಿತಿ\n\n"
                        : "📜 Description\n\n",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  //--------------------------------------------------
                  TextSpan(text: text),
                ],
              ),
            ),

            const SizedBox(height: 30),

            //------------------------------------------------------
            // 🎙️ TTS BUTTON
            //------------------------------------------------------
            ElevatedButton.icon(
              icon: const Icon(Icons.record_voice_over),
              label: Text(
                lang.isKannada
                    ? "ಧ್ವನಿ ವಿವರಣೆ"
                    : "Voice Narration",
              ),
              onPressed: () {
                AudioService().speak(
                  text,
                  lang.isKannada,
                );
              },
            ),

            const SizedBox(height: 15),

            //------------------------------------------------------
            // 🎵 ASSET AUDIO BUTTON
            //------------------------------------------------------
            ElevatedButton.icon(
              icon: const Icon(Icons.music_note),
              label: Text(
                lang.isKannada
                    ? "ಸ್ವಾಗತ ಸಂಗೀತ"
                    : "Play Welcome Music",
              ),
              onPressed: () {
                VoiceNarration()
                    .play("audio/welcome.mp3");
              },
            ),
          ],
        ),
      ),
    );
  }
}
