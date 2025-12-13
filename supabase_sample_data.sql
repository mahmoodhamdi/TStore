-- ===========================================
-- TStore Sample Data with Real Images
-- Run this in Supabase SQL Editor AFTER running supabase_schema.sql
-- ===========================================

-- ==================== CATEGORIES ====================
INSERT INTO categories (id, name, description, image_url, sort_order, is_active) VALUES
  ('c1000000-0000-0000-0000-000000000001', 'Electronics', 'Smartphones, Laptops, Headphones, and Gadgets', 'https://i.imgur.com/ZANVnHE.jpeg', 1, true),
  ('c1000000-0000-0000-0000-000000000002', 'Clothes', 'T-Shirts, Hoodies, Jackets, and Fashion', 'https://i.imgur.com/QkIa5tT.jpeg', 2, true),
  ('c1000000-0000-0000-0000-000000000003', 'Shoes', 'Sneakers, Boots, Heels, and Sandals', 'https://i.imgur.com/qNOjJje.jpeg', 3, true),
  ('c1000000-0000-0000-0000-000000000004', 'Furniture', 'Sofas, Tables, Chairs, and Home Decor', 'https://i.imgur.com/Qphac99.jpeg', 4, true),
  ('c1000000-0000-0000-0000-000000000005', 'Accessories', 'Bags, Watches, Jewelry, and More', 'https://i.imgur.com/BG8J0Fj.jpg', 5, true);

-- ==================== BRANDS ====================
INSERT INTO brands (id, name, description, logo_url, is_featured, is_active) VALUES
  ('b1000000-0000-0000-0000-000000000001', 'TechPro', 'Premium Electronics & Gadgets', 'https://i.imgur.com/ItHcq7o.jpeg', true, true),
  ('b1000000-0000-0000-0000-000000000002', 'StyleWear', 'Modern Fashion & Apparel', 'https://i.imgur.com/QkIa5tT.jpeg', true, true),
  ('b1000000-0000-0000-0000-000000000003', 'StepUp', 'Quality Footwear for Every Occasion', 'https://i.imgur.com/qNOjJje.jpeg', true, true),
  ('b1000000-0000-0000-0000-000000000004', 'HomeElegance', 'Elegant Furniture & Home Decor', 'https://i.imgur.com/Qphac99.jpeg', false, true),
  ('b1000000-0000-0000-0000-000000000005', 'UrbanStyle', 'Urban Fashion Accessories', 'https://i.imgur.com/BG8J0Fj.jpg', false, true);

-- ==================== PRODUCTS ====================

-- Electronics
INSERT INTO products (id, name, description, price, sale_price, category_id, brand_id, stock, thumbnail, images, rating, reviews_count, is_featured, is_active) VALUES
  ('a1000000-0000-0000-0000-000000000001', 'Sleek Wireless Headphones', 'Premium wireless headphones with noise cancellation and 30-hour battery life. Crystal clear audio quality for music lovers.', 149.99, 119.99, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 50, 'https://i.imgur.com/yVeIeDa.jpeg', ARRAY['https://i.imgur.com/yVeIeDa.jpeg', 'https://i.imgur.com/jByJ4ih.jpeg', 'https://i.imgur.com/KXj6Tpb.jpeg'], 4.8, 124, true, true),

  ('a1000000-0000-0000-0000-000000000002', 'Comfort-Fit Over-Ear Headphones', 'Ergonomic design with premium cushioning for all-day comfort. Hi-Fi sound quality with deep bass.', 89.99, NULL, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 75, 'https://i.imgur.com/SolkFEB.jpeg', ARRAY['https://i.imgur.com/SolkFEB.jpeg', 'https://i.imgur.com/KIGW49u.jpeg', 'https://i.imgur.com/mWwek7p.jpeg'], 4.5, 89, true, true),

  ('a1000000-0000-0000-0000-000000000003', 'Wireless Computer Mouse', 'Ergonomic wireless mouse with precision tracking and long battery life. Perfect for work and gaming.', 39.99, 29.99, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 120, 'https://i.imgur.com/w3Y8NwQ.jpeg', ARRAY['https://i.imgur.com/w3Y8NwQ.jpeg', 'https://i.imgur.com/WJFOGIC.jpeg', 'https://i.imgur.com/dV4Nklf.jpeg'], 4.3, 256, false, true),

  ('a1000000-0000-0000-0000-000000000004', 'Mirror Finish Phone Case', 'Sleek mirror finish phone case with shock-absorbing edges. Compatible with latest smartphone models.', 24.99, NULL, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 200, 'https://i.imgur.com/yb9UQKL.jpeg', ARRAY['https://i.imgur.com/yb9UQKL.jpeg', 'https://i.imgur.com/m2owtQG.jpeg', 'https://i.imgur.com/bNiORct.jpeg'], 4.2, 178, false, true),

  ('a1000000-0000-0000-0000-000000000005', 'Modern Laptop for Professionals', 'High-performance laptop with 16GB RAM, 512GB SSD, and stunning display. Perfect for work and creativity.', 1299.99, 1149.99, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 25, 'https://i.imgur.com/ItHcq7o.jpeg', ARRAY['https://i.imgur.com/ItHcq7o.jpeg', 'https://i.imgur.com/55GM3XZ.jpeg', 'https://i.imgur.com/tcNJxoW.jpeg'], 4.9, 67, true, true),

  ('a1000000-0000-0000-0000-000000000006', 'Efficient 2-Slice Toaster', 'Compact toaster with multiple browning settings and easy-clean crumb tray. Perfect for quick breakfasts.', 49.99, 39.99, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 80, 'https://i.imgur.com/keVCVIa.jpeg', ARRAY['https://i.imgur.com/keVCVIa.jpeg', 'https://i.imgur.com/afHY7v2.jpeg', 'https://i.imgur.com/yAOihUe.jpeg'], 4.4, 92, false, true),

  ('a1000000-0000-0000-0000-000000000007', 'Red & Silver Over-Ear Headphones', 'Stylish headphones with powerful bass and noise isolation. Stand out with bold red and silver design.', 79.99, NULL, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 60, 'https://i.imgur.com/YaSqa06.jpeg', ARRAY['https://i.imgur.com/YaSqa06.jpeg', 'https://i.imgur.com/isQAliJ.jpeg', 'https://i.imgur.com/5B8UQfh.jpeg'], 4.6, 145, true, true),

  ('a1000000-0000-0000-0000-000000000008', 'Modern Laptop with Ambient Lighting', 'Gaming laptop with RGB keyboard and ambient lighting. Powerful graphics for immersive gaming experience.', 1499.99, NULL, 'c1000000-0000-0000-0000-000000000001', 'b1000000-0000-0000-0000-000000000001', 15, 'https://i.imgur.com/OKn1KFI.jpeg', ARRAY['https://i.imgur.com/OKn1KFI.jpeg', 'https://i.imgur.com/G4f21Ai.jpeg', 'https://i.imgur.com/Z9oKRVJ.jpeg'], 4.7, 38, true, true);

-- Clothes
INSERT INTO products (id, name, description, price, sale_price, category_id, brand_id, stock, thumbnail, images, rating, reviews_count, is_featured, is_active) VALUES
  ('a1000000-0000-0000-0000-000000000009', 'Classic White Crew Neck T-Shirt', 'Premium cotton t-shirt with a relaxed fit. Essential wardrobe staple for everyday comfort.', 29.99, NULL, 'c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002', 150, 'https://i.imgur.com/axsyGpD.jpeg', ARRAY['https://i.imgur.com/axsyGpD.jpeg', 'https://i.imgur.com/T8oq9X2.jpeg', 'https://i.imgur.com/J6MinJn.jpeg'], 4.5, 234, true, true),

  ('a1000000-0000-0000-0000-000000000010', 'Classic Black T-Shirt', 'Timeless black t-shirt made from soft, breathable cotton. Perfect for casual or dressed-up looks.', 34.99, 24.99, 'c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002', 180, 'https://i.imgur.com/9DqEOV5.jpeg', ARRAY['https://i.imgur.com/9DqEOV5.jpeg', 'https://i.imgur.com/ae0AEYn.jpeg', 'https://i.imgur.com/mZ4rUjj.jpeg'], 4.6, 312, true, true),

  ('a1000000-0000-0000-0000-000000000011', 'Classic Heather Gray Hoodie', 'Cozy hoodie with kangaroo pocket and adjustable drawstring hood. Perfect for layering in cooler weather.', 69.99, 54.99, 'c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002', 90, 'https://i.imgur.com/cHddUCu.jpeg', ARRAY['https://i.imgur.com/cHddUCu.jpeg', 'https://i.imgur.com/CFOjAgK.jpeg', 'https://i.imgur.com/wbIMMme.jpeg'], 4.7, 187, true, true),

  ('a1000000-0000-0000-0000-000000000012', 'Classic Grey Hooded Sweatshirt', 'Premium quality sweatshirt with a modern fit. Soft fleece interior for maximum comfort.', 89.99, NULL, 'c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002', 70, 'https://i.imgur.com/R2PN9Wq.jpeg', ARRAY['https://i.imgur.com/R2PN9Wq.jpeg', 'https://i.imgur.com/IvxMPFr.jpeg', 'https://i.imgur.com/7eW9nXP.jpeg'], 4.8, 156, false, true),

  ('a1000000-0000-0000-0000-000000000013', 'Classic Red Baseball Cap', 'Adjustable baseball cap with embroidered logo. One size fits most with comfortable cotton construction.', 24.99, 19.99, 'c1000000-0000-0000-0000-000000000002', 'b1000000-0000-0000-0000-000000000002', 200, 'https://i.imgur.com/cBuLvBi.jpeg', ARRAY['https://i.imgur.com/cBuLvBi.jpeg', 'https://i.imgur.com/N1GkCIR.jpeg', 'https://i.imgur.com/kKc9A5p.jpeg'], 4.3, 98, false, true);

-- Shoes
INSERT INTO products (id, name, description, price, sale_price, category_id, brand_id, stock, thumbnail, images, rating, reviews_count, is_featured, is_active) VALUES
  ('a1000000-0000-0000-0000-000000000014', 'Purple Leather Loafers', 'Elegant leather loafers with premium craftsmanship. Perfect for formal and casual occasions.', 129.99, 99.99, 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 45, 'https://i.imgur.com/Au8J9sX.jpeg', ARRAY['https://i.imgur.com/Au8J9sX.jpeg', 'https://i.imgur.com/gdr8BW2.jpeg', 'https://i.imgur.com/KDCZxnJ.jpeg'], 4.6, 78, true, true),

  ('a1000000-0000-0000-0000-000000000015', 'Bold Orange & Blue Sneakers', 'Vibrant runners with cushioned sole and breathable mesh upper. Stand out on the track or street.', 89.99, NULL, 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 80, 'https://i.imgur.com/hKcMNJs.jpeg', ARRAY['https://i.imgur.com/hKcMNJs.jpeg', 'https://i.imgur.com/NYToymX.jpeg', 'https://i.imgur.com/HiiapCt.jpeg'], 4.7, 203, true, true),

  ('a1000000-0000-0000-0000-000000000016', 'Vibrant Pink Classic Sneakers', 'Eye-catching pink sneakers with classic design. Comfortable all-day wear with padded insole.', 79.99, 64.99, 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 65, 'https://i.imgur.com/mcW42Gi.jpeg', ARRAY['https://i.imgur.com/mcW42Gi.jpeg', 'https://i.imgur.com/mhn7qsF.jpeg', 'https://i.imgur.com/F8vhnFJ.jpeg'], 4.4, 167, false, true),

  ('a1000000-0000-0000-0000-000000000017', 'Denim Espadrille Sandals', 'Chic summer sandals with espadrille sole. Lightweight and perfect for beach or brunch.', 59.99, NULL, 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 100, 'https://i.imgur.com/9qrmE1b.jpeg', ARRAY['https://i.imgur.com/9qrmE1b.jpeg', 'https://i.imgur.com/wqKxBVH.jpeg', 'https://i.imgur.com/sWSV6DK.jpeg'], 4.5, 89, false, true),

  ('a1000000-0000-0000-0000-000000000018', 'Rainbow Glitter High Heels', 'Stunning glitter heels that sparkle with every step. Perfect for special occasions and nights out.', 149.99, 119.99, 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 35, 'https://i.imgur.com/62gGzeF.jpeg', ARRAY['https://i.imgur.com/62gGzeF.jpeg', 'https://i.imgur.com/5MoPuFM.jpeg', 'https://i.imgur.com/sUVj7pK.jpeg'], 4.8, 56, true, true),

  ('a1000000-0000-0000-0000-000000000019', 'Patent Leather Peep-Toe Pumps', 'Elegant patent leather pumps with comfortable block heel. Sophisticated style for any occasion.', 119.99, NULL, 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 50, 'https://i.imgur.com/AzAY4Ed.jpeg', ARRAY['https://i.imgur.com/AzAY4Ed.jpeg', 'https://i.imgur.com/umfnS9P.jpeg', 'https://i.imgur.com/uFyuvLg.jpeg'], 4.6, 112, false, true),

  ('a1000000-0000-0000-0000-000000000020', 'Holographic Soccer Cleats', 'Futuristic cleats with holographic finish. Lightweight design for speed and agility on the field.', 159.99, 129.99, 'c1000000-0000-0000-0000-000000000003', 'b1000000-0000-0000-0000-000000000003', 40, 'https://i.imgur.com/qNOjJje.jpeg', ARRAY['https://i.imgur.com/qNOjJje.jpeg', 'https://i.imgur.com/NjfCFnu.jpeg', 'https://i.imgur.com/eYtvXS1.jpeg'], 4.9, 45, true, true);

-- Furniture
INSERT INTO products (id, name, description, price, sale_price, category_id, brand_id, stock, thumbnail, images, rating, reviews_count, is_featured, is_active) VALUES
  ('a1000000-0000-0000-0000-000000000021', 'Ergonomic Office Chair', 'Modern ergonomic chair with lumbar support and adjustable height. Perfect for long work sessions.', 299.99, 249.99, 'c1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000004', 30, 'https://i.imgur.com/3dU0m72.jpeg', ARRAY['https://i.imgur.com/3dU0m72.jpeg', 'https://i.imgur.com/zPU3EVa.jpeg'], 4.7, 89, true, true),

  ('a1000000-0000-0000-0000-000000000022', 'Golden-Base Stone Top Dining Table', 'Elegant dining table with luxurious stone top and golden base. Statement piece for modern homes.', 899.99, NULL, 'c1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000004', 10, 'https://i.imgur.com/NWIJKUj.jpeg', ARRAY['https://i.imgur.com/NWIJKUj.jpeg', 'https://i.imgur.com/Jn1YSLk.jpeg', 'https://i.imgur.com/VNZRvx5.jpeg'], 4.9, 23, true, true),

  ('a1000000-0000-0000-0000-000000000023', 'Mid-Century Modern Wooden Dining Table', 'Classic wooden dining table with mid-century modern design. Seats 6 comfortably.', 599.99, 499.99, 'c1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000004', 15, 'https://i.imgur.com/DMQHGA0.jpeg', ARRAY['https://i.imgur.com/DMQHGA0.jpeg', 'https://i.imgur.com/qrs9QBg.jpeg', 'https://i.imgur.com/XVp8T1I.jpeg'], 4.6, 45, false, true),

  ('a1000000-0000-0000-0000-000000000024', 'Sleek Modern Leather Sofa', 'Contemporary leather sofa with clean lines and plush cushions. Perfect centerpiece for living rooms.', 1299.99, 1099.99, 'c1000000-0000-0000-0000-000000000004', 'b1000000-0000-0000-0000-000000000004', 8, 'https://i.imgur.com/Qphac99.jpeg', ARRAY['https://i.imgur.com/Qphac99.jpeg', 'https://i.imgur.com/dJjpEgG.jpeg', 'https://i.imgur.com/MxJyADq.jpeg'], 4.8, 67, true, true);

-- Accessories
INSERT INTO products (id, name, description, price, sale_price, category_id, brand_id, stock, thumbnail, images, rating, reviews_count, is_featured, is_active) VALUES
  ('a1000000-0000-0000-0000-000000000025', 'All-Terrain Go-Kart', 'Sleek go-kart for outdoor adventures. Durable construction with comfortable seating.', 499.99, 399.99, 'c1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000005', 12, 'https://i.imgur.com/Ex5x3IU.jpg', ARRAY['https://i.imgur.com/Ex5x3IU.jpg', 'https://i.imgur.com/z7wAQwe.jpg', 'https://i.imgur.com/kc0Dj9S.jpg'], 4.7, 34, true, true),

  ('a1000000-0000-0000-0000-000000000026', 'Olive Green Hardshell Carry-On Luggage', 'Sleek carry-on with durable hardshell design. TSA-approved locks and smooth-rolling wheels.', 189.99, 149.99, 'c1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000005', 40, 'https://i.imgur.com/jVfoZnP.jpg', ARRAY['https://i.imgur.com/jVfoZnP.jpg', 'https://i.imgur.com/Tnl15XK.jpg', 'https://i.imgur.com/7OqTPO6.jpg'], 4.6, 78, true, true),

  ('a1000000-0000-0000-0000-000000000027', 'Transparent Fashion Handbag', 'Chic transparent handbag with inner pouch. Trendy design perfect for summer outings.', 79.99, NULL, 'c1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000005', 55, 'https://i.imgur.com/Lqaqz59.jpg', ARRAY['https://i.imgur.com/Lqaqz59.jpg', 'https://i.imgur.com/uSqWK0m.jpg', 'https://i.imgur.com/atWACf1.jpg'], 4.4, 92, false, true),

  ('a1000000-0000-0000-0000-000000000028', 'Elegant Glass Tumbler Set', 'Set of 6 elegant glass tumblers with modern design. Perfect for entertaining or daily use.', 49.99, 39.99, 'c1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000005', 100, 'https://i.imgur.com/TF0pXdL.jpg', ARRAY['https://i.imgur.com/TF0pXdL.jpg', 'https://i.imgur.com/BLDByXP.jpg', 'https://i.imgur.com/b7trwCv.jpg'], 4.5, 156, false, true),

  ('a1000000-0000-0000-0000-000000000029', 'Futuristic Electric Bicycle', 'Sleek electric bicycle with powerful motor and long-range battery. Eco-friendly urban transportation.', 1499.99, 1299.99, 'c1000000-0000-0000-0000-000000000005', 'b1000000-0000-0000-0000-000000000005', 5, 'https://i.imgur.com/BG8J0Fj.jpg', ARRAY['https://i.imgur.com/BG8J0Fj.jpg', 'https://i.imgur.com/ujHBpCX.jpg', 'https://i.imgur.com/WHeVL9H.jpg'], 4.9, 28, true, true);

-- ==================== BANNERS ====================
INSERT INTO banners (id, image_url, title, subtitle, action_url, action_type, sort_order, is_active, start_date, end_date) VALUES
  ('ba100000-0000-0000-0000-000000000001', 'https://i.imgur.com/ItHcq7o.jpeg', 'New Tech Arrivals', 'Discover the latest electronics and gadgets', '/category/electronics', 'category', 1, true, NOW(), NOW() + INTERVAL '30 days'),

  ('ba100000-0000-0000-0000-000000000002', 'https://i.imgur.com/cHddUCu.jpeg', 'Winter Collection', 'Stay warm with our cozy hoodies and sweatshirts', '/category/clothes', 'category', 2, true, NOW(), NOW() + INTERVAL '30 days'),

  ('ba100000-0000-0000-0000-000000000003', 'https://i.imgur.com/hKcMNJs.jpeg', 'Step Into Style', 'New sneaker collection now available', '/category/shoes', 'category', 3, true, NOW(), NOW() + INTERVAL '30 days'),

  ('ba100000-0000-0000-0000-000000000004', 'https://i.imgur.com/Qphac99.jpeg', 'Home Makeover Sale', 'Up to 30% off on furniture', '/category/furniture', 'category', 4, true, NOW(), NOW() + INTERVAL '30 days'),

  ('ba100000-0000-0000-0000-000000000005', 'https://i.imgur.com/yVeIeDa.jpeg', 'Audio Excellence', 'Premium headphones starting at $79', '/product/a1000000-0000-0000-0000-000000000001', 'product', 5, true, NOW(), NOW() + INTERVAL '30 days');

-- ==================== COUPONS ====================
INSERT INTO coupons (id, code, description, discount_type, discount_value, min_order_amount, max_discount, usage_limit, used_count, is_active, starts_at, expires_at) VALUES
  ('ca100000-0000-0000-0000-000000000001', 'WELCOME10', 'Welcome discount for new users', 'percentage', 10, 50, 100, 1000, 0, true, NOW(), NOW() + INTERVAL '90 days'),

  ('ca100000-0000-0000-0000-000000000002', 'SAVE20', 'Save $20 on orders over $100', 'fixed', 20, 100, NULL, 500, 0, true, NOW(), NOW() + INTERVAL '60 days'),

  ('ca100000-0000-0000-0000-000000000003', 'FLASH25', 'Flash sale - 25% off everything', 'percentage', 25, 0, 50, 200, 0, true, NOW(), NOW() + INTERVAL '7 days');

-- ==================== SUMMARY ====================
-- Categories: 5
-- Brands: 5
-- Products: 29
-- Banners: 5
-- Coupons: 3
--
-- All images are real URLs from imgur.com (Platzi Fake Store API images)
-- These are freely available images for testing purposes
--
-- UUID Prefixes:
-- c1 = categories
-- b1 = brands
-- a1 = products (changed from p1 - invalid hex)
-- ba = banners
-- ca = coupons
