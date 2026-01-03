# Deployment Instructions

## Step 1: Copy Your .env File

તમારી `.env` file ને `CodeAmigos--Backend-main` folder માં copy કરો.

**Option A: Manual Copy**
1. તમારી `.env` file શોધો
2. તેને copy કરો
3. `CodeAmigos--Backend-main` folder માં paste કરો
4. ખાતરી કરો કે file નું નામ exactly `.env` છે (કોઈ extension નહીં)

**Option B: Using Script**
```bash
copy-env.bat
```
Script તમને file path માટે પૂછશે.

## Step 2: Deploy

```bash
deploy.bat
```

આ script:
1. Maven project build કરશે
2. Docker services start કરશે (MongoDB, Redis, RabbitMQ)
3. Backend build અને start કરશે

## Step 3: Verify

- Backend: http://localhost:8080
- RabbitMQ: http://localhost:15672 (admin/admin123)
- MongoDB: localhost:27017
- Redis: localhost:6379

## Troubleshooting

**જો .env file ન મળે:**
- ખાતરી કરો કે file નું નામ exactly `.env` છે
- File `CodeAmigos--Backend-main` folder માં છે
- File hidden નથી

**જો build fail થાય:**
- Java 17+ installed છે કે નહીં check કરો
- Maven installed છે કે નહીં check કરો

**જો Docker services start ન થાય:**
- Docker Desktop running છે કે નહીં check કરો
- Ports already in use નથી કે check કરો


