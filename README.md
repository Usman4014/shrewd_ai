# SHREWD AI

### Buy Smart. Buy Confident.

**AI-Powered Insights for Smarter Second-Hand Purchases.**

SHREWD AI is an AI-powered buying assistant designed to help users make more informed decisions when purchasing second-hand and pre-owned products.

The application analyzes user-provided product details and images to generate structured insights about visible condition, potential red flags, missing information, inspection points, seller questions, and purchase considerations.

---

## Features

- **AI Product Analysis** — Analyze second-hand products using product information and uploaded images.
- **Visual Condition Assessment** — Identify visible physical conditions and potential damage.
- **Positive Aspects** — Highlight favorable observations supported by the provided images.
- **Red Flag Detection** — Identify potential concerns that buyers should investigate.
- **Missing Information** — Highlight details that should be verified before purchasing.
- **Seller Questions** — Generate practical questions to ask the seller.
- **Inspection Checklist** — Get useful physical inspection recommendations.
- **Price Considerations** — Review purchase-price considerations without unsupported market valuations.
- **Product Comparison** — Compare products to support better buying decisions.
- **Analysis History** — Access previously saved analyses stored locally.
- **Product Categories** — Explore different product categories and subcategories.
- **Image Upload** — Provide up to five product images for an analysis.
- **No Account Required** — Use the application without login or signup.

## Technology Stack

| Technology | Purpose |
|---|---|
| Flutter | Android application development |
| Dart | Application programming language |
| GetX | State management, dependency injection and navigation |
| Hive | Local data storage |
| Cloudflare Workers | Backend infrastructure |
| TypeScript | Backend development |
| Google Gemini API | AI-powered product analysis |
| REST API | Communication between app and backend |
| Manrope | Application typography |

## Architecture Overview

SHREWD AI uses a Flutter frontend with a separate Cloudflare Workers backend.

```text
SHREWD AI Android App
        |
        v
   Flutter + GetX
        |
        v
   REST API Service
        |
        v
Cloudflare Workers Backend
        |
        v
     Gemini API
        |
        v
 Structured Analysis Response
        |
        v
    Flutter App
```

**Security design:** The Gemini API key is stored as a backend environment secret. It is not intended to be embedded in the Flutter application.

## Project Structure

```text
shrewd_ai/
│
├── android/
│
├── assets/
│   ├── fonts/
│   ├── icons/
│   └── images/
│
├── backend/
│   ├── src/
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── middleware/
│   │   ├── routes/
│   │   ├── services/
│   │   ├── types/
│   │   ├── utils/
│   │   └── validators/
│   │
│   ├── .dev.vars.example
│   ├── package.json
│   └── wrangler.jsonc
│
├── lib/
│   ├── app/
│   ├── core/
│   ├── data/
│   ├── modules/
│   ├── shared/
│   └── main.dart
│
├── test/
│
├── pubspec.yaml
└── README.md
```

## Getting Started

### Prerequisites

Install the following tools before setting up the project:

- Flutter SDK
- Dart SDK
- Android Studio or Android SDK
- Node.js and npm
- Cloudflare account
- Google Gemini API key

### 1. Clone the Repository

```bash
git clone https://github.com/usman4014/shrewd_ai.git

cd shrewd_ai
```

Replace `YOUR_USERNAME` with the GitHub account that hosts the repository.

### 2. Set Up the Flutter Application

Install Flutter dependencies:

```bash
flutter pub get
```

Open:

```text
lib/core/constants/api_constants.dart
```

Verify that `baseUrl` points to your own deployed Cloudflare Workers backend.

Run the application:

```bash
flutter run
```

### 3. Set Up the Backend

Navigate to the backend directory:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

### 4. Configure Local Environment Variables

Create a local `.dev.vars` file inside the `backend/` directory.

Use the following structure:

```env
GEMINI_API_KEY=YOUR_GEMINI_API_KEY
GEMINI_MODEL=YOUR_GEMINI_MODEL
ALLOWED_ORIGIN=*
```

Replace the placeholders with your own configuration values.

**Important:** Never commit `.dev.vars` or share your actual API key publicly. This file is excluded through `.gitignore`.

### 5. Run the Backend Locally

```bash
npm run dev
```

The Cloudflare Workers development server will start locally.

### 6. Deploy the Backend

Authenticate Wrangler with Cloudflare:

```bash
npx wrangler login
```

Configure the Gemini API key as a Cloudflare secret:

```bash
npx wrangler secret put GEMINI_API_KEY
```

Configure `GEMINI_MODEL` and `ALLOWED_ORIGIN` as appropriate Worker environment variables.

Deploy:

```bash
npm run deploy
```

After deployment, update the Flutter application's backend `baseUrl` to your deployed Worker URL.

### 7. Backend Type Checking

Run:

```bash
npm run type-check
```

## Privacy Policy

SHREWD AI Privacy Policy:

https://usman4014.github.io/shrewd-ai-privacy-policy/

Please review the Privacy Policy before using the application.

## Important Disclaimer

SHREWD AI provides AI-generated decision-support insights based on the information and images supplied by users.

- AI-generated observations may be incomplete or inaccurate.
- Images cannot establish hidden internal defects or guarantee functionality.
- Product authenticity and quality cannot be guaranteed.
- Buyers should physically inspect and independently verify products before purchasing.

SHREWD AI should be used as a decision-support tool, not as a replacement for independent inspection.

## Support

For questions, technical support, or feedback:

**Email:** support.usmantechlabs@gmail.com

## License

No open-source license has been assigned to this repository yet. Unless a license is added, the source code remains subject to the copyright owner's default rights. Please contact the repository owner before redistributing or using the code beyond applicable legal permissions.

---

**SHREWD AI — Buy Smart. Buy Confident.**
