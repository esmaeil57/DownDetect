# DownDetect - Early Down Syndrome Detection & Support App

DownDetect is a Flutter-based mobile application designed to assist in the **early detection of Down Syndrome** using AI-powered medical image analysis. It also provides parents and caregivers with **helpful resources**, such as therapy videos, expert contacts, and community support, all in one place.

## 🚀 Features

- 🧠 **AI-Powered Prediction**: Upload ultrasound images to receive predictive insights using a trained deep learning model.
- 📺 **Helpful Videos**: Watch curated YouTube videos for Down Syndrome treatment, therapy, and communication tips.
- 📍 **Therapist Directory**: Browse and contact professional therapists, including availability, location, and rating.
- 🔒 **Secure Authentication**: Sign up and log in using email credentials with secure backend integration.
- 📱 **Clean MVVM Architecture**: Structured Flutter app using Model-View-ViewModel pattern for scalability and maintainability.
- 🌐 **WebView Integration**: Videos are played using native WebView for broader compatibility and lighter dependencies.

## 🧩 Tech Stack

- **Flutter** (Frontend)
- **Dio** for API communication
- **Provider** for state management
- **webview_flutter** for embedded video playback
- **Node.js + Express + MongoDB** (Backend)
- **YouTube Data API** for fetching video content
- **Mongoose + Zod** for validation and data modeling

## 🗂️ Project Structure

lib/
├── data/
│ └── models/ # Data models (Video, Therapist, User)
├── services/ # API services (Auth, Video, Prediction)
├── view_model/ # ViewModels for each screen
├── views/ # UI Screens and Widgets
├── utils/ # Helpers and constants
├── main.dart # App entry point


## 📦 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/esmaeil57/DownDetect.git
   cd DownDetect

2. Install dependencies:
   flutter pub get

3. Run the app:
   flutter run 

🔐 API Configuration

 static const String baseUrl = 'https://downdetect-api-drckbtgdcshudmgq.uaenorth-01.azurewebsites.net/api';
 static const String predictUrl = 'https://downdetect-gbggbuaga5drcgfp.uaenorth-01.azurewebsites.net' ;

📸 Image Prediction Flow
User selects an ultrasound image.

Image is sent to the /api/predict endpoint.

The server responds with prediction results.

Results are displayed in the app.

🔧 Configuration Notes
Ensure Android uses INTERNET permission in AndroidManifest.xml:
<uses-permission android:name="android.permission.INTERNET"/>

🤝 Contributors
(Esmaeil Ahmed , Michael Zakaria , Omar Ahmed ) - Flutter Developers
(Esmaeil Ahmed , Mahmoud Yakout ) - Backend Developers

Backend powered by Node.js + MongoD

📷 Screenshots
## 📷 Screenshots

<div align = "center">
<img src="https://github.com/user-attachments/assets/2950f87f-d138-45bf-9e1f-aa3919f6cc90" width="140"/>
<img src="https://github.com/user-attachments/assets/26eb861a-31cc-4d1a-b6ef-f451f10db28b" width="140"/>
<img src="https://github.com/user-attachments/assets/82f9cb73-d83f-4a53-b64e-93c9384c55cc" width="140"/>
<img src="https://github.com/user-attachments/assets/ddf9aed0-85a7-43ff-a998-a066e26197f3" width="140"/>
<img src="https://github.com/user-attachments/assets/e1ac627c-5b7d-47c0-b882-d86c337ed70c" width="140"/>
   
<br/><br/>
<img src="https://github.com/user-attachments/assets/a4c90336-549b-4bd5-ba1f-ab5bb498361f" width="140"/>
<img src="https://github.com/user-attachments/assets/731392af-0e3b-40fa-90cb-1b33ce334e66" width="140"/>
<img src="https://github.com/user-attachments/assets/331c4503-aaaf-4a66-9062-6f2ca0f30ea8" width="140"/>
<img src="https://github.com/user-attachments/assets/f61003a5-7bf1-475a-b991-4259157419eb" width="140"/>
<img src="https://github.com/user-attachments/assets/2fa9ef8c-2c37-4064-8c73-bfc475963213" width="140"/>

<br/></br
<img src="https://github.com/user-attachments/assets/a821cefd-a68e-4fa7-9415-02ff6d115dc9" width="140"/>
<img src="https://github.com/user-attachments/assets/fd17f286-7c9f-4ef2-85a7-33228a429f92" width="140"/>
<img src="https://github.com/user-attachments/assets/bdeb733c-4f65-4cb0-95a3-5be74983177b" width="140"/>
<img src="https://github.com/user-attachments/assets/e2de5ede-ed26-4cc7-a149-d723bf605b16" width="140"/>
<img src="https://github.com/user-attachments/assets/2a7ccf61-3efd-4c86-bb67-38c3bfe5d12c" width="140"/>

</div>
