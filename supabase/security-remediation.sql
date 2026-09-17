-- Run once in Supabase SQL Editor after schema.sql.
-- Fixes the Supabase linter findings without disabling RLS.

-- Pin the trigger function's lookup path.
create or replace function public.update_timestamp()
returns trigger
language plpgsql
set search_path = public
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

-- A public bucket already exposes public object URLs. This policy is not needed
-- and would let anyone enumerate every object in the bucket.
drop policy if exists "public reads prompt images" on storage.objects;

-- Lock down SECURITY DEFINER helpers. They continue to run from RLS policies
-- and database triggers, but cannot be invoked through the public REST RPC API.
revoke all on function public.is_admin() from public, anon, authenticated;
revoke all on function public.increment_copy_count(uuid) from public, anon, authenticated;
revoke all on function public.increment_like_count(uuid) from public, anon, authenticated;
revoke all on function public.sync_like_count() from public, anon, authenticated;

-- This function was not created by PromptVault's schema but is present in the
-- linter report. Remove its REST access too; leave its owner/admin access intact.
revoke all on function public.rls_auto_enable() from public, anon, authenticated;

-- Do not grant this function to browser roles. Copy tracking should be moved to
-- a Supabase Edge Function when analytics are required.
