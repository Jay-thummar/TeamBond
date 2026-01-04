# 🔧 Railway Environment Variables Setup

## 📋 તમારા .env file ના variables Railway માં કેવી રીતે add કરવા:

### Step 1: Railway Dashboard પર જાઓ
1. Railway Dashboard → **TeamBond** service
2. **Variables** tab પર click કરો

### Step 2: Variables Add કરો

Railway માં **દરેક variable separately add કરવું પડે છે.**

તમારા `.env` file માં જે variables છે, તે બધા નીચે format માં છે:

---

## 📝 Copy-Paste Ready Variables:

તમારા `.env` file માંથી આ format માં add કરો:

### Format:
```
VARIABLE_NAME=value
```

### Example:
જો તમારા `.env` માં આ છે:
```
MONGODB_USERNAME=myuser
MONGODB_PASSWORD=mypass
```

તો Railway માં:
1. **"New Variable"** button પર click કરો
2. **Name**: `MONGODB_USERNAME`
3. **Value**: `myuser`
4. **Save**

ફરી:
1. **"New Variable"** button પર click કરો
2. **Name**: `MONGODB_PASSWORD`
3. **Value**: `mypass`
4. **Save**

---

## 🔍 Required Variables (તમારા .env માંથી):

તમારા `.env` file માંથી આ variables add કરો:

### MongoDB:
- `MONGODB_USERNAME`
- `MONGODB_PASSWORD`
- `MONGODB_DB`

### Redis:
- `REDIS_URI`
- `REDIS_PORT`
- `REDIS_PASSWORD`

### Email:
- `MAIL_ID`
- `APP_PASSWORD`

### GitHub OAuth:
- `YOUR_CLIENT_ID`
- `YOUR_CLIENT_SECRET`
- `redirect-uri` (આ Railway URL સાથે update કરવું પડશે)

### APIs:
- `open.cage.api`
- `GEMINI_API_KEY`

### Razorpay:
- `RAZORPAY_WEBHOOK_SECRET`
- `RAZORPAY_KEY_ID`
- `RAZORPAY_KEY_SECRET`

### RabbitMQ:
- `rabbitmq.queue`
- `rabbitmq.dlq.queue`
- `rabbitmq.port`
- `rabbitmq.host`
- `rabbitmq.username`
- `rabbitmq.password`
- `SSL_CONNECTION`

### Frontend URL:
- `frontend.url` (તમારી Vercel frontend URL)

---

## ⚠️ Important Notes:

1. **redirect-uri update કરવું:**
   - Railway માં service expose કર્યા પછી URL મળશે
   - Example: `https://teambond-production.up.railway.app`
   - `redirect-uri` = `https://teambond-production.up.railway.app/login/oauth2/code/github`

2. **frontend.url update કરવું:**
   - Vercel પર frontend deploy કર્યા પછી
   - Example: `https://your-frontend.vercel.app`

3. **દરેક variable separately add કરવું:**
   - Railway માં bulk import નથી
   - એક-એક કરીને add કરવું પડે છે

---

## 🚀 Quick Steps:

1. તમારા `.env` file open કરો
2. Railway Dashboard → Variables → New Variable
3. `.env` માંથી variable name અને value copy કરો
4. Railway માં paste કરો
5. Save કરો
6. બધા variables માટે repeat કરો

---

**તમારા `.env` file ની content share કરો, અને હું તમારા માટે exact format માં list બનાવી દઉં!** 📋






