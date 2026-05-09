

### 📄 **Scope Document for BS CGPA Calculator App**

---

#### **1. Project Overview**

The **BS CGPA Calculator App** is an academic productivity tool designed specifically for Bachelor's (BS) students to track, calculate, and strategize their GPA/CGPA goals. It provides interactive modules for semester-wise GPA calculations, CGPA forecasting, and academic planning, including history tracking and goal-setting features. The app also includes visual tools such as a carousel of university campuses to enhance user engagement and personalization.

---

## 🎯 The Problem We Saw

Most students navigate their academic journey in the dark, reacting to grades instead of planning for them. The result is preventable stress, missed opportunities, and financial waste. Here is the reality students face:

- **❓ The "What-If" Fog:** Students know their current grade, but have no idea what score they need on the final exam to achieve their target. The uncertainty is paralyzing.
- **🧮 Spreadsheet Math Errors:** Students resort to mental math or error-prone spreadsheets to try and forecast their CGPA. A single miscalculated credit hour can lead to a disastrous wrong conclusion.
- **🎯 The Invisible Target:** A student with a 2.8 CGPA aiming for a Dean's List 3.5 doesn't know the required future semester GPA. Without this foresight, the goal remains a distant, often unreachable dream.


---
#### **2. Objectives**

* To provide a user-friendly and intuitive CGPA calculation system.
* To enable students to set academic goals and understand GPA requirements for achieving those goals.
* To maintain and export academic records (CSV/PDF).
* To visually represent all university campuses for a more personalized and engaging experience.

---

#### **3. Target Audience**

* BS-level students across various academic institutions.
* Academic advisors and counselors.
* Prospective university applicants exploring campuses.

---

#### **4. Key Features**

* 🎯 **Individual Semester GPA Calculator**
  Calculate semester GPA with credit-weighted grading inputs, supporting both GPA (0.0–4.0) and mark-based systems (COMSATS toggle).

* 📊 **Target CGPA Calculator**
  Input current CGPA and desired target to see what GPA is required in future semesters.

* 🧮 **Current & Final CGPA Calculator**
  Choose Target Semester , Enter past semester CGPA and Target semester GPA to  calculate your Final CGPA for Target Semester.

* 📁 **Calculation History**
  Auto-saving and exporting of GPA calculations and CGPA scenarios.

* 🖼️ **Campus Carousel**
  Web-based carousel of all supported university campuses with visual previews.

* 🌗 **Dark Mode Support**
  Dynamic theming for accessibility and user preference.

---

#### **5. Functional Requirements**

##### 5.1 GPA Calculation Module

* Allow users to input subject names, credit hours, and marks/GPA.
* Toggle between GPA and Mark input (COMSATS policy).
* Display semester GPA result with motivational feedback.

##### 5.2 Target CGPA Module

* Accept current CGPA and target CGPA.
* Compute required GPA for the upcoming semester based on user input.
* Suggest possible GPA distributions per subject.

##### 5.3 CGPA Comparison Module

* Input GPA of previous semesters (1–8).
* Compute current CGPA.
* Calculate GPA required to meet a target CGPA.

##### 5.4 History Module

* Auto-save results (toggle via settings).
* View past semester-wise results.
* Export data as CSV or PDF.

##### 5.5 Carousel Slider (Web)

* Display all supported university campuses in an interactive image carousel.
* Each slide includes campus name, image, and a short description.
* Responsive design for all screen sizes.

##### 5.6 UI/UX Features

* Adaptive color scheme for dark/light modes.
* Custom iconography and color-coded visual elements for clarity.
* Motivational messages based on GPA results.

---

#### **6. Non-Functional Requirements**

* **Performance:** Must calculate GPA/CGPA within 1 second for standard inputs.
* **Scalability:** Support data for up to 8 semesters and 8 subjects per semester.
* **Usability:** Clean interface with a user-friendly layout, intuitive navigation, and feedback-driven design.
* **Compatibility:** Android (Flutter), Web-compatible for carousel feature.
* **Data Persistence:** Local storage with `SharedPreferences`.
* **Security:** User data is stored locally without any external transmission.

---

#### **7. Assumptions & Constraints**

* Users are assumed to understand basic GPA and credit systems.
* Mark-to-GPA conversion (COMSATS policy) is followed correctly.
* Internet is not required except for carousel images hosted online (if applicable).
* App supports only GPA scale up to 4.0.

---

# Smart CGPA App  
### 📱 App Screenshots

| Loading Screen | Home Screen | Dark Mode Home | Individual CGPA | Target CGPA |
|----------------|-------------|----------------|------------------|-------------|
| <img src="https://github.com/user-attachments/assets/6d78c683-72c9-4d02-aa98-6f110796492c" width="200"/> | <img src="https://github.com/user-attachments/assets/c2a04ac7-ab72-47c7-8899-44d82cb82474" width="200"/> | <img src="https://github.com/user-attachments/assets/6f990307-4c8f-40b9-8db8-2f94aab7510c" width="200"/> | <img src="https://github.com/user-attachments/assets/46f7bfe6-e227-495e-9cea-4bb33fd2399a" width="200"/> | <img src="https://github.com/user-attachments/assets/ace70b82-d0a7-4756-b87e-01d899fa798f" width="200"/> |

| Current & Target CGPA | Secure History | History Screen | History Pages | Menu Screen |
|------------------------|----------------|----------------|----------------|-------------|
| <img src="https://github.com/user-attachments/assets/0e95ed29-031c-40c6-b4c7-8ebc42ac32ab" width="200"/> | <img src="https://github.com/user-attachments/assets/101d2a8f-f3b5-440f-b7a0-38de1f40d228" width="200"/> | <img src="https://github.com/user-attachments/assets/42747192-0966-498a-882b-2543f7166943" width="200"/> | <img src="https://github.com/user-attachments/assets/e43aaafe-c796-4ad6-8189-49cf73ba7e1e" width="200"/> | <img src="https://github.com/user-attachments/assets/aa2df431-dfc6-4cd2-a4f1-a3827cd94936" width="200"/> |

| About Screen | Contact Screen | Settings Screen | Policy Screen | Web Page |
|--------------|----------------|------------------|----------------|----------|
| <img src="https://github.com/user-attachments/assets/6959c2e6-5a3e-46df-8fa6-747d91a5e9fd" width="200"/> | <img src="https://github.com/user-attachments/assets/e8e27361-3019-4f7c-a0fd-e7d06bbd89f2" width="200"/> | <img src="https://github.com/user-attachments/assets/f87b323a-43a8-4121-b214-8774937cdb21" width="200"/> | <img src="https://github.com/user-attachments/assets/c9cec757-0d52-42fa-a035-3743bf14af12" width="200"/> | <img src="https://github.com/user-attachments/assets/983c44d3-54d9-42c9-87c8-8bbec2d76445" width="200"/> |
----

## ✨ BS CGPA Calculator Key Highlights

- **University-Specific CGPA Calculator** — Designed specifically for BS programs with accurate GPA and CGPA calculations
- **Smart Credit Hour System** — Automatically calculates semester GPA and cumulative CGPA based on course credits and grades
- **Real-Time Preview** — Live grade and CGPA updates as students input their marks
- **Clean & Student-Friendly UI** — Intuitive, modern, and easy-to-use interface built with Flutter
- **Lightweight & Performant** — Fast, responsive, and optimized for mobile devices
- **Educational Tool** — Helps students track academic performance and plan future semesters effectively
- **Solid Foundation Project** — Demonstrates clean Flutter architecture, state management, and mathematical accuracy

A practical and useful academic tool that showcases strong Flutter fundamentals and user-centric design.
----
## 📊 Project Analytics
<p align="center">
  <!-- BS CGPA Calculator Project Stats -->
  <img src="https://github-readme-stats-fast.vercel.app/api/pin/?username=asaddevx&repo=flutter-&theme=tokyonight&hide_border=true&bg_color=0a192f&border_radius=20" alt="BS CGPA Calculator Project Stats" />

  <!-- Top Languages -->
  <img src="https://github-readme-stats-fast.vercel.app/api/top-langs/?username=asaddevx&repo=flutter-&layout=compact&theme=tokyonight&hide_border=true&bg_color=0a192f&border_radius=20&langs_count=8" alt="Top Languages" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Riverpod-FF4081?style=for-the-badge" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Provider-FF4081?style=for-the-badge" alt="Provider" />
  <img src="https://img.shields.io/badge/Material_Design-757575?style=for-the-badge" alt="Material Design" />
</p>


----
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

---
