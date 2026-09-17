# PromptVault

PromptVault is a React and Supabase MVP for discovering AI image prompts, copying them, and managing them with an admin account.

## Run locally

Install Node.js 20+, run `npm install`, copy `.env.example` to `.env`, and set `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. Run `supabase/schema.sql`, then `supabase/seed.sql` in the Supabase SQL Editor. Start with `npm run dev`; verify production with `npm run build` and `npm run preview`.

## First admin

Create a Supabase Auth user, then replace the UUID and run:

```sql
insert into public.profiles (id,email,display_name,role) values ('AUTH_USER_UUID','admin@example.com','Administrator','admin') on conflict (id) do update set role='admin';
```

The browser only uses the anon key. Supabase RLS and `profiles.role` enforce admin access.

## Deploy

Push to GitHub, import in Vercel, add the two `VITE_SUPABASE_*` variables to Vercel, and configure the Vercel URL in Supabase Auth redirect settings.

The project uses React, Vite, React Router, Lucide and Supabase. `src/components` contains reusable UI, `src/hooks` provides query state, and `supabase/` holds executable schema and demo content. Seed images are Unsplash demonstration images.
