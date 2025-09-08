# 🏥 MediBridge | Multilingual Health Record Management System

MediBridge is a secure, multilingual health data management platform that helps users upload, organize, and translate personal health records—especially across language barriers.

---

## 📚 Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Troubleshooting](#troubleshooting)
- [Screenshots](#screenshots)
- [Contact](#contact)
- [License](#license)

---

## 🚀 Getting Started

Follow these instructions to set up and run MediBridge on your local machine for development or testing purposes.

---

## 🛠 Prerequisites

Ensure the following are installed on your system:

- Ruby 3.2.1
- Rails 7.0.8
- PostgreSQL 14.9
- Bundler 2.4.6
- Node.js and Yarn (for Bootstrap & frontend assets)

---

## 📦 Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/your-username/medi-bridge.git
   cd medi-bridge
Install dependencies:

bundle install
yarn install


Set up environment variables:

Create a .env file and define any required keys (e.g., GOOGLE_TRANSLATE_API_KEY).

Create and migrate the database:

rails db:create db:migrate


(Optional) Seed sample data:

rails db:seed

▶️ Usage

Start your Rails server:

rails server


Then visit: http://localhost:3000

✨ Features

📁 Upload health documents (PDF, JPG, PNG, TXT)

🌍 Translate documents into 8+ supported languages

🔍 OCR text extraction from images

👨‍👩‍👧‍👦 Family member record management

🔐 Secure, encrypted storage

🔄 Toggle between original and translated content

🏷️ Organize records by type (prescription, vaccination, doctor note)

📥 Download original or translated records

🧠 Troubleshooting
❗ Problem: bundle install fails

Ensure correct Ruby version (ruby -v)

Update bundler: gem install bundler

Run: bundle update

❗ Problem: PostgreSQL connection errors

Ensure PostgreSQL is installed and running

Check your config/database.yml

Try: rails db:reset

❗ Problem: Assets not loading

Run: rails assets:precompile

Ensure Tailwind or Bootstrap is configured properly

❗ Problem: Flash messages misaligned

Check for mt-3 on flash containers

Use conditional margin if you're on the root path

📸 Screenshots
🏠 Home Page

📂 Upload Form

📝 Record Detail + Translation

🧪 System Design (ERD)
User
│
├── has_many :health_records
│
HealthRecord
├── belongs_to :user
├── has_many :translations
│
Translation
└── belongs_to :health_record

📬 Contact

Candide Mboungou-Kimpolo
📧 candide@uic.edu

🌐 LinkedIn

📄 License

MIT License © 2025 Candide Mboungou-Kimpolo

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files...

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED...


---

✅ Once you've pasted this into your `README.md` file, you can customize:
- `https://github.com/your-username/medi-bridge.git` → your actual repo link
- Screenshot paths if needed (`public/screenshots/home.png`)
- Add more badges or CI instructions if you plan to deploy or test in CI/CD.

Want me to generate this as a downloadable file (`README.md`) too?

