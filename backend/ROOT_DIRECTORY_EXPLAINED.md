# 📁 Root Directory શું છે? (Simple Explanation)

## 🎯 સરળ ભાષામાં:

**Root Directory** = Platform ને કહેવું કે તમારું backend code કયા folder માં છે

---

## 📂 તમારું Project Structure:

```
Temp_Monorepo/                    ← GitHub Repository Root
│
├── backend/                      ← આ તમારું BACKEND છે
│   ├── pom.xml                  ← Maven configuration
│   ├── Dockerfile               ← Docker configuration
│   ├── src/                     ← Java source code
│   └── ...
│
└── frontend/                     ← આ તમારું FRONTEND છે
    └── CodeAmigos--Frontend-main/
        ├── package.json
        ├── src/
        └── ...
```

---

## 🤔 કેમ Root Directory જરૂરી છે?

### Problem:
- તમારું **entire repository** GitHub પર છે
- Repository માં **બંને** backend અને frontend છે
- Railway/Render ને કહેવું પડે કે **કયા folder માં** backend code છે

### Solution:
- **Root Directory: `backend`** set કરો
- આથી platform જાણશે કે `backend/` folder માં જવું
- Platform `backend/pom.xml`, `backend/Dockerfile` જોશે

---

## 🖼️ Visual Example:

### ❌ Root Directory ન set કર્યું નહીં:
```
Railway thinks:
"મને pom.xml ક્યાં છે? Repository root માં નથી!"
→ Build FAILS ❌
```

### ✅ Root Directory: `backend` set કર્યું:
```
Railway thinks:
"ઓહ! backend/ folder માં pom.xml છે!"
→ Build SUCCESS ✅
```

---

## 📋 Railway માં કેવી રીતે Set કરવું:

### Step 1: Project Settings
1. Railway Dashboard → તમારું Project
2. **Settings** tab પર click કરો
3. **Root Directory** section માં જાઓ

### Step 2: Set Root Directory
1. **Root Directory** field માં type કરો: `backend`
2. **Save** કરો

**અથવા**

Project create કરતી વખતે:
1. **"Deploy from GitHub repo"** select કરો
2. Repository select કરો
3. **"Configure"** પર click કરો
4. **Root Directory** માં: `backend` type કરો
5. **Deploy** કરો

---

## 🎯 Frontend માટે પણ Same:

Frontend Vercel પર deploy કરતી વખતે:
- **Root Directory**: `frontend/CodeAmigos--Frontend-main`

કારણ કે:
- Repository root: `Temp_Monorepo/`
- Frontend code: `Temp_Monorepo/frontend/CodeAmigos--Frontend-main/`

---

## ✅ Quick Checklist:

- [ ] Repository structure સમજાયું
- [ ] Backend code `backend/` folder માં છે
- [ ] Railway માં Root Directory: `backend` set કર્યું
- [ ] Build successful!

---

## 💡 Summary:

**Root Directory = Platform ને કહેવું કે code કયા folder માં છે**

તમારા કિસ્સામાં:
- **Backend**: Root Directory = `backend`
- **Frontend**: Root Directory = `frontend/CodeAmigos--Frontend-main`

આથી platform જાણશે કે કયા folder માં જવું! 🎯





