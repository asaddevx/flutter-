# 📚 Student Task Tracker App

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Riverpod](https://img.shields.io/badge/Riverpod-FF4081?style=for-the-badge)](https://riverpod.dev/)


**Student Task Tracker** is a real-time, dual-role Flutter application powered by Supabase. It enables teachers (admins) to manage students, assign tasks, and monitor performance — while students get a focused dashboard to track and complete their work, all synchronized live.

---
## 🎯 The Problem We Saw

Classroom task management is broken. Teachers and students suffer daily from the same old problems:

- 📋 **"Where's the Assignment?"** — Students claim they didn't see the task. Teachers claim they posted it. No single source of truth.
- 📊 **Invisible Progress** — Teachers have no real-time view of who completed what. By the time they find out, it's too late to intervene.
- 🐘 **Spreadsheet Chaos** — Teachers manage tasks and scores in Excel files that live on their desktop. Emailing files back and forth is error-prone and outdated.
- 🔐 **Login Nightmare** — Every platform requires students to sign up separately. Teachers have no control over who joins.
- 💬 **No Communication Channel** — Students have questions. Teachers have answers. But there's no built-in way to connect them.
- 📈 **No Motivation System** — Students complete tasks in isolation. No leaderboard. No streaks. No recognition for hard work.

> *The result?* Missed assignments, frustrated teachers, disengaged students, and zero visibility into classroom progress.

---
## 💡 The Solution We Built

**Student Task Tracker** is a **real-time classroom operating system** — no backend code required. Supabase handles everything.

| Problem | Our Solution |
|:--------|:-------------|
| **"Where's the Assignment?"** | **Supabase Realtime** — Tasks appear instantly on student devices the moment the admin assigns them. No refresh needed. |
| **Invisible Progress** | **Live Performance Dashboard** — Teachers see real-time completion rates. Students see personal progress graphs with `fl_chart`. |
| **Spreadsheet Chaos** | **Excel Import/Export** — Admins can upload students in bulk from Excel and export task data as CSV/PDF anytime. |
| **Login Nightmare** | **Supabase Auth + Admin Creation** — Admin creates student credentials. Students just log in. No separate sign-up. |
| **No Communication Channel** | **In-App Real-time Chat** — Students message admins directly. Questions get answered instantly. |
| **No Motivation System** | **Leaderboard + Streaks** — Top performers are visible. Task streaks encourage daily engagement. |

### 🧠 What Makes This Task Tracker Different?

- **Zero Backend Code** — No Express, no Node.js, no server deployment. Supabase is the entire backend (Auth, Database, Realtime, RLS).
- **Row Level Security (RLS)** — Students see only their own tasks. Admins see everything. The database enforces this, not the app.

---

# 📄 **Scope Document – Student Task Tracker App (Real-time with Supabase)**

---

## ✅ **Project Title**

**Student Task Tracker App**
(*Real-time with Supabase & Flutter*)

---

## 🎯 **Core Use Case**

* **Admin (Teacher)** creates students, assigns tasks, and monitors their progress.
* **Students** view and complete their tasks, and track performance using real-time graphs.

---

## 👥 **Roles**

### 🧑‍🏫 **Admin (Teacher)**

* Add students (manually or from Excel)
* Assign tasks to specific students
* Track student performance via reports/graphs
* Delete students and their tasks
* View top performers
* Additional: Chat with students

### 🎓 **Student**

* Login with credentials provided by Admin
* View assigned tasks
* Mark tasks as completed
* View personal progress graph
* Additional: See task streaks or leaderboard

---

## 📱 **App Structure**

* **2 Flutter Apps (or roles within same app)**

  * `Admin App`
  * `Student App`

---

## 🔐 **Authentication**

* Use **Supabase Auth**:

  * password login
  * Admin creates credentials for students
  * Supabase manages secure auth tokens

---

## 🗃️ **Cloud Database: Supabase**

* PostgreSQL (via Supabase)
* Real-time subscriptions (enabled for `tasks`, `reports`, `messages`)
* Hosted in **Mumbai region (ap-south-1)** for Pakistan

### ✳️ **Tables in Supabase**

| Table Name    | Purpose                                           |
| ------------- | ------------------------------------------------- |
| `users`       | Admins & Students (with role field)               |
| `tasks`       | Task data with assignment and completion          |
| `reports`     | (additional) Track progress/performance             |
| `messages`    | (additional) Real-time chat between admin & student |
| `leaderboard` | (additional) Track top student performance          |

---

## 🧠 **Functional Requirements**

### Admin App:

* [ ] Add students (form or Excel upload)
* [ ] Assign tasks
* [ ] View student task reports
* [ ] Export data
* [ ] View performance graphs
* [ ] View top performers
* [ ] Chat with students (Additional)

### Student App:

* [ ] Login
* [ ] View assigned tasks
* [ ] Mark tasks as completed
* [ ] View progress graph
* [ ] See leaderboard (additional)
* [ ] Chat with teacher (additional)

---

## 📦 **Technology Stack**

| Component     | Tool                                           |
| ------------- | ---------------------------------------------- |
| Frontend      | Flutter (Android Studio)                       |
| Database      | Supabase (PostgreSQL + Real-Time + Auth)       |
| Charts        | `fl_chart`                                     |
| File Upload   | `file_picker`, `excel` (Admin only)            |
| State Mgmt    | `Provider` or `Riverpod`                       |
| Real-time     | `supabase_flutter` stream API                  |
| PDF/Export    | `pdf`, `printing`, `csv` (for admin reports)   |


---

---

## 📈 Additional Features (Phase 2)

* ✅ Push notifications (via Supabase Edge Functions + OneSignal)
* ✅ In-app messaging
* ✅ Weekly/monthly reports
* ✅ Email auto-sending credentials to students
* ✅ Dark/light theme toggle

---

# 🧠 Task_admin App  
### 📱 App Screenshots

Efficiently manage students, tasks, and performance insights — all in one place!

---

### 🔐 Authentication & Dashboard (Admin)

| Loading Screen | Admin Login | Admin Dashboard | Chat List | Student Chat |
|----------------|-------------|------------------|-----------|---------------|
| <img src="https://github.com/user-attachments/assets/62fb9a72-16f2-4900-8daa-7efcaa21e0dd" width="200"/> | <img src="https://github.com/user-attachments/assets/929815e7-1654-4c53-9f96-c37e50af4c08" width="200"/> | <img src="https://github.com/user-attachments/assets/059ffca5-88c0-4ca1-8190-b78eaa17db0a" width="200"/> | <img src="https://github.com/user-attachments/assets/6e95acae-09c9-464a-9f87-6070fc41b4a6" width="200"/> | <img src="https://github.com/user-attachments/assets/233c983b-dc1d-4c29-962b-2be889643daf" width="200"/> |

---

### 👥 User & Task Management (Admin)

| Student Management | Task Management | Assign Task | View All Tasks | Settings Screen |
|---------------------|------------------|-------------|----------------|------------------|
| <img src="https://github.com/user-attachments/assets/898007eb-8f99-4173-98c2-f12aff053103" width="200"/> | <img src="https://github.com/user-attachments/assets/8d90edfe-1f10-4e81-acc1-383a4f3bbdf8" width="200"/> | <img src="https://github.com/user-attachments/assets/d84091db-c99c-4508-a851-fe782482306a" width="200"/> | <img src="https://github.com/user-attachments/assets/4f659482-8d10-414f-a734-9fb57fdaba49" width="200"/> | <img src="https://github.com/user-attachments/assets/2155ec37-8107-43e4-9b36-5d2b4c666964" width="200"/> |

---

### 📊 Reports & Settings (Admin)

| Performance Report | Leaderboard | Export Completed Task | Privacy Screen | - |
|--------------------|-------------|------------------------|----------------|---|
| <img src="https://github.com/user-attachments/assets/9a3592bb-74cc-4adc-9520-e7b623641755" width="200"/> | <img src="https://github.com/user-attachments/assets/8c6f9712-2ca7-4c51-973d-c738853318dc" width="200"/> | <img src="https://github.com/user-attachments/assets/695f759b-e607-4368-a1e7-1b1996544286" width="200"/> | <img src="https://github.com/user-attachments/assets/ea71fdb9-11f4-4260-ae47-ae158dff4fee" width="200"/> | - |

---

## 👨‍🎓 Task_Student App  
### 📱 App Screenshots

A focused dashboard for students to manage tasks, view progress, and stay on track.

---

### 🔐 Authentication & Dashboard (Student)

| Loading Screen | Student Login | Home Page | Dashboard | Progress Chart |
|----------------|---------------|-----------|-----------|----------------|
| <img src="https://github.com/user-attachments/assets/7575de7a-356f-4883-bcb7-90defc0a1123" width="200"/> | <img src="https://github.com/user-attachments/assets/68a00605-f447-445e-96ae-866704493fd3" width="200"/> | <img src="https://github.com/user-attachments/assets/bd4fe4e6-69a9-4eb5-9556-57b98c4d29af" width="200"/> | <img src="https://github.com/user-attachments/assets/bd946831-a54f-4ead-92b4-79e5131fa3bd" width="200"/> | <img src="https://github.com/user-attachments/assets/20cd235a-7caf-40a7-9a7d-b09fb28c5579" width="200"/> |

---

### 📊 Tools & Preferences (Student)

| Calendar | Chat with Admin | Settings Screen | Privacy Policy | - |
|----------|------------------|------------------|------------------|---|
| <img src="https://github.com/user-attachments/assets/36eb3f53-15a1-43ac-a6cf-a6462437d664" width="200"/> | <img src="https://github.com/user-attachments/assets/41ece79f-2f96-427a-bd24-d211704b31db" width="200"/> | <img src="https://github.com/user-attachments/assets/a7e920e5-d949-4950-b660-c1afc0d88ab7" width="200"/> | <img src="https://github.com/user-attachments/assets/e1f9ef82-6099-4080-a144-ce40535281f4" width="200"/> | - |

---

## ✨ Task Tracker (Supabase) Key Highlights

- **Real-Time Task Management Application** — Advanced Flutter app with live synchronization using Supabase
- **Supabase Backend Integration** — Full utilization of Supabase Auth, PostgreSQL, and Realtime Database
- **Row Level Security (RLS)** — Secure data access control at the database level
- **Live Task Updates** — Real-time synchronization across multiple devices
- **Advanced State Management** — Clean architecture using Riverpod for scalable and maintainable code
- **Modern UI/UX** — Beautiful, responsive interface with smooth animations
- **Authentication & Authorization** — Secure user login and personalized task management
- **Production-Ready Patterns** — Demonstrates enterprise-level Flutter + Supabase integration

A powerful real-time task tracking solution that showcases modern Flutter development with Supabase backend and strong security practices.
---
## 📊 Project Analytics

<p align="center">
  <!-- Task Tracker Supabase Project Stats -->
  <img src="https://github-readme-stats-fast.vercel.app/api/pin/?username=asaddevx&repo=flutter-&theme=tokyonight&hide_border=true&bg_color=0a192f&border_radius=20" alt="Task Tracker Supabase Project Stats" />

  <!-- Top Languages -->
  <img src="https://github-readme-stats-fast.vercel.app/api/top-langs/?username=asaddevx&repo=flutter-&layout=compact&theme=tokyonight&hide_border=true&bg_color=0a192f&border_radius=20&langs_count=8" alt="Top Languages" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Riverpod-FF4081?style=for-the-badge" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase" />
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
  <img src="https://img.shields.io/badge/Row_Level_Security-00BFFF?style=for-the-badge" alt="RLS" />
  <img src="https://img.shields.io/badge/Realtime-FF6F00?style=for-the-badge" alt="Realtime" />
</p>

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












