# 🚀 Vercel Deployment Guide

## Prerequisites
- Vercel account (sign up at https://vercel.com)
- GitHub account (if deploying from Git repository)

## Deployment Steps

### Option 1: Deploy via Vercel CLI (Recommended)

1. **Install Vercel CLI** (if not already installed):
   ```bash
   npm install -g vercel
   ```

2. **Navigate to frontend directory**:
   ```bash
   cd frontend/CodeAmigos--Frontend-main
   ```

3. **Login to Vercel**:
   ```bash
   vercel login
   ```

4. **Deploy**:
   ```bash
   vercel
   ```
   - Follow the prompts
   - Select your project settings
   - When asked about environment variables, add: `VITE_API_BASE_URL` with your backend API URL

5. **For production deployment**:
   ```bash
   vercel --prod
   ```

### Option 2: Deploy via Vercel Dashboard

1. **Go to** https://vercel.com/new

2. **Import your Git repository** (GitHub/GitLab/Bitbucket)
   - Connect your repository
   - Select the `frontend/CodeAmigos--Frontend-main` folder as the root directory

3. **Configure Project**:
   - **Framework Preset**: Vite
   - **Root Directory**: `frontend/CodeAmigos--Frontend-main`
   - **Build Command**: `npm run build` (auto-detected)
   - **Output Directory**: `dist` (auto-detected)
   - **Install Command**: `npm install` (auto-detected)

4. **Add Environment Variables**:
   - Go to Project Settings → Environment Variables
   - Add: `VITE_API_BASE_URL` = `your-backend-api-url`
     - Example: `https://your-backend.railway.app` or `https://your-backend.onrender.com`

5. **Deploy**: Click "Deploy"

## Environment Variables

Make sure to set these environment variables in Vercel:

- `VITE_API_BASE_URL`: Your backend API base URL
  - Example: `https://your-backend-api.com`
  - For local development: `http://localhost:8080`

## Important Notes

- The `vercel.json` file is already configured for SPA routing
- All routes will be redirected to `index.html` for client-side routing
- After deployment, update your backend CORS settings to allow your Vercel domain
- The build output will be in the `dist` folder

## Post-Deployment

1. **Update Backend CORS**: Add your Vercel domain to allowed origins in your Spring Boot backend
2. **Test the deployment**: Visit your Vercel URL and test all features
3. **Set up custom domain** (optional): In Vercel dashboard → Settings → Domains

## Troubleshooting

- **Build fails**: Check that all dependencies are in `package.json`
- **API calls fail**: Verify `VITE_API_BASE_URL` is set correctly
- **Routing issues**: The `vercel.json` should handle this automatically





