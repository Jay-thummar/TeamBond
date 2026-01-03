# 🚀 Deploy કરવા માટે

## તમારી .env file તૈયાર છે! ✅

હવે deployment start કરો:

### Option 1: Automated Script (Recommended)
```bash
cd CodeAmigos--Backend-main
deploy.bat
```

આ script automatically:
1. ✅ Maven project build કરશે
2. ✅ Docker services start કરશે (MongoDB, Redis, RabbitMQ)
3. ✅ Backend build અને start કરશે

### Option 2: Manual Steps

**Step 1: Build JAR**
```bash
cd CodeAmigos--Backend-main
mvn clean package -DskipTests
```

**Step 2: Start Services**
```bash
docker-compose up -d mongodb redis rabbitmq
```

**Step 3: Wait 15 seconds for services to initialize**

**Step 4: Start Backend**
```bash
docker-compose up -d --build backend
```

## ✅ Deployment પછી Check કરો:

- **Backend API**: http://localhost:8080
- **RabbitMQ Management**: http://localhost:15672
  - Username: `admin`
  - Password: `admin123` (અથવા તમારા .env માં જે password છે)
- **MongoDB**: localhost:27017
- **Redis**: localhost:6379

## 📋 Useful Commands:

```bash
# View backend logs
docker-compose logs -f backend

# View all logs
docker-compose logs -f

# Stop all services
docker-compose down

# Restart services
docker-compose restart

# Check running containers
docker-compose ps
```

## ⚠️ જો કોઈ Error આવે:

1. **Build fails**: Java 17+ અને Maven installed છે કે check કરો
2. **Docker errors**: Docker Desktop running છે કે check કરો
3. **Port conflicts**: Ports 8080, 27017, 6379, 5672, 15672 free છે કે check કરો
4. **.env file**: ખાતરી કરો કે .env file backend folder માં છે

## 🎉 Success!

જો બધું સારું ચાલે, તો તમારું backend http://localhost:8080 પર running હશે!


