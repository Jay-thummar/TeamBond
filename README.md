# TeamBond – AI-Powered Hackathon Team Member Finder

TeamBond is a platform designed to help developers find the **perfect teammates for hackathons**. It analyzes developers' public GitHub profiles, evaluates their skills, and recommends compatible collaborators based on hackathon requirements.

The platform combines **AI-assisted analysis**, **deterministic scoring**, and **real-time communication** to simplify the hackathon team formation process.

---

# 🚀 Features

## 🔎 GitHub Profile Analysis
TeamBond analyzes a developer’s public GitHub profile to understand:

- Programming languages
- Frameworks and technologies
- Repository activity
- Development consistency

Based on this information, the system generates a **developer skill score** and compatibility insights.

---

## 🤝 Hackathon Team Matching
Users can create hackathons and specify:

- Hackathon title
- Theme
- Required tech stack
- Team size
- Location and mode (online/offline)

The system evaluates all users and generates **AI-suggested teammates** based on compatibility scores.

---

## 📊 Compatibility Scoring System
TeamBond calculates compatibility using a **deterministic normalized scoring framework**:

- Tech Stack Match Ratio
- Experience Strength Ratio
- Domain Alignment Ratio

Final compatibility score range:

0 – 100

This ensures **transparent and reproducible recommendations**.

---

## 💬 Real-Time Personal Chat
Users can communicate directly through an integrated **real-time chat system** powered by WebSockets.

This allows potential teammates to discuss ideas before forming a team.

---

## 🤖 AI Chatbot Assistant
An integrated AI chatbot helps users:

- Understand platform features
- Get guidance on creating hackathons
- Ask questions about the platform

---

## 🗺 Hackathon Map
TeamBond includes a **location-based hackathon map** that allows users to discover hackathons happening nearby.

---

## 📩 Team Join Requests
Users can:

- Send requests to join hackathon teams
- Accept or reject requests
- Track team membership status

---

# 🏗 System Architecture

TeamBond follows a **full-stack architecture**:

Frontend (React + Vite)  
↓  
REST API  
↓  
Backend (Spring Boot)  
↓  
MongoDB Database

External integrations:

- GitHub API → Developer profile analysis  
- Gemini AI → Skill extraction and analysis  
- Cloudinary → Image storage  
- Leaflet Maps → Hackathon location display  
- WebSocket → Real-time messaging  

---

# 🛠 Tech Stack

## Frontend
- React (Vite)
- Tailwind CSS
- Framer Motion
- React Router
- Shadcn UI
- React Icons

## Backend
- Spring Boot
- Spring Security
- WebSocket (SockJS + STOMP)

## Database
- MongoDB

## AI & APIs
- GitHub API
- Google Gemini AI

## Other Tools
- Cloudinary (media storage)
- Leaflet Maps (location visualization)

---

# 📦 Project Structure

TeamBond

frontend  
│  
├── components  
├── pages  
├── services  
└── utils  

backend  
│  
├── controllers  
├── services  
├── models  
├── repositories  
└── config  

database  
└── MongoDB collections  

---

# 🧠 Compatibility Scoring Model

TeamBond computes compatibility using normalized mathematical formulas.

## Tech Stack Match

TechMatch = M / T

Where:

M = matched skills  
T = total required tech stacks  

---

## Experience Strength

Skill weights:

Advanced = 3  
Intermediate = 2  
Beginner = 1  

ExperienceStrength = SumLevel / (3 × M)

Where:

SumLevel = total weight of matched skills  
M = number of matched skills  

---

## Domain Alignment

DomainAlignment = D / K

Where:

D = overlapping theme keywords  
K = total theme keywords  

---

## Final Compatibility Score

FinalScore =  
(0.5 × TechMatch +  
0.3 × ExperienceStrength +  
0.2 × DomainAlignment) × 100

---

# ⚙️ Installation

## 1️⃣ Clone Repository

git clone https://github.com/yourusername/TeamBond.git  
cd TeamBond

---

## 2️⃣ Backend Setup

cd backend

Run backend server:

./mvnw spring-boot:run

Backend will start at:

http://localhost:8080

---

## 3️⃣ Frontend Setup

cd frontend  
npm install  
npm run dev  

Frontend will run at:

http://localhost:5173

---

# 🔑 Environment Variables

Create a `.env` file and configure:

GITHUB_CLIENT_ID=  
GITHUB_CLIENT_SECRET=  
GEMINI_API_KEY=  
MONGODB_URI=  
CLOUDINARY_URL=  

---

# 📚 Database Collections

TeamBond uses MongoDB collections such as:

- Users
- Hackathons
- HackathonRequests
- PersonalChats
- UserFrameworkStats

---

# 👥 Project Team

Developed by:

Jay Thummar (IT-139)  
Darshan Sheta (IT-128)  

Department of Information Technology  
Dharmsinh Desai University

---

# 🎯 Project Goal

TeamBond aims to simplify hackathon collaboration by:

- Automatically analyzing developer skills
- Suggesting compatible teammates
- Enabling real-time communication
- Helping developers build stronger hackathon teams

---

# 📜 License

This project is developed for educational and research purposes.
