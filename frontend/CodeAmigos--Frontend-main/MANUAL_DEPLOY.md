# 📋 Manual Vercel Deployment - Step by Step Guide

## Step 1: Vercel Account બનાવો

1. Browser માં જાઓ: **https://vercel.com**
2. **Sign Up** કરો (GitHub, GitLab, અથવા Email સાથે)
3. Login કરો

---

## Step 2: GitHub પર Code Push કરો (જો હજુ નથી કર્યું)

### Option A: જો તમારું code GitHub પર છે:
- Skip કરો અને Step 3 પર જાઓ

### Option B: જો GitHub પર નથી:
1. **GitHub.com** પર જાઓ અને નવું repository બનાવો
2. Terminal માં આ commands run કરો:

```bash
cd frontend/CodeAmigos--Frontend-main
git init
git add .
git commit -m "Initial commit for Vercel deployment"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git push -u origin main
```

---

## Step 3: Vercel પર Project Import કરો

1. **Vercel Dashboard** પર જાઓ: https://vercel.com/dashboard
2. **"Add New..."** button પર click કરો
3. **"Project"** select કરો
4. **"Import Git Repository"** પર click કરો
5. તમારું GitHub repository select કરો
6. **"Import"** button પર click કરો

---

## Step 4: Project Configuration

### 4.1 Framework Settings:
- **Framework Preset**: `Vite` (auto-detect થશે)
- **Root Directory**: `frontend/CodeAmigos--Frontend-main` 
  - જો monorepo હોય તો આ set કરો
  - અથવા જો frontend folder જ GitHub પર push કર્યું હોય તો `.` (current directory)

### 4.2 Build Settings:
- **Build Command**: `npm run build` (auto-detect થશે)
- **Output Directory**: `dist` (auto-detect થશે)
- **Install Command**: `npm install` (auto-detect થશે)

### 4.3 Environment Variables:
1. **"Environment Variables"** section માં જાઓ
2. **"Add"** button પર click કરો
3. આ variable add કરો:
   - **Name**: `VITE_API_BASE_URL`
   - **Value**: તમારી backend API URL
     - Example: `https://your-backend.railway.app`
     - અથવા: `https://your-backend.onrender.com`
     - Local development માટે: `http://localhost:8080`
   - **Environment**: ત્રણેય select કરો (Production, Preview, Development)
4. **"Save"** કરો

---

## Step 5: Deploy કરો

1. **"Deploy"** button પર click કરો
2. Vercel automatically build કરશે
3. Build complete થયા પછી તમને **deployment URL** મળશે
   - Example: `https://your-project-name.vercel.app`

---

## Step 6: Post-Deployment Setup

### 6.1 Backend CORS Update:
તમારા Spring Boot backend માં CORS settings update કરો:

```java
@CrossOrigin(origins = {
    "https://your-project-name.vercel.app",
    "http://localhost:5173"  // local development
})
```

અથવા `application.properties` માં:
```properties
cors.allowed-origins=https://your-project-name.vercel.app,http://localhost:5173
```

### 6.2 Test કરો:
1. Vercel URL open કરો
2. Application test કરો
3. API calls check કરો

---

## Step 7: Custom Domain (Optional)

1. Vercel Dashboard → તમારું Project → **Settings**
2. **Domains** section માં જાઓ
3. તમારું domain add કરો
4. DNS settings follow કરો

---

## Important Notes ⚠️

1. **Environment Variables**: `VITE_API_BASE_URL` ખાસ કરીને important છે
2. **Build Output**: Vite automatically `dist` folder માં build કરે છે
3. **Routing**: `vercel.json` file SPA routing handle કરે છે
4. **Re-deploy**: જ્યારે પણ code change કરો, Vercel automatically re-deploy કરશે

---

## Troubleshooting 🔧

### Build Fails:
- Check `package.json` માં બધા dependencies છે કે નહીં
- Check build logs માં error messages

### API Calls નથી થતા:
- Verify `VITE_API_BASE_URL` environment variable set છે
- Check backend CORS settings
- Check browser console માં errors

### Routing Issues:
- `vercel.json` file check કરો
- All routes should redirect to `index.html`

---

## Quick Checklist ✅

- [ ] Vercel account created
- [ ] Code pushed to GitHub
- [ ] Project imported in Vercel
- [ ] Root directory set correctly
- [ ] Environment variable `VITE_API_BASE_URL` added
- [ ] Deploy button clicked
- [ ] Build successful
- [ ] Backend CORS updated
- [ ] Application tested

---

**તૈયાર! 🎉** તમારું application Vercel પર live છે!






