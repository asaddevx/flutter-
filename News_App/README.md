
# 📰 today_news

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Provider](https://img.shields.io/badge/Provider-FF4081?style=for-the-badge)](https://pub.dev/packages/provider)
[![HTTP](https://img.shields.io/badge/HTTP-00BFFF?style=for-the-badge)](https://pub.dev/packages/http)
[![News_API](https://img.shields.io/badge/News_API-FF6F00?style=for-the-badge)](https://newsapi.org/)
[![Hive](https://img.shields.io/badge/Hive-FF6F00?style=for-the-badge)](https://docs.hivedb.dev/)


**today_news** is a vibrant, neon-charged Flutter app that delivers real-time news with a dazzling user experience. Dive into the latest headlines across categories like Anime, Sports, Finance, and more, with a sleek carousel slider showcasing top stories. Personalize your feed with a custom nickname and favorite topics, save articles for offline reading, and enjoy a glowing UI with smooth animations. Powered by the News API, Hive, and SQFLite, **today_news** combines performance and style to keep you informed in electrifying fashion!

---

## 🎯 The Problem We Saw

News consumption is broken. Users face the same frustrations every day:

- 📱 **Too Many Apps, Too Much Noise** — You need one app for sports, another for finance, another for anime. Your phone becomes a cluttered mess.
- 🌐 **"No Internet, No News"** — You're on a train, in a tunnel, or traveling abroad. Your news app shows nothing but an error screen.

---
## Features
- **Real-Time News:** Fetch and display news articles from the News API across multiple categories.
- **Category Browsing:** Explore news via a horizontal category bar (Top News, Anime, Sports, Finance, Entertainment).
- **Search Functionality:** Search news by keywords or countries with instant results.
- **Favorites:** Save articles to a favorites list with a neon pink heart icon, stored locally for offline access.
- **Customization:** Set a nickname and preferred carousel topic (e.g., Dragon Ball) in the settings screen.
- **Neon Aesthetic:** Enjoy a glowing UI with gradient backgrounds, neon pink accents, and animated transitions.
- **Dynamic Loading Screen:** Features a glowing today_news logo, tagline, and neon spinning Lottie animation.
- **Offline Support:** Cache news with Hive and store favorites/settings in SQFLite for offline use.
- **Error Handling:** Display user-friendly error messages with retry options and Lottie animations.
- **Smooth Performance:** Optimized with pull-to-refresh, cached images, and lightweight animations.

## Functional Requirements

### 1. News Fetching and Display:
- Fetch real-time news from the News API based on categories.
- Display news in a scrollable list with image cards.
- Showcase top news in an auto-playing carousel slider.

### 2. Category Selection:
- Horizontal category bar for quick topic navigation.
- Detailed news screen for each category.

### 3. Search Functionality:
- Search bar for querying news by keywords or countries.
- Results displayed in a dedicated screen.

### 4. Favorites Management:
- Favorite articles with a neon pink heart icon.
- Store favorites in SQFLite for offline access.
- View and manage favorites in a dedicated screen.

### 5. User Customization:
- Set nickname and carousel topic in settings.
- Persist settings in SQFLite.

### 6. Neon-Themed UI/UX:
- Gradient backgrounds and neon pink accents.
- Dynamic loading screen with glowing text and animations.
- Smooth fade, scale, and slide transitions.

### 7. Offline Support:
- Cache news articles using Hive.
- Persist favorites and settings locally.

### 8. Error Handling and Feedback:
- Display errors for API failures with retry options.
- Use Lottie animations for loading and error states.

### 9. Performance and Responsiveness:
- Pull-to-refresh for news updates.
- Efficient image loading with CachedNetworkImage.
- Optimized animations for smooth performance.

### 10. Navigation and Menu:
- Popup menu for settings access.
- Floating action button for favorites.
- Seamless navigation with slide transitions.

## Dependencies
- `flutter`
- `http`
- `provider`
- `carousel_slider`
- `pull_to_refresh`
- `cached_network_image`
- `sqflite`
- `path`
- `hive`
- `flutter_dotenv`
- `lottie`

## Assets
- `images/ic_launcher.png`: App logo
- `assets/loading.json`: Neon spinning loading animation
- `assets/error.json`: Error animation
- `images/placeholder.jpg`: Fallback image for news cards

## Models
- ChatGPT
- DeepSeek
- Grok

# News App  
### 📰 App Screenshots

| Loading Screen | Home Screen | Categories/Search |
|----------------|-------------|-------------------|
| <img src="https://github.com/user-attachments/assets/a107b1ea-d3a7-46e4-bf90-6bbf449526a6" width="200"/> | <img src="https://github.com/user-attachments/assets/155108a6-d7fe-4817-ad3a-0af4437b832f" width="200"/> | <img src="https://github.com/user-attachments/assets/2255a7c2-1ecb-482d-8f5c-6f9a2c5012d1" width="200"/> |

| Favourite Screen | Settings Screen | Web Page Screen |
|------------------|------------------|------------------|
| <img src="https://github.com/user-attachments/assets/227cac3e-94df-49ad-b1af-297e7e7a8a90" width="200"/> | <img src="https://github.com/user-attachments/assets/2f333507-b961-41f1-ae9c-37800921d24b" width="200"/> | <img src="https://github.com/user-attachments/assets/abb63ae0-a68e-43cb-8ebd-f8d32e012de8" width="200"/> |




## Contributing
Feel free to submit issues or pull requests to enhance **today_news**. Let’s keep the neon vibe glowing!

## License
This project is licensed under the MIT License – see the LICENSE file for details.

## Acknowledgements
- Built with ❤️ by **Asadullah (FA22-BSE-037)**
- Powered by Flutter, News API, and Lottie animations

---

## ✨ News App Key Highlights

- **Real-Time News Reader** — Modern Flutter application that fetches and displays latest news from multiple sources
- **Category-Based Browsing** — Easy navigation through Business, Technology, Sports, Health, Entertainment, and more
- **Search Functionality** — Instant article search with smart filtering
- **Rich Article Preview** — Beautiful card-based UI with images, titles, descriptions, and source information
- **Smooth Performance** — Optimized with Provider state management and efficient API handling
- **Offline Support** — Cached images and articles for better user experience
- **Clean & Modern UI** — Following Material Design guidelines with excellent readability
- **Educational Foundation Project** — Demonstrates strong API integration, state management, and UI/UX skills in Flutter

A clean, fast, and user-friendly news application that showcases solid Flutter development fundamentals.
---
## 📊 Project Analytics
<p align="center">
  <!-- News App Project Stats -->
  <img src="https://github-readme-stats-fast.vercel.app/api/pin/?username=asaddevx&repo=flutter-&theme=tokyonight&hide_border=true&bg_color=0a192f&border_radius=20" alt="News App Project Stats" />

  <!-- Top Languages -->
  <img src="https://github-readme-stats-fast.vercel.app/api/top-langs/?username=asaddevx&repo=flutter-&layout=compact&theme=tokyonight&hide_border=true&bg_color=0a192f&border_radius=20&langs_count=8" alt="Top Languages" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Provider-FF4081?style=for-the-badge" alt="Provider" />
  <img src="https://img.shields.io/badge/HTTP-00BFFF?style=for-the-badge" alt="HTTP" />
  <img src="https://img.shields.io/badge/News_API-FF6F00?style=for-the-badge" alt="News API" />
  <img src="https://img.shields.io/badge/Cached_Network_Image-4285F4?style=for-the-badge" alt="Cached Network Image" />
  <img src="https://img.shields.io/badge/Material_Design-757575?style=for-the-badge" alt="Material Design" />
</p>


---
## 📫 Connect with the Architect

<div align="center">
  <p><strong>SYSTEMS_STATUS: FLUTTER_SYSTEMS_OPERATIONAL 🟢</strong></p>
  <p>Let's build something disruptive. 🚀</p>

  <a href="https://asad-lime-six.vercel.app/">
    <img src="https://img.shields.io/badge/VIEW_PORTFOLIO-282c34?style=for-the-badge&logo=vercel&logoColor=61AFEF" alt="Portfolio" />
  </a>
  &nbsp;
  <a href="https://www.linkedin.com/in/asadullah-%F0%9F%99%82-5475a4352">
    <img src="https://img.shields.io/badge/LINKEDIN-282c34?style=for-the-badge&logo=linkedin&logoColor=0A66C2" alt="LinkedIn" />
  </a>
  &nbsp;
  <a href="mailto:asadullah.devop@gmail.com">
    <img src="https://img.shields.io/badge/SEND_EMAIL-282c34?style=for-the-badge&logo=gmail&logoColor=E06C75" alt="Email" />
  </a>
</div>




<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=rect&color=23272e&height=30&section=footer" />
</p>


