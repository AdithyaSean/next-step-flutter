# Next Step - System Architecture Overview

## System Components

```
┌─────────────────┐     ┌──────────────────────────┐
│   Flutter UI    │ ←→  │  Spring Boot Backend     │
│   (Mobile)      │     │  + Embedded ML Engine    │
└─────────────────┘     └──────────────────────────┘
         ↓                          ↓
┌─────────────────┐     ┌──────────────────────────┐
│  Local SQLite   │     │    Main Database         │
└─────────────────┘     └──────────────────────────┘
```

## Core Features

1. **Education Profile Management**
   - O/L Results (A-F grades)
   - A/L Results (A-F grades + Z-score)
   - University Progress (GPA)
   - Skills Assessment

2. **Career Guidance Engine**
   - Stream-specific recommendations
   - University course matching
   - Career pathway analysis
   - Skills gap analysis

3. **Offline-First Operation**
   - Local data storage
   - Sync when online
   - Minimal internet dependency

## Key Documents
1. [Data Model](data-model.md) - Core data structures
2. [Education Schema](education-schema.md) - Sri Lankan education system

## Implementation Stack
- Frontend: Flutter/Dart
- Backend: Java (Spring Boot)
- Database: SQLite (local), PostgreSQL (main)
- ML: DJL (Deep Java Library)
