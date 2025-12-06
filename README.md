# 🌱 SproutFlux — MVP

This repository contains the **Minimum Viable Product (MVP)** of SproutFlux — an iOS app built for **The Six Farms** to digitize farm waste logging. The MVP demonstrates a complete local workflow: users can log waste, optionally attach images, view dashboards, and navigate through the core screens.

Full backend and AI integration will be added in the next phase using **Azure Functions, Cosmos DB, Blob Storage, and AI Vision**.

---

## 🚀 App Purpose
SproutFlux aims to:

- Replace paper-based waste recording  
- Allow users to log waste with photo, type, and notes  
- Classify waste through **Azure AI Vision**  
- Store data in **Azure Cosmos DB**  
- Provide dashboards and trends  
- Deliver insights and notifications  
- Support staff vs. manager roles  

The MVP implements the **core local experience**, preparing the app for cloud integration.

---

## ✔️ MVP Features Implemented

### **Authentication**
- Sign in with email/password  
- Guest login  
- Session persistence via `UserDefaults`  

### **Add Waste Entry**
- Add a waste item with:
  - Category/type  
  - Notes  
  - Optional image via **ImagePicker**  
- Stored locally using `WasteManager`  
- Uses `@Published` state for real-time updates  

### **Dashboard Summary**
- Auto-updating summary of waste counts by type  
- Powered by observing `WasteManager`  

### **Navigation & Architecture**
- SwiftUI tab navigation  
- MVVM-ready project structure  
- UIKit → SwiftUI bridging (ImagePicker)  
- Clean and user-friendly UI  

---

## ❗ Not Yet Implemented (Azure Stage)
- Cloud database (Cosmos DB)  
- Image storage (Blob Storage)  
- AI Vision waste classification  
- Weekly insights (Azure OpenAI)  
- Manager dashboards  
- Push notifications  
- Role-based access (Azure AD B2C)  
- Forecasting + advanced analytics  

---

## 🖥️ Screens in MVP

### **Login Screen**
Authentication + guest mode

### **Log Waste Screen**
- Add entries  
- Choose category  
- Add notes  
- Attach photo  
- See list of logged items  

### **Dashboard**
Summaries of waste by type, updating automatically

---

## 🛠 Tech Stack
- Swift  
- SwiftUI + UIKit integration  
- `ObservableObject`, `@StateObject`, `@EnvironmentObject`  
- UserDefaults  
- ImagePicker wrapper  
- iOS 17+  

---

## 📁 Folder Structure
SproutFlux-MVP
 ├── AuthManager.swift
 ├── ContentView.swift
 ├── LoginView.swift
 ├── LogWasteView.swift
 ├── DashboardView.swift
 ├── WasteManager.swift
 ├── Models/
 │    ├── User.swift
 │    └── WasteItem.swift
 ├── Helpers/
 │    └── ImagePicker.swift
 └── assets/   ← add screenshots here

Demo Video:
[https://www.youtube.com/watch?v=KcrWUYWFl7M]
