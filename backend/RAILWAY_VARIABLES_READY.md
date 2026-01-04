# 🚀 Railway Environment Variables - Ready to Paste

## 📋 તમારા .env file ના બધા variables:

તમારા `.env` file માંથી **દરેક line** ને Railway માં આ રીતે add કરો:

---

## 🔧 Step-by-Step Instructions:

### Railway Dashboard માં:

1. **TeamBond** service → **Variables** tab
2. **"New Variable"** button પર click કરો
3. **Name** અને **Value** paste કરો
4. **Save**
5. **બધા variables માટે repeat કરો**

---

## 📝 Variables List (તમારા .env માંથી):

તમારા `.env` file માંથી આ variables add કરો:

### 1. MongoDB Variables:
```
Name: MONGODB_USERNAME
Value: [તમારા .env માંથી value]

Name: MONGODB_PASSWORD
Value: [તમારા .env માંથી value]

Name: MONGODB_DB
Value: [તમારા .env માંથી value]
```

### 2. Redis Variables:
```
Name: REDIS_URI
Value: [તમારા .env માંથી value]

Name: REDIS_PORT
Value: [તમારા .env માંથી value] (usually 6379)

Name: REDIS_PASSWORD
Value: [તમારા .env માંથી value]
```

### 3. Email Variables:
```
Name: MAIL_ID
Value: [તમારા .env માંથી value]

Name: APP_PASSWORD
Value: [તમારા .env માંથી value]
```

### 4. GitHub OAuth Variables:
```
Name: YOUR_CLIENT_ID
Value: [તમારા .env માંથી value]

Name: YOUR_CLIENT_SECRET
Value: [તમારા .env માંથી value]

Name: redirect-uri
Value: https://teambond-production.up.railway.app/login/oauth2/code/github
(⚠️ Railway URL મળ્યા પછી update કરવું)
```

### 5. API Keys:
```
Name: open.cage.api
Value: [તમારા .env માંથી value]

Name: GEMINI_API_KEY
Value: [તમારા .env માંથી value]
```

### 6. Razorpay Variables:
```
Name: RAZORPAY_WEBHOOK_SECRET
Value: [તમારા .env માંથી value]

Name: RAZORPAY_KEY_ID
Value: [તમારા .env માંથી value]

Name: RAZORPAY_KEY_SECRET
Value: [તમારા .env માંથી value]
```

### 7. RabbitMQ Variables:
```
Name: rabbitmq.queue
Value: [તમારા .env માંથી value]

Name: rabbitmq.dlq.queue
Value: [તમારા .env માંથી value]

Name: rabbitmq.port
Value: [તમારા .env માંથી value] (usually 5672)

Name: rabbitmq.host
Value: [તમારા .env માંથી value]

Name: rabbitmq.username
Value: [તમારા .env માંથી value]

Name: rabbitmq.password
Value: [તમારા .env માંથી value]

Name: SSL_CONNECTION
Value: false (production માટે true કરવું પડશે)
```

### 8. Frontend URL:
```
Name: frontend.url
Value: [તમારી Vercel frontend URL]
(⚠️ Frontend deploy થયા પછી add કરવું)
```

---

## ⚡ Quick Method:

### તમારા .env file માંથી:

**Example line:**
```
MONGODB_USERNAME=myuser123
```

**Railway માં:**
- **Name**: `MONGODB_USERNAME`
- **Value**: `myuser123`

---

## 📋 Complete Checklist:

તમારા `.env` file ની **દરેક line** માટે:

- [ ] Line 1: Variable added
- [ ] Line 2: Variable added
- [ ] Line 3: Variable added
- ... (બધા 67 lines માટે)

---

## ⚠️ Important Notes:

1. **દરેક variable separately add કરવું** - Railway માં bulk import નથી
2. **Values exactly copy કરવા** - spaces અથવા quotes ના remove કરવા
3. **redirect-uri update કરવું** - Railway URL મળ્યા પછી
4. **frontend.url update કરવું** - Vercel URL મળ્યા પછી

---

## 🎯 તમારા .env file ની content share કરો:

તમારા `.env` file ની content (sensitive values hide કરીને) share કરો, અને હું તમારા માટે **exact copy-paste ready format** બનાવી દઉં!

**Format:**
```
MONGODB_USERNAME=***
MONGODB_PASSWORD=***
...
```

અથવા screenshot share કરો (values hide કરીને).

---

**હવે તમારા `.env` file ની content share કરો, અને હું તમારા માટે ready format બનાવી દઉં!** 🚀





