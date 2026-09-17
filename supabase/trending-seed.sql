-- Twenty original prompt templates using dynamically generated AI preview URLs.
-- Run once in Supabase SQL Editor after schema.sql. They are not copied from social creators.
with prompt_data(title,category,tags,prompt,rank) as (values
('Neon Noir Street Portrait','Cinematic',array['neon','portrait','rain'],'Cinematic close portrait in a rain-soaked neon street, cyan and magenta reflections, 85mm lens, shallow depth of field, natural skin texture, premium editorial color grade.',1),
('Action Figure Desk Scene','3D',array['toy','3d','miniature'],'Collectible action figure on a creator desk, translucent display box, dramatic product lighting, tactile plastic detail, polished 3D render.',2),
('Old Money Summer Editorial','Fashion',array['fashion','editorial','summer'],'Quiet luxury fashion editorial at a Mediterranean villa, linen tailoring, warm morning sun, magazine composition, medium format film.',3),
('Anime City Commute','Anime',array['anime','city','sunset'],'Detailed anime scene of a commuter crossing a glowing city intersection at sunset, expressive lighting, hand-painted background, crisp linework.',4),
('Celestial Bridal Portrait','Wedding',array['wedding','ethereal','portrait'],'Ethereal bridal portrait under a moonlit garden arch, silk gown, soft haze, romantic editorial photography, delicate botanical details.',5),
('Tiny Chef Kitchen','3D',array['miniature','food','3d'],'Whimsical miniature chef preparing pasta in an oversized kitchen, cinematic macro lens, realistic steam, charming detailed 3D illustration.',6),
('Fantasy Glass Armor','Fantasy',array['fantasy','armor','glass'],'Heroic fantasy warrior in luminous glass armor beside an ancient waterfall, mist, ornate detail, dramatic wide cinematic composition.',7),
('Chrome Sneaker Launch','Product',array['product','sneaker','chrome'],'Futuristic sneaker floating above liquid chrome, sculptural studio lighting, sharp commercial product photography, charcoal background.',8),
('Coastal Film Couple','Couple',array['couple','travel','film'],'Joyful couple on a windy coastal cliff, candid movement, golden-hour rim light, 35mm film grain, understated travel editorial.',9),
('Tokyo Window Reflection','Portrait',array['portrait','tokyo','night'],'Moody portrait through a Tokyo train window, layered reflections, blue-hour city lights, analog grain, intimate cinematic framing.',10),
('Desert Silk Campaign','Fashion',array['fashion','desert','campaign'],'High-fashion campaign in pale desert dunes, flowing sculptural silk, hard sun and long shadows, luxury editorial photography.',11),
('Dream Library Portal','Fantasy',array['fantasy','library','magic'],'An ancient library opening into a star-filled portal, warm lamp light, floating books, intricate fantasy concept art.',12),
('Retro Futurist Car','Cinematic',array['retro','car','cinematic'],'Retro-futurist coupe driving through a foggy night highway, sodium lights, wet asphalt, anamorphic flare, cinematic still.',13),
('Coffee Ritual Still Life','Product',array['coffee','product','still-life'],'Artful coffee ritual still life on dark stone, soft side light, rising steam, tactile ceramics, premium campaign photography.',14),
('Mountain Window Escape','Travel',array['travel','mountains','interior'],'Minimal cabin interior framing misty alpine peaks, quiet morning light, architectural photography, calm Scandinavian palette.',15),
('Sculptural Flower Dress','Fashion',array['fashion','flowers','couture'],'Couture portrait in a sculptural flower dress, studio backdrop, soft directional beauty light, refined high-fashion composition.',16),
('Cyberpunk Market Walk','Anime',array['anime','cyberpunk','market'],'Anime protagonist walking through a dense cyberpunk night market, lanterns, rain, rich color, dynamic perspective.',17),
('Ocean Glass House','Architecture',array['architecture','ocean','luxury'],'Modern glass house hovering above an ocean cliff at dusk, warm interior glow, cinematic architectural visualization.',18),
('Golden Garden Proposal','Wedding',array['wedding','garden','goldenhour'],'Surprise garden proposal at golden hour, candid emotion, soft bloom, elegant documentary wedding photography.',19),
('Astronaut Flower Field','Fantasy',array['astronaut','surreal','flowers'],'Lone astronaut in a vast field of luminous wildflowers beneath a violet sky, surreal cinematic concept art.',20)
) insert into public.prompts(title,prompt,image_url,category,tags,copy_count,like_count,published)
select title,prompt,'https://image.pollinations.ai/prompt/'||replace(replace(prompt,' ','%20'),',','')||'?width=900&height=1100&seed='||rank,category,tags,(9000-rank*280),(600-rank*17),true from prompt_data;
