CREATE OR REPLACE VIEW Locations_with_settlements_regions_countries ( id, street, building_number, postal_code, settlement, region, country ) AS
SELECT l.id, l.street, l.building_number, l.postal_code, s.name AS "settlement", r.name AS "region", c.name AS "country" 
FROM Locations l 
INNER JOIN Settlements s 
	ON l.settlement_id=s.id 
INNER JOIN Regions r 
	ON s.region_id=r.id 
INNER JOIN Countries c 
	ON r.country_id=c.id
;


CREATE OR REPLACE VIEW  User_count_by_settlement ( settlement, number_of_users ) AS
SELECT s.name AS "settlement", COUNT(*) AS "number_of_users"
FROM Users u
INNER JOIN Locations l
	ON u.home_location_id=l.id
INNER JOIN Settlements s
	ON l.settlement_id=s.id
GROUP BY 
s.name
ORDER BY 
s.name 
ASC 
;


CREATE OR REPLACE VIEW User_function_counts ( user_function, number_of_users_with_this_function ) AS
SELECT 'Costumiers' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Costumiers
UNION
SELECT 'Singers' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Singers
UNION
SELECT 'Musicians' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Musicians
UNION
SELECT 'Dancers' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Dancers
;

CREATE OR REPLACE VIEW Detailed_users ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, singer_role, musician_role, dancer_role, costumier_role, costumier_work_address_street, costumier_work_address_building_number, costumier_work_address_postal_code, costumier_work_address_settlement, costumier_work_address_region, costumier_work_address_country ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, sr.name AS "singer_role", mr.name AS "musician_role", dr.name AS "dancer_role", cr.name AS "costumier_role", w.street AS "costumier_work_address_street", w.building_number AS "costumier_work_address_building_number", w.postal_code AS "costumier_work_address_postal_code", w.settlement AS "costumier_work_address_settlement", w.region AS "costumier_work_address_region", w.country AS "costumier_work_address_country"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
LEFT JOIN Singers s
	ON u.id=s.user_id
LEFT JOIN Roles sr
	ON s.role_id=sr.id
LEFT JOIN Musicians m
	ON u.id=m.user_id
LEFT JOIN Roles mr
	ON m.role_id=mr.id
LEFT JOIN Dancers d
	ON u.id=d.user_id
LEFT JOIN Roles dr
	ON d.role_id=dr.id
LEFT JOIN Costumiers c
	ON u.id=c.user_id
LEFT JOIN Roles cr
	ON c.role_id=cr.id
LEFT JOIN Locations_with_settlements_regions_countries w
	ON c.work_location_id=w.id 
;


CREATE OR REPLACE VIEW Detailed_singers ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, role, voices ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, sr.name AS "role", STRING_AGG(tov.name, ', ') AS "voices"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
INNER JOIN Singers s
	ON u.id=s.user_id
INNER JOIN Roles sr
	ON s.role_id=sr.id
INNER JOIN Singer_voices sv
	ON s.user_id=sv.singer_id
INNER JOIN Types_of_voices tov
	ON sv.type_of_voice_id=tov.id
GROUP BY
	u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name, l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, sr.name
ORDER BY
	u.last_name, u.first_name
ASC 
;


CREATE OR REPLACE VIEW Detailed_musicians ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, role, instruments ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, mr.name AS "role", STRING_AGG(toi.name, ', ') AS "instruments"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
INNER JOIN Musicians m
	ON u.id=m.user_id
INNER JOIN Roles mr
	ON m.role_id=mr.id
INNER JOIN Musician_instrument mi
	ON m.user_id=mi.musician_id
INNER JOIN Types_of_instruments toi
	ON mi.type_of_instrument_id=toi.id
GROUP BY
	u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name, l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, mr.name
ORDER BY
	u.last_name, u.first_name
ASC 
;


CREATE OR REPLACE VIEW Detailed_dancers ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, role, dances ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, dr.name AS "role", STRING_AGG(dan.name, ', ') AS "dances"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
INNER JOIN Dancers d
	ON u.id=d.user_id
INNER JOIN Roles dr
	ON d.role_id=dr.id
INNER JOIN Dancer_dance dd
	ON d.user_id=dd.dancer_id
INNER JOIN Dances dan
	ON dd.dance_id=dan.id
GROUP BY
	u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name, l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, dr.name
ORDER BY
	u.last_name, u.first_name
ASC 
;


CREATE OR REPLACE VIEW Singer_count_by_voice_type ( type_of_voice, number_of_singers ) AS
SELECT tov.name AS "type_of_voice", COUNT(*) AS "number_of_singers"
FROM Singer_voices sv
INNER JOIN Types_of_voices tov
	ON sv.type_of_voice_id=tov.id
GROUP BY
	tov.name
ORDER BY
	tov.name
ASC 
;


CREATE OR REPLACE VIEW Musician_count_by_instrument_type ( type_of_instrument, number_of_musicians ) AS
SELECT toi.name AS "type_of_instrument", COUNT(*) AS "number_of_musicians"
FROM Musician_instrument mi
INNER JOIN Types_of_instruments toi
	ON mi.type_of_instrument_id=toi.id
GROUP BY
	toi.name
ORDER BY
	toi.name
ASC 
;


CREATE OR REPLACE VIEW Dancer_count_by_dance_type ( type_of_dance, number_of_dancers ) AS
SELECT d.name AS "type_of_dance", COUNT(*) AS "number_of_dancers"
FROM Dancer_dance dd
INNER JOIN Dances d
	ON dd.dance_id=d.id
GROUP BY
	d.name
ORDER BY
	d.name
ASC 
;


CREATE OR REPLACE VIEW Costume_item_count_by_collection_and_class ( costume_item_class, collection, number_of_items) AS
(SELECT 'apron' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Aprons type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'caftan' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Caftans type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'petticoat' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Petticoats type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'corset' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Corsets type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'skirt' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Skirts type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'belt' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Belts type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'shirt' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Shirts type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'pants' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Pants type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'boots' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Boots type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'neck_accessory' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Neck_accessories type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'head_accessory' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Head_accessories type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC) 
;


CREATE OR REPLACE VIEW Costume_item_count_by_class ( costume_item_class, number_of_items) AS
(SELECT 'apron' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Aprons)
UNION
(SELECT 'caftan' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Caftans)
UNION
(SELECT 'petticoat' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Petticoats)
UNION
(SELECT 'corset' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Corsets)
UNION
(SELECT 'skirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Skirts)
UNION
(SELECT 'belt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Belts)
UNION
(SELECT 'shirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Shirts)
UNION
(SELECT 'pants' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Pants)
UNION
(SELECT 'boots' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Boots)
UNION
(SELECT 'neck_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Neck_accessories)
UNION
(SELECT 'head_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Head_accessories) 
;


CREATE OR REPLACE VIEW Detailed_aprons ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, pattern ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, a.length, p.name AS "pattern"
FROM Aprons a
INNER JOIN Costumes_items ci
	ON a.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
INNER JOIN Patterns p
	ON a.pattern_id=p.id 
;




CREATE OR REPLACE VIEW Detailed_boots ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, shoe_size ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, b.shoe_size
FROM Boots b
INNER JOIN Costumes_items ci
	ON b.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;



CREATE OR REPLACE VIEW Detailed_petticoats ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, p.length, p.min_waist_circumference, p.max_waist_circumference
FROM Petticoats p
INNER JOIN Costumes_items ci
	ON p.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;




CREATE OR REPLACE VIEW Detailed_skirts ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, s.length, s.min_waist_circumference, s.max_waist_circumference
FROM Skirts s
INNER JOIN Costumes_items ci
	ON s.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;




CREATE OR REPLACE VIEW Detailed_caftans ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference, min_chest_circumference, max_chest_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, c.length, c.min_waist_circumference, c.max_waist_circumference, c.min_chest_circumference, c.max_chest_circumference
FROM Caftans c
INNER JOIN Costumes_items ci
	ON c.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;


CREATE OR REPLACE VIEW Detailed_corsets ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference, min_chest_circumference, max_chest_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, c.length, c.min_waist_circumference, c.max_waist_circumference, c.min_chest_circumference, c.max_chest_circumference
FROM Corsets c
INNER JOIN Costumes_items ci
	ON c.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;


CREATE OR REPLACE VIEW Detailed_neck_accessories ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, min_neck_circumference, max_neck_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, na.min_neck_circumference, na.max_neck_circumference
FROM Neck_accessories na
INNER JOIN Costumes_items ci
	ON na.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;



CREATE OR REPLACE VIEW Detailed_head_accessories ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, head_circumference, category ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, ha.head_circumference, hac.name AS "category"
FROM Head_accessories ha
INNER JOIN Costumes_items ci
	ON ha.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
INNER JOIN Head_accessory_categories hac
	ON ha.category_id=hac.id 
;



CREATE OR REPLACE VIEW Detailed_belts ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, b.min_waist_circumference, b.max_waist_circumference
FROM Belts b
INNER JOIN Costumes_items ci
	ON b.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;



CREATE OR REPLACE VIEW Detailed_pants ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, p.length, p.min_waist_circumference, p.max_waist_circumference
FROM Pants p
INNER JOIN Costumes_items ci
	ON p.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;



CREATE OR REPLACE VIEW Detailed_shirts ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference, min_chest_circumference, max_chest_circumference, min_neck_circumference, max_neck_circumference, arm_length ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, s.length, s.min_waist_circumference, s.max_waist_circumference, s.min_chest_circumference, s.max_chest_circumference, s.min_neck_circumference, s.max_neck_circumference, s.arm_length
FROM Shirts s
INNER JOIN Costumes_items ci
	ON s.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id 
;



CREATE OR REPLACE VIEW Costume_with_costume_items_name ( id, name, collection, gender, apron, caftan, petticoate, corset, skirt, belt, shirt, pants, boots, neck_accessory, head_accessory ) AS
SELECT c.id, c.name, col.name AS "collection", g.name AS "gender", COALESCE(a.name, 'N/A') AS "apron", COALESCE(ca.name, 'N/A') AS "caftan", COALESCE(p.name, 'N/A') AS "petticoate", COALESCE(co.name, 'N/A') AS "corset", COALESCE(sk.name, 'N/A') AS "skirt", COALESCE(b.name, 'N/A') AS "belt", COALESCE(sh.name, 'N/A') AS "shirt", COALESCE(pa.name, 'N/A') AS "pants", COALESCE(bo.name, 'N/A') AS "boots", COALESCE(ne.name, 'N/A') AS "neck_accessory", COALESCE(h.name, 'N/A') AS "head_accessory"
FROM Costumes c
INNER JOIN Collections col
	ON c.collection_id=col.id
INNER JOIN Genders g
	ON c.gender_id=g.id 
INNER JOIN Aprons ia
	ON c.apron_id=ia.costume_item_id
INNER JOIN Costumes_items a
	ON ia.costume_item_id=a.id
INNER JOIN Caftans ica
	ON c.caftan_id=ica.costume_item_id
INNER JOIN Costumes_items ca
	ON ica.costume_item_id=a.id
INNER JOIN Petticoats ip
	ON c.petticoat_id=ip.costume_item_id
INNER JOIN Costumes_items p
	ON ip.costume_item_id=p.id
INNER JOIN Corsets ico
	ON c.corset_id=ico.costume_item_id
INNER JOIN Costumes_items co
	ON ico.costume_item_id=co.id
INNER JOIN Skirts isk
	ON c.skirt_id=isk.costume_item_id
INNER JOIN Costumes_items sk
	ON isk.costume_item_id=sk.id
INNER JOIN Belts ib
	ON c.belt_id=ib.costume_item_id
INNER JOIN Costumes_items b
	ON ib.costume_item_id=b.id
INNER JOIN Shirts ish
	ON c.shirt_id=ish.costume_item_id
INNER JOIN Costumes_items sh
	ON ish.costume_item_id=sh.id
INNER JOIN Pants ipa
	ON c.pants_id=ipa.costume_item_id
INNER JOIN Costumes_items pa
	ON ipa.costume_item_id=pa.id
INNER JOIN Boots ibo
	ON c.boots_id=ibo.costume_item_id
INNER JOIN Costumes_items bo
	ON ibo.costume_item_id=bo.id
INNER JOIN Neck_accessories ine
	ON c.neck_accessory_id=ine.costume_item_id
INNER JOIN Costumes_items ne
	ON ine.costume_item_id=ne.id
INNER JOIN Head_accessories ih
	ON c.head_accessory_id=ih.costume_item_id
INNER JOIN Costumes_items h
	ON ih.costume_item_id=h.id 
;


CREATE OR REPLACE VIEW Not_read_notifications ( id, user_id, content, datetime, due_to_request_id ) AS
SELECT id, user_id, content, datetime, due_to_request_id
FROM Notifications
WHERE marked_as_read = 'F' 
;


CREATE OR REPLACE VIEW Detaild_rental_costume_item_requests ( id, datetime, requester_user_id, state, costume_item_id, approver_costumier_id ) AS
SELECT r.id, r.datetime, r.requester_user_id, s.name AS "state", rr.costume_item_id, rr.approver_costumier_id
FROM Rental_costume_item_requests rr
INNER JOIN Requests r
	ON rr.request_id=r.id 
INNER JOIN States_of_requests s
	ON r.state_id=s.id
;


CREATE OR REPLACE VIEW Detaild_return_costume_item_requests ( id, datetime, requester_user_id, state, costume_item_id, approver_costumier_id ) AS
SELECT r.id, r.datetime, r.requester_user_id, s.name AS "state", rr.costume_item_id, rr.approver_costumier_id
FROM Return_costume_item_requests rr
INNER JOIN Requests r
	ON rr.request_id=r.id 
INNER JOIN States_of_requests s
	ON r.state_id=s.id
;


CREATE OR REPLACE VIEW Detaild_borrow_costume_item_requests ( id, datetime, requester_user_id, state, costume_item_id, approver_user_id ) AS
SELECT r.id, r.datetime, r.requester_user_id, s.name AS "state", rr.costume_item_id, rr.approver_user_id
FROM Borrow_costume_item_requests rr
INNER JOIN Requests r
	ON rr.request_id=r.id
INNER JOIN States_of_requests s
	ON r.state_id=s.id
;


CREATE OR REPLACE VIEW Detaild_costume_item_requests ( id, datetime, type, requester_user_id, state, costume_item_id, approver_id ) AS
(SELECT d.id, d.datetime, 'RENTAL' AS "type", d.requester_user_id, d.state, d.costume_item_id, d.approver_costumier_id
FROM Detaild_rental_costume_item_requests d)
UNION
(SELECT d.id, d.datetime, 'RETURN' AS "type", d.requester_user_id, d.state, d.costume_item_id, d.approver_costumier_id
FROM Detaild_return_costume_item_requests d)
UNION
(SELECT d.id, d.datetime, 'BORROW' AS "type", d.requester_user_id, d.state, d.costume_item_id, d.approver_user_id
FROM Detaild_borrow_costume_item_requests d)
;


CREATE OR REPLACE VIEW Current_rentals_count_by_costume_item_class ( costume_item_class, number_of_rent_items ) AS
SELECT * 
FROM ((SELECT 'apron' AS "costume_item_class", COUNT(*) AS "number_of_rent_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Aprons))
UNION
(SELECT 'caftan' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Caftans))
UNION
(SELECT 'petticoat' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Petticoats))
UNION
(SELECT 'corset' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Corsets))
UNION
(SELECT 'skirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Skirts))
UNION
(SELECT 'belt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Belts))
UNION
(SELECT 'shirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Shirts))
UNION
(SELECT 'pants' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Pants))
UNION
(SELECT 'boots' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Boots))
UNION
(SELECT 'neck_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Neck_accessories))
UNION
(SELECT 'head_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Head_accessories))) t
ORDER BY 
    t.costume_item_class 
ASC
;



CREATE OR REPLACE VIEW Current_rentals_count_by_user_function ( costume_item_class, number_of_rent_items ) AS 
SELECT *  
FROM ((SELECT 'costumier' AS "user_function", COUNT(*) AS "number_of_items" 
FROM Rentals 
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Costumiers)) 
UNION 
(SELECT 'singer' AS "user_function", COUNT(*) AS "number_of_items" 
FROM Rentals 
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Singers)) 
UNION 
(SELECT 'musician' AS "user_function", COUNT(*) AS "number_of_items" 
FROM Rentals 
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Musicians)) 
UNION 
(SELECT 'dancer' AS "user_function", COUNT(*) AS "number_of_items" 
FROM Rentals 
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Dancers))) t 
ORDER BY  
	t.user_function 
ASC 
; 


CREATE OR REPLACE VIEW Detailed_rentals ( id, user_id, user_first_name, user_last_name, costume_item_id, costume_item_name, done_due_request_id, date_of_rental, date_of_return ) AS
SELECT r.id, r.user_id, u.first_name AS "user_first_name", u.last_name AS "user_last_name", r.costume_item_id, ci.name AS "costume_item_name", r.done_due_request_id, r.date_of_rental, r.date_of_return
FROM Rentals r
INNER JOIN Users u
	ON r.user_id = u.id
INNER JOIN Costumes_items ci
	ON r.costume_item_id = ci.id
;


CREATE OR REPLACE VIEW Detailed_current_rentals ( id, user_id, user_first_name, user_last_name, costume_item_id, costume_item_name, done_due_request_id, date_of_rental, date_of_return ) AS
SELECT d.id, d.user_id, d.user_first_name, d.user_last_name, d.costume_item_id, d.costume_item_name, d.done_due_request_id, d.date_of_rental, d.date_of_return
FROM Detailed_rentals d
WHERE d.date_of_return IS NULL
ORDER BY
	d.date_of_rental
ASC
;