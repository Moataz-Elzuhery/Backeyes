# BackEyes – AI-Based Smart Surveillance System

An intelligent real-time surveillance system that leverages Computer Vision and Machine Learning to enhance home security by detecting and identifying individuals.

---

## 🚀 Overview

BackEyes is a smart surveillance solution designed to monitor environments and detect abnormal events such as unknown individuals entering a secured area. The system integrates AI-based face detection and recognition with a mobile application to provide real-time alerts and monitoring.

---

## 🧠 AI & Computer Vision

- Implemented face detection using Haar Cascade (OpenCV)
- Built a custom K-Nearest Neighbors (KNN) classifier from scratch for face recognition
- Developed a real-time video processing pipeline for detecting and classifying faces
- Applied image preprocessing techniques (resizing, normalization, feature extraction)
- Implemented threshold-based distance filtering to reduce false positives

---

## ⚙️ System Architecture

- **Frontend:** Flutter Mobile Application  
- **Backend:** Python (API for communication)  
- **AI Module:** OpenCV + NumPy + Custom ML Model  
- **Data:** Collected custom face dataset using live camera streams  

---

## 🔥 Key Features

- Real-time face detection and recognition  
- Identification of known vs unknown individuals  
- Automatic alert system for suspicious activity  
- Integration with mobile app for notifications  
- Multi-camera support  

---

## 📊 Workflow

1. Capture video stream from camera  
2. Detect faces using OpenCV  
3. Extract and preprocess face region  
4. Classify face using custom KNN model  
5. Send alert if unknown person is detected  

---

## 🛠️ Tech Stack

- Python  
- OpenCV  
- NumPy  
- Machine Learning (KNN from scratch)  
- Flutter  

---

## 🎯 My Contribution

- Developed the full AI pipeline (data collection → preprocessing → model → inference)
- Implemented face recognition algorithm from scratch using KNN
- Built real-time detection and classification system
- Integrated AI module with mobile application backend

---

## 🚀 Future Improvements

- Replace KNN with Deep Learning models (FaceNet / CNN)
- Improve accuracy using face embeddings
- Deploy system on cloud for scalability

---

## 📌 Conclusion

BackEyes demonstrates a complete AI-powered system combining Computer Vision, Machine Learning, and Mobile Development to solve real-world security problems.
