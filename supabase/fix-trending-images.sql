-- Replaces unreliable dynamic preview URLs with stable demonstration image URLs.
-- Run once in Supabase SQL Editor.
with replacements(title, image_url) as (values
('Neon Noir Street Portrait','https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=1200'),
('Action Figure Desk Scene','https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=1200'),
('Old Money Summer Editorial','https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=1200'),
('Anime City Commute','https://images.unsplash.com/photo-1519608487953-e999c86e7451?w=1200'),
('Celestial Bridal Portrait','https://images.unsplash.com/photo-1519741497674-611481863552?w=1200'),
('Tiny Chef Kitchen','https://images.unsplash.com/photo-1556911220-e15b29be8c8f?w=1200'),
('Fantasy Glass Armor','https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=1200'),
('Chrome Sneaker Launch','https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=1200'),
('Coastal Film Couple','https://images.unsplash.com/photo-1519741497674-611481863552?w=1200'),
('Tokyo Window Reflection','https://images.unsplash.com/photo-1519608487953-e999c86e7451?w=1200'),
('Desert Silk Campaign','https://images.unsplash.com/photo-1529139574466-a303027c1d8b?w=1200'),
('Dream Library Portal','https://images.unsplash.com/photo-1507842217343-583bb7270b66?w=1200'),
('Retro Futurist Car','https://images.unsplash.com/photo-1503376780353-7e6692767b70?w=1200'),
('Coffee Ritual Still Life','https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=1200'),
('Mountain Window Escape','https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=1200'),
('Sculptural Flower Dress','https://images.unsplash.com/photo-1496747611176-843222e1e57c?w=1200'),
('Cyberpunk Market Walk','https://images.unsplash.com/photo-1519608487953-e999c86e7451?w=1200'),
('Ocean Glass House','https://images.unsplash.com/photo-1511818966892-d7d671e672a2?w=1200'),
('Golden Garden Proposal','https://images.unsplash.com/photo-1519741497674-611481863552?w=1200'),
('Astronaut Flower Field','https://images.unsplash.com/photo-1469474968028-56623f02e42e?w=1200')
)
update public.prompts p set image_url = r.image_url from replacements r where p.title = r.title;
