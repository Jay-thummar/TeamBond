# 🚀 Deployment Checklist - TeamBond

## ✅ Fixed Issues:
1. ✅ Removed hardcoded localhost URLs from CORS configuration
2. ✅ All URLs now use environment variables
3. ✅ Lombok annotation processing configured
4. ✅ Dockerfile updated for Java 21

---

## 📋 Environment Variables Required

### 🔵 Railway (Backend) - Required Variables:

#### Basic Configuration:
- `PORT` - Auto-set by Railway (don't set manually)
- `frontend.url` - Your Vercel frontend URL (e.g., `https://your-app.vercel.app`)
- `CORS_ALLOWED_ORIGINS` - Comma-separated frontend URLs (e.g., `https://your-app.vercel.app,https://another.vercel.app`)

#### Database & Services:
- `MONGODB_USERNAME` - MongoDB username
- `MONGODB_PASSWORD` - MongoDB password
- `MONGODB_DB` - MongoDB database name
- `REDIS_URI` - Redis host (e.g., `redis.upstash.io`)
- `REDIS_PORT` - Redis port (usually `6379` or `443` for Upstash)
- `REDIS_PASSWORD` - Redis password

#### RabbitMQ:
- `rabbitmq.host` - RabbitMQ host
- `rabbitmq.port` - RabbitMQ port (usually `5672` or `443`)
- `rabbitmq.username` - RabbitMQ username
- `rabbitmq.password` - RabbitMQ password
- `rabbitmq.queue` - Queue name (e.g., `TeamBond`)
- `rabbitmq.dlq.queue` - Dead letter queue name (e.g., `dlqTeamBond`)
- `rabbitmq.exchange` - Exchange name (e.g., `TeamBond`)
- `rabbitmq.routingKey` - Routing key (e.g., `TeamBond`)
- `rabbitmq.dlx.exchange` - Dead letter exchange (e.g., `dlqTeamBond`)
- `rabbitmq.dlq.routingKey` - DLQ routing key (e.g., `dlqTeamBond`)
- `SSL_CONNECTION` - `true` for cloud RabbitMQ, `false` for local

#### OAuth2 (GitHub):
- `YOUR_CLIENT_ID` - GitHub OAuth Client ID
- `YOUR_CLIENT_SECRET` - GitHub OAuth Client Secret
- `redirect-uri` - OAuth redirect URI (e.g., `https://your-backend.railway.app/oauth2/callback/github`)

#### Other Services:
- `JWT_SECRET_KEY` - Secret key for JWT tokens
- `MAIL_ID` - Gmail address for sending emails
- `APP_PASSWORD` - Gmail app password
- `open.cage.api` - OpenCage API key
- `GEMINI_API_KEY` - Google Gemini API key
- `RAZORPAY_KEY_ID` - Razorpay key ID
- `RAZORPAY_KEY_SECRET` - Razorpay key secret
- `RAZORPAY_WEBHOOK_SECRET` - Razorpay webhook secret
- `Supervisor_Emails` - Comma-separated email addresses for error notifications

---

### 🟢 Vercel (Frontend) - Required Variables:

#### API Configuration:
- `VITE_API_BASE_URL` - Your Railway backend URL (e.g., `https://your-backend.railway.app`)

**Important:** 
- Make sure there's NO trailing slash in `VITE_API_BASE_URL`
- Example: `https://your-backend.railway.app` ✅
- NOT: `https://your-backend.railway.app/` ❌

---

## 🔧 Deployment Steps:

### 1. Backend (Railway):
1. Go to Railway dashboard
2. Create new project from GitHub repo
3. Set **Root Directory** to `backend`
4. Add all environment variables from the list above
5. Deploy will start automatically

### 2. Frontend (Vercel):
1. Go to Vercel dashboard
2. Import GitHub repository
3. Set **Root Directory** to `frontend/CodeAmigos--Frontend-main`
4. Add environment variable: `VITE_API_BASE_URL` = Your Railway backend URL
5. Deploy

### 3. After Deployment:

#### Update Railway Variables:
1. Get your Vercel frontend URL
2. In Railway, update:
   - `frontend.url` = Your Vercel URL
   - `CORS_ALLOWED_ORIGINS` = Your Vercel URL (and any other allowed origins)
   - `redirect-uri` = `https://your-backend.railway.app/oauth2/callback/github`

#### Update GitHub OAuth Settings:
1. Go to GitHub → Settings → Developer settings → OAuth Apps
2. Update **Authorization callback URL** to: `https://your-backend.railway.app/oauth2/callback/github`

---

## ✅ Verification Checklist:

- [ ] Backend deployed on Railway
- [ ] Frontend deployed on Vercel
- [ ] All environment variables set in Railway
- [ ] `VITE_API_BASE_URL` set in Vercel
- [ ] `frontend.url` updated in Railway with Vercel URL
- [ ] `CORS_ALLOWED_ORIGINS` set in Railway
- [ ] GitHub OAuth callback URL updated
- [ ] No localhost URLs in code (all fixed ✅)
- [ ] Test API calls from frontend
- [ ] Test OAuth login flow

---

## 🐛 Common Issues:

### CORS Errors:
- Make sure `CORS_ALLOWED_ORIGINS` includes your Vercel URL
- Make sure `frontend.url` is set correctly

### API Calls Failing:
- Check `VITE_API_BASE_URL` in Vercel (no trailing slash!)
- Check backend is running on Railway
- Check Railway logs for errors

### OAuth Not Working:
- Verify `redirect-uri` in Railway matches GitHub OAuth app settings
- Check `YOUR_CLIENT_ID` and `YOUR_CLIENT_SECRET` are correct

---

## 📝 Notes:

- All localhost references have been removed ✅
- CORS now uses environment variables ✅
- Frontend uses `VITE_API_BASE_URL` from environment ✅
- Backend uses `frontend.url` from environment ✅



