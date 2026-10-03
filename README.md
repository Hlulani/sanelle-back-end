# Sanelle API

The backend for Sanelle, a meal planner app. It is a Spring Boot REST API for managing meals, generating personalised meal plans and running challenges, with JWT-based authentication.

## Features

- **Auth** — email/password registration and login, JWT access + refresh tokens, logout/revoke, `me` endpoint
- **Meals** — create (with optional image upload), fetch by id, list, and search/filter by name, type, or minimum fiber score
- **Meal plans** — generate a day-by-day plan (7/14/30 days) based on fasting style and optional focus on anti-inflammatory or iron-rich meals
- **Challenges** — join/leave built-in challenges with participant counts, and create private custom challenges that others join by invite code
- **API docs** — Swagger UI via springdoc-openapi
- **Persistence** — PostgreSQL with Flyway-managed schema migrations

## Tech stack

- Java 17, Spring Boot 3.4.1
- Spring Web, Spring Security, Spring Data JPA
- PostgreSQL + Flyway
- JJWT (`io.jsonwebtoken`) for token generation/validation
- springdoc-openapi (Swagger UI)
- Maven

## Project structure

```
src/main/java/com/hlulani/sanelle/
├── api/dto/            # Request/response records
├── config/             # Security, CORS, JWT, static resources, OpenAPI config
├── controller/         # REST controllers (auth, meals, meal-plans, challenges)
├── domain/entity/      # JPA entities (Meal, User, RefreshToken, challenges)
├── domain/valueobject/ # Embeddable value objects (Ingredient)
├── exception/          # Global exception handling
├── mapper/             # Entity <-> DTO mapping
├── repository/         # Spring Data repositories + JPA Specifications
├── security/           # JWT service/filter, authenticated user principal
└── service/            # Business logic interfaces + implementations

src/main/resources/
├── db/migration/       # Flyway SQL migrations
└── application*.yml/properties  # Profile-specific configuration
```

## Getting started

### Prerequisites

- JDK 17+
- Maven (or use the bundled `./mvnw`)
- PostgreSQL 16 (or Docker)

### Run with Docker Compose

Spins up Postgres, pgAdmin, and the app:

```bash
docker compose up --build
```

- App: http://localhost:8080
- pgAdmin: http://localhost:5050 (admin@local.dev / admin)
- Postgres: localhost:5432 (sanelle / sanelle)

### Run locally

1. Start a Postgres instance matching `application.properties` (db `sanelle`, user/password `sanelle`), or run just the `db` service from Docker Compose:
   ```bash
   docker compose up db
   ```
2. Build and run:
   ```bash
   ./mvnw spring-boot:run
   ```

Flyway will apply all migrations in `src/main/resources/db/migration` automatically on startup.

### API documentation

Once running, browse to:

- Swagger UI: http://localhost:8080/swagger-ui.html
- OpenAPI JSON: http://localhost:8080/v3/api-docs

### Trying it out in Swagger UI

Most endpoints require a JWT, so you need to authenticate before calling them from Swagger:

1. Open http://localhost:8080/swagger-ui.html.
2. Register a user via `POST /api/v1/auth/register`, or expand **auth-controller** → `POST /api/v1/auth/login`, click **Try it out**, and submit a valid email/password.
3. Copy the `accessToken` from the response body.
4. Click the **Authorize** button (top right, padlock icon), enter `Bearer <accessToken>` in the value field, and click **Authorize**.
5. All lock icons on protected endpoints (`meal-controller`, `meal-plan-controller`) will now send that token automatically — try `GET /api/v1/meals` or `POST /api/v1/meal-plans/generate`.

Access tokens are short-lived (`app.jwt.access-minutes=60` by default) — if calls start failing with 401, just log in again and re-authorize.

### Running with the frontend

The frontend lives in the [Sanelle-front-end](https://github.com/Hlulani/Sanelle-front-end) repo and talks to this API at `http://localhost:8080/api/v1`. To run both together:

1. Start this backend (Docker Compose or `./mvnw spring-boot:run`) so it's listening on port 8080.
2. Start the frontend dev server (see its README).
3. Register or log in from the app UI. It calls `/api/v1/auth/register` and `/api/v1/auth/login`, stores the returned tokens and attaches them as a `Bearer` header on later requests.

CORS allows `http://localhost:4200` (Angular), `http://localhost:8100` (Ionic serve), and the Capacitor WebView origins by default. If you run the frontend somewhere else, set `CORS_ALLOWED_ORIGINS`.

## Configuration

Settings are read from environment variables, with local-dev defaults in `application.properties`. See `.env.example`.

| Env var | Property | Description |
|---|---|---|
| `DB_URL`, `DB_USERNAME`, `DB_PASSWORD` | `spring.datasource.*` | PostgreSQL connection details |
| `JWT_SECRET` | `app.jwt.secret` | HMAC signing key for JWTs (32+ chars). **Must be set for any non-local deployment** |
| `JWT_REFRESH_COOKIE_SECURE` | `app.jwt.refresh-cookie-secure` | Set to `true` when serving over HTTPS |
| `CORS_ALLOWED_ORIGINS` | `app.cors.allowed-origins` | Comma-separated list of allowed client origins |

Other properties: `app.jwt.access-minutes` and `app.jwt.refresh-days` (token lifetimes), `app.jwt.refresh-cookie-name` and `app.jwt.refresh-cookie-samesite`.

`application-docker.properties` is used via `SPRING_PROFILES_ACTIVE=docker` in Docker Compose. Put personal overrides in `application-local.*`, which is gitignored.

Uploaded meal images are stored on disk under `./uploads` and served at `/uploads/**`.

## API overview

All endpoints are prefixed with `/api/v1`.

### Auth (`/api/v1/auth`) — public

| Method | Path | Description |
|---|---|---|
| POST | `/register` | Create a user, returns access + refresh tokens |
| POST | `/login` | Authenticate, returns access + refresh tokens |
| POST | `/refresh` | Exchange a valid refresh token for a new token pair |
| POST | `/logout` | Revoke a refresh token |
| GET | `/me` | Get the current authenticated user |

### Meals (`/api/v1/meals`) — requires `Authorization: Bearer <access token>`

| Method | Path | Description |
|---|---|---|
| POST | `/` | Create a meal (multipart: `meal` JSON part + optional `image` file) |
| GET | `/{id}` | Get a meal by id |
| GET | `/` | List all meals |
| GET | `/search?name=&type=&minFiber=` | Search/filter meals |

### Meal plans (`/api/v1/meal-plans`) — requires auth

| Method | Path | Description |
|---|---|---|
| POST | `/generate` | Generate a meal plan for a given duration, fasting style, and optional health focus filters |

### Challenges (`/api/v1/challenges`) — requires auth

| Method | Path | Description |
|---|---|---|
| POST | `/{challengeId}/join` | Join a built-in challenge |
| DELETE | `/{challengeId}/join` | Leave a built-in challenge |
| GET | `/counts?ids=a,b,c` | Participant counts per challenge id |

### Custom challenges (`/api/v1/custom-challenges`) — requires auth

| Method | Path | Description |
|---|---|---|
| POST | `/` | Create a custom challenge (returns an invite code) |
| POST | `/join` | Join a custom challenge by invite code |
| GET | `/mine` | Challenges you created or joined |
| GET | `/{id}/members` | List members (members only) |

## Security notes

- Stateless JWT auth via a custom `JwtAuthenticationFilter`; passwords are hashed with BCrypt.
- CORS origins are configured via `CORS_ALLOWED_ORIGINS` (see [Configuration](#configuration)).
- Failed authentication (bad credentials, unknown user) currently surfaces as a generic `403 Forbidden` rather than `401 Unauthorized`, since no custom `AuthenticationEntryPoint` is configured — worth keeping in mind when debugging login failures from a frontend.
- The default `app.jwt.secret` is a placeholder for local development only. Set `JWT_SECRET` to a securely generated value (32+ chars) before deploying anywhere shared.
