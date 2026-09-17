-- Run once in Supabase SQL Editor. This restores RLS reads without exposing
-- the admin helper as a public RPC endpoint.

create schema if not exists private;
revoke all on schema private from public, anon, authenticated;

create or replace function private.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

-- RLS policy evaluation can invoke this private helper. It is outside Supabase's
-- public REST schema, so it is not available at /rest/v1/rpc.
grant usage on schema private to anon, authenticated;
grant execute on function private.is_admin() to anon, authenticated;

drop policy if exists "public reads published prompts" on public.prompts;
drop policy if exists "admins manage prompts" on public.prompts;
create policy "public reads published prompts" on public.prompts
  for select using (published or private.is_admin());
create policy "admins manage prompts" on public.prompts
  for all to authenticated
  using (private.is_admin()) with check (private.is_admin());

drop policy if exists "admins upload prompt images" on storage.objects;
drop policy if exists "admins delete prompt images" on storage.objects;
create policy "admins upload prompt images" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'prompt-images' and private.is_admin());
create policy "admins delete prompt images" on storage.objects
  for delete to authenticated
  using (bucket_id = 'prompt-images' and private.is_admin());

-- Public version is no longer used by policies or the client.
revoke all on function public.is_admin() from public, anon, authenticated;
