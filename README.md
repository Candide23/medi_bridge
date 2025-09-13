
# 🏥 MediBridge | Multilingual Health Record Management System

**MediBridge** is a secure, multilingual health data management platform that helps users upload, organize, and translate personal health records—especially across language barriers.

---

## 📚 Table of Contents

- [Getting Started](#getting-started)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Troubleshooting](#troubleshooting)
- [Screenshots](#screenshots)
- [System Design (ERD)](#system-design-erd)
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
   ```

2. **Install dependencies:**

   ```bash
   bundle install
   yarn install
   ```

3. **Set up environment variables:**

   Create a `.env` file and define any required keys:

   ```
   GOOGLE_TRANSLATE_API_KEY=your_key_here
   ```

4. **Create and migrate the database:**

   ```bash
   rails db:create db:migrate
   ```

5. *(Optional)* **Seed sample data:**

   ```bash
   rails db:seed
   ```

---

## ▶️ Usage

Start the Rails server:

```bash
rails server
```

Then visit: [http://localhost:3000](http://localhost:3000)

---

## ✨ Features
```
- 📁 Upload health documents (PDF, JPG, PNG, TXT)
- 🌍 Translate documents into 8+ supported languages
- 🔍 OCR text extraction from scanned images
- 👨‍👩‍👧‍👦 Family member record management
- 🔐 Secure, encrypted storage
- 🔄 Toggle between original and translated content
- 🏷️ Organize records by type (prescription, vaccination, doctor note)
- 📥 Download original or translated records
```
---

## 🧠 Troubleshooting

### ❗ Problem: `bundle install` fails

- Check Ruby version: `ruby -v`
- Update Bundler: `gem install bundler`
- Try: `bundle update`

### ❗ Problem: PostgreSQL connection errors

- Ensure PostgreSQL is installed and running
- Check your `config/database.yml`
- Try: `rails db:reset`

### ❗ Problem: Assets not loading

- Run: `rails assets:precompile`
- Ensure Bootstrap and asset pipeline are correctly configured

### ❗ Problem: Flash messages are misaligned

- Check for `mt-3` or `mt-0` spacing on flash containers
- Adjust margin spacing conditionally based on the page (e.g. homepage)

---

## 📸 Screenshots
📸 Screenshots
![alt text](<Screenshot 2025-09-10 at 3.58.07 PM.png>)
![alt text](<Screenshot 2025-09-10 at 3.59.54 PM.png>)
![alt text](<Screenshot 2025-09-10 at 4.01.50 PM.png>)

---

## 🧪 System Design (ERD)

```text
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
```

---

## 📬 Contact

Candide Mboungou-Kimpolo
📧 mboungoukimpolo@gmail.com

🌐 LinkedIn: https://www.linkedin.com/in/candide-mboungou-kimpolo/

## 📄 License

MIT License © 2025 Candide Mboungou-Kimpolo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

**THE SOFTWARE IS PROVIDED "AS IS"**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 

