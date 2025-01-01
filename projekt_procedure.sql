CREATE OR REPLACE PROCEDURE add_country(
    p_country_name VARCHAR(30)
) AS $$
BEGIN
    IF p_country_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_country_name) > 30 OR LENGTH(p_country_name) < 1 THEN
		RAISE EXCEPTION 'Country name can have between 1 and 30 characters';
	END IF;
	
	PERFORM 1
	FROM Countries
	WHERE
		name = p_country_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Country already exist';
	END IF;
	
	BEGIN
		INSERT INTO Countries (name)
		VALUES (p_country_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_region(
    p_region_name VARCHAR(30),
	p_country_id SMALLINT
) AS $$
BEGIN
    IF p_region_name IS NULL OR p_country_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_region_name) > 30 OR LENGTH(p_region_name) < 1 THEN
		RAISE EXCEPTION 'Region name can have between 1 and 30 characters';
	END IF;

	PERFORM 1
	FROM Countries
	WHERE
		id = p_country_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Country with id % does not exist', p_country_id;
	END IF;
	
	PERFORM 1
	FROM Regions
	WHERE
		name = p_region_name AND country_id = p_country_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Region % in country with id % already exist', p_region_name, p_country_id;
	END IF;
	
	BEGIN
		INSERT INTO Regions (name, country_id)
		VALUES (p_region_name, p_country_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_settlement(
    p_settlement_name VARCHAR(30),
	p_region_id SMALLINT
) AS $$
BEGIN
    IF p_settlement_name IS NULL OR p_region_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_settlement_name) > 30 OR LENGTH(p_settlement_name) < 1 THEN
		RAISE EXCEPTION 'Settlement name can have between 1 and 30 characters';
	END IF;

	PERFORM 1
	FROM Regions
	WHERE
		id = p_region_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Region with id % does not exist', p_region_id;
	END IF;
	
	PERFORM 1
	FROM Settlements
	WHERE
		name = p_settlement_name AND region_id = p_region_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Settlement % in region with id % already exist', p_settlement_name, p_region_id;
	END IF;
	
	BEGIN
		INSERT INTO Settlements (name, region_id)
		VALUES (p_settlement_name, p_region_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_location(
    p_location_street VARCHAR(30),
	p_location_building_number SMALLINT,
    p_location_postal_code VARCHAR(10),
    p_settlement_id SMALLINT
) AS $$
BEGIN
    IF p_location_street IS NULL OR 
    p_location_building_number IS NULL OR 
    p_location_postal_code IS NULL OR 
    p_settlement_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_location_street) > 30 OR LENGTH(p_location_street) < 1 THEN
		RAISE EXCEPTION 'Street name can have between 1 and 30 characters';
	END IF;

    IF LENGTH(p_location_postal_code) > 10 OR LENGTH(p_location_postal_code) < 1 THEN
		RAISE EXCEPTION 'Postal code can have between 1 and 10 characters';
	END IF;

	PERFORM 1
	FROM Settlements
	WHERE
		id = p_settlement_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Settlement with id % does not exist', p_settlement_id;
	END IF;
	
	PERFORM 1
	FROM Locations
	WHERE
		street = p_location_street AND building_number = p_location_building_number AND postal_code = p_location_postal_code AND settlement_id = p_settlement_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Location: %, %, %, in sattlement with id % already exist', p_location_street, p_location_building_number, p_location_postal_code, p_settlement_id;
	END IF;
	
	BEGIN
		INSERT INTO Locations (street, building_number, postal_code, settlement_id)
		VALUES (p_location_street, p_location_building_number, p_location_postal_code, p_settlement_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_gender(
    p_gender_name VARCHAR(25)
) AS $$
BEGIN
    IF p_gender_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_gender_name) > 25 OR LENGTH(p_gender_name) < 1 THEN
		RAISE EXCEPTION 'Gender name can have between 1 and 25 characters';
	END IF;
	
	PERFORM 1
	FROM Genders
	WHERE
		name = p_gender_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Gender already exist';
	END IF;
	
	BEGIN
		INSERT INTO Genders (name)
		VALUES (p_gender_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_role(
    p_role_name VARCHAR(20)
) AS $$
BEGIN
    IF p_role_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF LENGTH(p_role_name) > 20 OR LENGTH(p_role_name) < 1 THEN
        RAISE EXCEPTION 'Role name can have between 1 and 20 characters';
    END IF;
    
    PERFORM 1
    FROM Roles
    WHERE
        name = p_role_name;

    IF FOUND THEN
        RAISE EXCEPTION 'Role already exist';
    END IF;
    
    BEGIN
        INSERT INTO Roles (name)
        VALUES (p_role_name);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_type_of_voice(
    p_type_of_voice_name VARCHAR(10)
) AS $$
BEGIN
    IF p_type_of_voice_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_type_of_voice_name) > 10 OR LENGTH(p_type_of_voice_name) < 1 THEN
		RAISE EXCEPTION 'Type of voice name can have between 1 and 10 characters';
	END IF;
	
	PERFORM 1
	FROM Types_of_voices
	WHERE
		name = p_type_of_voice_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Type of voice already exist';
	END IF;
	
	BEGIN
		INSERT INTO Types_of_voices (name)
		VALUES (p_type_of_voice_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE add_type_of_instrument(
    p_type_of_instrument_name VARCHAR(20)
) AS $$
BEGIN
    IF p_type_of_instrument_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_type_of_instrument_name) > 20 OR LENGTH(p_type_of_instrument_name) < 1 THEN
		RAISE EXCEPTION 'Type of instrument name can have between 1 and 20 characters';
	END IF;
	
	PERFORM 1
	FROM Types_of_instruments
	WHERE
		name = p_type_of_instrument_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Type of instrument already exist';
	END IF;
	
	BEGIN
		INSERT INTO Types_of_instruments (name)
		VALUES (p_type_of_instrument_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_dance(
    p_dance_name VARCHAR(20)
) AS $$
BEGIN
    IF p_dance_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_dance_name) > 20 OR LENGTH(p_dance_name) < 1 THEN
		RAISE EXCEPTION 'Dance name can have between 1 and 20 characters';
	END IF;
	
	PERFORM 1
	FROM Dances
	WHERE
		name = p_dance_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Dance already exist';
	END IF;
	
	BEGIN
		INSERT INTO Dances (name)
		VALUES (p_dance_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_color(
    p_color_name VARCHAR(25)
) AS $$
BEGIN
    IF p_color_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_color_name) > 25 OR LENGTH(p_color_name) < 1 THEN
		RAISE EXCEPTION 'Color name can have between 1 and 25 characters';
	END IF;
	
	PERFORM 1
	FROM Colors
	WHERE
		name = p_color_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Color already exist';
	END IF;
	
	BEGIN
		INSERT INTO Colors (name)
		VALUES (p_color_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_collection(
    p_collection_name VARCHAR(20)
) AS $$
BEGIN
    IF p_collection_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_collection_name) > 20 OR LENGTH(p_collection_name) < 1 THEN
		RAISE EXCEPTION 'Collection name can have between 1 and 20 characters';
	END IF;
	
	PERFORM 1
	FROM Collections
	WHERE
		name = p_collection_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Collection already exist';
	END IF;
	
	BEGIN
		INSERT INTO Collections (name)
		VALUES (p_collection_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_pattern(
    p_pattern_name VARCHAR(20)
) AS $$
BEGIN
    IF p_pattern_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_pattern_name) > 20 OR LENGTH(p_pattern_name) < 1 THEN
		RAISE EXCEPTION 'Pattern name can have between 1 and 20characters';
	END IF;
	
	PERFORM 1
	FROM Patterns
	WHERE
		name = p_pattern_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Pattern already exist';
	END IF;
	
	BEGIN
		INSERT INTO Patterns (name)
		VALUES (p_pattern_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_head_accessory_category(
    p_head_accessory_category_name VARCHAR(20)
) AS $$
BEGIN
    IF p_head_accessory_category_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF LENGTH(p_head_accessory_category_name) > 20 OR LENGTH(p_head_accessory_category_name) > 20 THEN
        RAISE EXCEPTION 'Head accessory category name can have between 1 and 20 characters';
    END IF;
    
    PERFORM 1
    FROM Head_accessory_categories
    WHERE
        name = p_head_accessory_category_name;

    IF FOUND THEN
        RAISE EXCEPTION 'Head accessory category already exist';
    END IF;
    
    BEGIN
        INSERT INTO Head_accessory_categories (name)
        VALUES (p_head_accessory_category_name);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_state_of_request(
    p_state_of_request_name VARCHAR(15)
) AS $$
BEGIN
    IF p_state_of_request_name IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_state_of_request_name) > 15 OR LENGTH(p_state_of_request_name) < 1 THEN
		RAISE EXCEPTION 'State of request name can have between 1 and 15 characters';
	END IF;
	
	PERFORM 1
	FROM States_of_requests
	WHERE
		name = p_state_of_request_name;

	IF FOUND THEN
		RAISE EXCEPTION 'State of request already exist';
	END IF;
	
	BEGIN
		INSERT INTO States_of_requests (name)
		VALUES (p_state_of_request_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE add_user(
    p_user_first_name          VARCHAR (25), 
    p_user_last_name           VARCHAR (30), 
    p_user_date_of_birth       DATE, 
    p_user_email               VARCHAR (50), 
    p_user_phone_number        VARCHAR (12), 
    p_gender_id           SMALLINT, 
    p_home_location_id    SMALLINT, 
    p_user_height              SMALLINT, 
    p_user_waist_circumference SMALLINT, 
    p_user_chest_circumference SMALLINT, 
    p_user_head_circumference  SMALLINT, 
    p_user_neck_circumference  SMALLINT, 
    p_user_leg_length          SMALLINT, 
    p_user_arm_length          SMALLINT, 
    p_user_torso_length        SMALLINT, 
    p_user_shoe_size           FLOAT
) AS $$
BEGIN
    IF p_user_first_name IS NULL OR 
    p_user_last_name IS NULL OR 
    p_user_date_of_birth IS NULL OR 
    p_user_email IS NULL OR 
    p_user_phone_number IS NULL OR 
    p_gender_id IS NULL OR 
    p_home_location_id IS NULL OR 
    p_user_height IS NULL OR 
    p_user_waist_circumference IS NULL OR 
    p_user_chest_circumference IS NULL OR 
    p_user_head_circumference IS NULL OR 
    p_user_neck_circumference IS NULL OR 
    p_user_leg_length IS NULL OR 
    p_user_arm_length IS NULL OR 
    p_user_torso_length IS NULL OR 
    p_user_shoe_size IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_user_first_name) > 25 OR LENGTH(p_user_first_name) < 1 THEN
		RAISE EXCEPTION 'First name can have between 1 and 25 characters';
	END IF;
	
    IF LENGTH(p_user_last_name) > 30 OR LENGTH(p_user_last_name) < 1 THEN
		RAISE EXCEPTION 'Last name can have between 1 and 30 characters';
	END IF;
	
    IF LENGTH(p_user_email) > 50 OR p_user_email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' THEN
		RAISE EXCEPTION 'Wrong email format. min characters - 5, max characters - 50';
	END IF;
	
    IF LENGTH(p_user_phone_number) > 12 OR p_user_phone_number ~* '^\+?[0-9]{7,9}$' THEN
		RAISE EXCEPTION 'Wrong phone number format, max characters - 12';
	END IF;

     IF p_user_height <= 0 THEN
		RAISE EXCEPTION 'Height must be greater than 0';
    END IF;

    IF p_user_waist_circumference <= 0 THEN
		RAISE EXCEPTION 'Waist circumference must be greater than 0';
    END IF;

    IF p_user_chest_circumference <= 0 THEN
		RAISE EXCEPTION 'Chest circumference must be greater than 0';
    END IF;

    IF p_user_head_circumference <= 0 THEN
		RAISE EXCEPTION 'Head circumference must be greater than 0';
    END IF;

    IF p_user_neck_circumference <= 0 THEN
		RAISE EXCEPTION 'Neck circumference must be greater than 0';
    END IF;

    IF p_user_leg_length <= 0 THEN
		RAISE EXCEPTION 'Leg length must be greater than 0';
    END IF;

    IF p_user_arm_length <= 0 THEN
		RAISE EXCEPTION 'Arm length must be greater than 0';
    END IF;

    IF p_user_torso_length <= 0 THEN
		RAISE EXCEPTION 'Torso length must be greater than 0';
    END IF;

    IF p_user_leg_length >= p_user_height THEN
		RAISE EXCEPTION 'Leg length cannot be greater than height';
    END IF;

    IF p_user_arm_length >= p_user_height THEN
		RAISE EXCEPTION 'Arm length cannot be greater than height';
    END IF;

    IF p_user_torso_length >= p_user_height THEN
		RAISE EXCEPTION 'Torso length cannot be greater than height';
    END IF;

    IF p_user_shoe_size <= 0 THEN
		RAISE EXCEPTION 'Shoe size must be greater than 0';
    END IF;

    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_home_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_home_location_id;
	END IF;
	
	PERFORM 1
	FROM Users
	WHERE
		email = p_user_email;

	IF FOUND THEN
		RAISE EXCEPTION 'User with email % already exist', p_user_email;
	END IF;
	
	BEGIN
		INSERT INTO Users (first_name, last_name, date_of_birth, email, phone_number, gender_id, home_location_id,
        height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length,
        torso_length, shoe_size)
		VALUES (p_user_first_name, p_user_last_name, p_user_date_of_birth, p_user_email, p_user_phone_number, 
        p_gender_id, p_home_location_id, p_user_height, p_user_waist_circumference, p_user_chest_circumference, 
        p_user_head_circumference, p_user_neck_circumference, p_user_leg_length, p_user_arm_length,
        p_user_torso_length, p_user_shoe_size);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_costumier(
    p_user_id INT,
    p_role_id SMALLINT,
    p_work_location_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR 
    p_role_id IS NULL OR 
    p_work_location_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_region_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_work_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_work_location_id;
	END IF;
	
    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is costumier', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Costumiers (user_id, role_id, work_location_id)
		VALUES (p_user_id, p_role_id, p_work_location_id);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_singer(
    p_user_id INT,
    p_role_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR 
    p_role_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_region_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;
	
    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Singers
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is singer', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Singers (user_id, role_id)
		VALUES (p_user_id, p_role_id);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_musician(
    p_user_id INT,
    p_role_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR 
    p_role_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_region_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;
	
    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Musicians
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is musician', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Musicians (user_id, role_id)
		VALUES (p_user_id, p_role_id);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_dancer(
    p_user_id INT,
    p_role_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR 
    p_role_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_region_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;
	
    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Dancers
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is dancer', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Dancers (user_id, role_id)
		VALUES (p_user_id, p_role_id);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_voice_to_singer(
    p_singer_id INT,
    p_type_of_voice_id SMALLINT
) AS $$
BEGIN
    IF p_singer_id IS NULL OR 
    p_type_of_voice_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Types_of_voices
	WHERE
		id = p_type_of_voice_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Type of voice with id % does not exist', p_type_of_voice_id;
	END IF;
	
    PERFORM 1
	FROM Singers
	WHERE
		user_id = p_singer_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Singer with id % does not exist', p_singer_id;
	END IF;

    PERFORM 1
	FROM Singer_voices
	WHERE
		singer_id = p_user_id AND type_of_voice_id = p_type_of_voice_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Singer with id % can sing with voice of id %', p_singer_id, p_type_of_voice_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Singers WHERE user_id = p_singer_id FOR UPDATE;

		INSERT INTO Singer_voices (singer_id, type_of_voice_id)
		VALUES (p_singer_id, p_type_of_voice_id);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_instrument_to_musician(
    p_musician_id INT,
    p_type_of_instrument_id SMALLINT
) AS $$
BEGIN
    IF p_musician_id IS NULL OR 
    p_type_of_instrument_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Types_of_instruments
	WHERE
		id = p_type_of_instrument_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Type of instrument with id % does not exist', p_type_of_instrument_id;
	END IF;
	
    PERFORM 1
	FROM Musicians
	WHERE
		user_id = p_musician_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Musician with id % does not exist', p_musician_id;
	END IF;

    PERFORM 1
	FROM Musician_instrument
	WHERE
		musician_id = p_musician_id AND type_of_instrument_id = p_type_of_instrument_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Musician with id % can paly on instrument with id %', p_musician_id, p_type_of_instrument_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Musicians WHERE user_id = p_singer_id FOR UPDATE;

		INSERT INTO Musician_instrument (musician_id, type_of_instrument_id)
		VALUES (p_musician_id, p_type_of_instrument_id);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_dance_to_dancer(
    p_dancer_id INT,
    p_dance_id SMALLINT
) AS $$
BEGIN
    IF p_dancer_id IS NULL OR 
    p_dance_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Dances
	WHERE
		id = p_dance_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Dance with id % does not exist', p_dance_id;
	END IF;
	
    PERFORM 1
	FROM Dancers
	WHERE
		user_id = p_dancer_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Dancer with id % does not exist', p_dancer_id;
	END IF;

    PERFORM 1
	FROM Dancer_dance
	WHERE
		dancer_id = p_dancer_id AND dance_id = p_dance_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Dancer with id % can dance dance with id %', p_dancer_id, p_dance_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Dancers WHERE user_id = p_dancer_id FOR UPDATE;

		INSERT INTO Dancer_dance (dancer_id, dance_id)
		VALUES (p_dancer_id, p_dance_id);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_apron(
    p_apron_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_apron_length SMALLINT,
    p_pattern_id SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_apron_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_apron_length IS NULL OR 
    p_pattern_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_apron_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF LENGTH(p_apron_name) > 30 OR LENGTH(p_apron_name) < 1 THEN
        RAISE EXCEPTION 'Apron name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_apron_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Apron with name % already exist', p_apron_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_apron_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Aprons (costume_item_id, length, pattern_id)
		VALUES (i_id, p_apron_length, p_pattern_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_head_accessory(
    p_head_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_head_accessory_head_circumference SMALLINT,
    p_category_id SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_head_accessory_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR  
    p_category_id IS NULL THEN 
        RAISE EXCEPTION 'Only head circumference parameter can be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    PERFORM 1
	FROM Head_accessory_categories
	WHERE
		id = p_category_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Head accessory category with id % does not exist', p_category_id;
	END IF;

    IF p_head_accessory_head_circumference IS NOT NULL AND p_head_accessory_head_circumference <= 0 THEN
        RAISE EXCEPTION 'Head circumference must be greater than 0';
    END IF;

    IF LENGTH(p_head_accessory_name) > 30 OR LENGTH(p_head_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Head accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_head_accessory_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Head accessory with name % already exist', p_head_accessory_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_head_accessory_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Head_accessories (costume_item_id, category_id, head_circumference)
		VALUES (i_id, p_category_id, p_head_accessory_head_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_caftan(
    p_caftan_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_caftan_length SMALLINT,
    p_caftan_min_waist_circumference SMALLINT,
    p_caftan_max_waist_circumference SMALLINT,
    p_caftan_min_chest_circumference SMALLINT,
    p_caftan_max_chest_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_caftan_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_caftan_length IS NULL OR 
    p_caftan_min_waist_circumference IS NULL OR 
    p_caftan_max_waist_circumference IS NULL OR 
    p_caftan_min_chest_circumference IS NULL OR 
    p_caftan_max_chest_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_caftan_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_caftan_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_caftan_max_waist_circumference < p_caftan_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_caftan_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_caftan_max_chest_circumference < p_caftan_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_caftan_name) > 30 OR LENGTH(p_caftan_name) < 1 THEN
        RAISE EXCEPTION 'Caftan name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_caftan_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Caftan with name % already exist', p_caftan_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_caftan_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Caftans (costume_item_id, length, min_waist_circumference, max_waist_circumference, 
        min_chest_circumference, max_chest_circumference)
		VALUES (i_id, p_caftan_length, p_caftan_min_waist_circumference, p_caftan_max_waist_circumference,
        p_caftan_min_chest_circumference, p_caftan_max_chest_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE add_petticoat(
    p_petticoat_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_petticoat_length SMALLINT,
    p_petticoat_min_waist_circumference SMALLINT,
    p_petticoat_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_petticoat_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_petticoat_length IS NULL OR 
    p_petticoat_min_waist_circumference IS NULL OR 
    p_petticoat_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_petticoat_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_petticoat_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_petticoat_max_waist_circumference < p_petticoat_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_petticoat_name) > 30 OR LENGTH(p_petticoat_name) < 1 THEN
        RAISE EXCEPTION 'Petticoat name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_petticoat_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Petticoat with name % already exist', p_petticoat_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_petticoat_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Petticoats (costume_item_id, length, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_petticoat_length, p_petticoat_min_waist_circumference, p_petticoat_max_waist_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_corset(
    p_corset_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_corset_length SMALLINT,
    p_corset_min_waist_circumference SMALLINT,
    p_corset_max_waist_circumference SMALLINT,
    p_corset_min_chest_circumference SMALLINT,
    p_corset_max_chest_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_corset_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_corset_length IS NULL OR 
    p_corset_min_waist_circumference IS NULL OR 
    p_corset_max_waist_circumference IS NULL OR 
    p_corset_min_chest_circumference IS NULL OR 
    p_corset_max_chest_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_corset_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_corset_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_corset_max_waist_circumference < p_corset_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_corset_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_corset_max_chest_circumference < p_corset_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_corset_name) > 30 OR LENGTH(p_corset_name) < 1 THEN
        RAISE EXCEPTION 'Corset name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_corset_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Corset with name % already exist', p_corset_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_corset_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Corsets (costume_item_id, length, min_waist_circumference, max_waist_circumference, 
        min_chest_circumference, max_chest_circumference)
		VALUES (i_id, p_corset_length, p_corset_min_waist_circumference, p_corset_max_waist_circumference,
        p_corset_min_chest_circumference, p_corset_max_chest_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_skirt(
    p_skirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_skirt_length SMALLINT,
    p_skirt_min_waist_circumference SMALLINT,
    p_skirt_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_skirt_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_skirt_length IS NULL OR 
    p_skirt_min_waist_circumference IS NULL OR 
    p_skirt_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_skirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_skirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_skirt_max_waist_circumference < p_skirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_skirt_name) > 30 OR LENGTH(p_skirt_name) < 1 THEN
        RAISE EXCEPTION 'Skirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_skirt_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Skirt with name % already exist', p_skirt_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_skirt_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Skirts (costume_item_id, length, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_skirt_length, p_skirt_min_waist_circumference, p_skirt_max_waist_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_belt(
    p_belt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_belt_min_waist_circumference SMALLINT,
    p_belt_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_belt_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_belt_min_waist_circumference IS NULL OR 
    p_belt_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_belt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_belt_max_waist_circumference < p_belt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_belt_name) > 30 OR LENGTH(p_belt_name) < 1 THEN
        RAISE EXCEPTION 'Belt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_belt_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Belt with name % already exist', p_belt_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_belt_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Belts (costume_item_id, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_belt_min_waist_circumference, p_belt_max_waist_circumference);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_shirt(
    p_shirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_shirt_length SMALLINT,
    p_shirt_arm_length SMALLINT,
    p_shirt_min_waist_circumference SMALLINT,
    p_shirt_max_waist_circumference SMALLINT,
    p_shirt_min_chest_circumference SMALLINT,
    p_shirt_max_chest_circumference SMALLINT,
    p_shirt_min_neck_circumference SMALLINT,
    p_shirt_max_neck_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_shirt_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_shirt_length IS NULL OR 
    p_shirt_arm_length IS NULL OR 
    p_shirt_min_waist_circumference IS NULL OR 
    p_shirt_max_waist_circumference IS NULL OR 
    p_shirt_min_chest_circumference IS NULL OR 
    p_shirt_max_chest_circumference IS NULL OR 
    p_shirt_min_neck_circumference IS NULL OR 
    p_shirt_max_neck_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_shirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_shirt_arm_length <= 0 THEN
        RAISE EXCEPTION 'Arm length must be greater than 0';
    END IF;

    IF p_shirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_shirt_max_waist_circumference < p_shirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_shirt_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_shirt_max_chest_circumference < p_shirt_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF p_shirt_min_neck_circumference <= 0 THEN
        RAISE EXCEPTION 'Min neck circumference must be greater than 0';
    END IF;

    IF p_shirt_max_neck_circumference < p_shirt_min_neck_circumference THEN
        RAISE EXCEPTION 'Max neck circumference must be greater or equal than min neck circumference';
    END IF;

    IF LENGTH(p_shirt_name) > 30 OR LENGTH(p_shirt_name) < 1 THEN
        RAISE EXCEPTION 'Shirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_shirt_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Shirt with name % already exist', p_shirt_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_shirt_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Shirts (costume_item_id, length, arm_length, min_waist_circumference, max_waist_circumference, 
        min_chest_circumference, max_chest_circumference, min_neck_circumference, max_neck_circumference)
		VALUES (i_id, p_shirt_length, p_shirt_min_waist_circumference, p_shirt_max_waist_circumference,
        p_shirt_min_chest_circumference, p_shirt_max_chest_circumference, p_shirt_min_neck_circumference, p_shirt_max_neck_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_pants(
    p_pants_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_pants_length SMALLINT,
    p_pants_min_waist_circumference SMALLINT,
    p_pants_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_pants_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_pants_length IS NULL OR 
    p_pants_min_waist_circumference IS NULL OR 
    p_pants_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_pants_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_pants_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_pants_max_waist_circumference < p_pants_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_pants_name) > 30 OR LENGTH(p_pants_name) < 1 THEN
        RAISE EXCEPTION 'Pants name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_pants_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Pants with name % already exist', p_pants_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_pants_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Pants (costume_item_id, length, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_pants_length, p_pants_min_waist_circumference, p_pants_max_waist_circumference);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_boots(
    p_boots_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_boots_shoe_size FLOAT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_boots_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_boots_shoe_size IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_boots_shoe_size <= 0 THEN
        RAISE EXCEPTION 'Shoe size must be greater than 0';
    END IF;

    IF LENGTH(p_boots_name) > 30 OR LENGTH(p_boots_name) < 1 THEN
        RAISE EXCEPTION 'Boots name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_boots_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Boots with name % already exist', p_boots_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_boots_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Boots (costume_item_id, shoe_size)
		VALUES (i_id, p_boots_shoe_size);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_neck_accessory(
    p_neck_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_neck_accessory_min_waist_circumference SMALLINT,
    p_neck_accessory_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_neck_accessory_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL OR 
    p_color_id IS NULL OR 
    p_location_id IS NULL OR 
    p_neck_accessory_min_waist_circumference IS NULL OR 
    p_neck_accessory_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = p_color_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

    IF p_neck_accessory_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_neck_accessory_max_waist_circumference < p_neck_accessory_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_neck_accessory_name) > 30 OR LENGTH(p_neck_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Neck accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_neck_accessory_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Neck accessory with name % already exist', p_neck_accessory_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_neck_accessory_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Neck_accessories (costume_item_id, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_neck_accessory_min_waist_circumference, p_neck_accessory_max_waist_circumference);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_costume(
    p_costume_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_apron_id          INTEGER,
    p_caftan_id         INTEGER, 
    p_petticoat_id      INTEGER, 
    p_corset_id         INTEGER, 
    p_skirt_id          INTEGER, 
    p_belt_id           INTEGER, 
    p_shirt_id          INTEGER, 
    p_pants_id          INTEGER, 
    p_boots_id          INTEGER, 
    p_neck_accessory_id INTEGER, 
    p_head_accessory_id INTEGER
) AS $$
BEGIN
    IF p_costume_name IS NULL OR 
    p_collection_id IS NULL OR 
    p_gender_id IS NULL THEN 
        RAISE EXCEPTION 'Costume name, collection id and gender id cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    IF p_apron_id IS NOT NULL THEN
        PERFORM 1
        FROM Aprons
        WHERE
            costume_item_id = p_apron_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Apron with id % does not exist', p_apron_id;
        END IF;
    END IF;
    
    IF p_caftan_id IS NOT NULL THEN
        PERFORM 1
        FROM Caftans
        WHERE
            costume_item_id = p_caftan_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Caftan with id % does not exist', p_caftan_id;
        END IF;
    END IF;

    IF p_petticoat_id IS NOT NULL THEN
        PERFORM 1
        FROM Petticoats
        WHERE
            costume_item_id = p_petticoat_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Peticoat with id % does not exist', p_petticoat_id;
        END IF;
    END IF;

    IF p_corset_id IS NOT NULL THEN
        PERFORM 1
        FROM Corsets
        WHERE
            costume_item_id = p_corset_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Corset with id % does not exist', p_corset_id;
        END IF;
    END IF;

    IF p_skirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Skirts
        WHERE
            costume_item_id = p_skirt_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Skirt with id % does not exist', p_skirt_id;
        END IF;
    END IF;

    IF p_belt_id IS NOT NULL THEN
        PERFORM 1
        FROM Belts
        WHERE
            costume_item_id = p_belt_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Belt with id % does not exist', p_belt_id;
        END IF;
    END IF;

    IF p_shirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Shirts
        WHERE
            costume_item_id = p_shirt_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Shirt with id % does not exist', p_shirt_id;
        END IF;
    END IF;

    IF p_pants_id IS NOT NULL THEN
        PERFORM 1
        FROM Pants
        WHERE
            costume_item_id = p_pants_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Pants with id % does not exist', p_pants_id;
        END IF;
    END IF;

    IF p_boots_id IS NOT NULL THEN
        PERFORM 1
        FROM Boots
        WHERE
            costume_item_id = p_boots_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Boots with id % does not exist', p_boots_id;
        END IF;
    END IF;

    IF p_neck_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Neck_accessories
        WHERE
            costume_item_id = p_neck_accessory_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Neck accessory with id % does not exist', p_neck_accessory_id;
        END IF;
    END IF;

    IF p_head_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Head_accessories
        WHERE
            costume_item_id = p_head_accessory_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Head accessory with id % does not exist', p_head_accessory_id;
        END IF;
    END IF;

    IF LENGTH(p_costume_name) > 30 THEN
        RAISE EXCEPTION 'Costume name exceeded 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes
	WHERE
		name = p_costume_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Costume with name % already exist', p_costume_name;
	END IF;

    IF check_costume_inconsistency(p_collection_id, p_gender_id, p_apron_id, p_caftan_id, p_petticoat_id,
        p_corset_id, p_shirt_id, p_belt_id, p_shirt_id, p_pants_id, p_boots_id, p_neck_accessory_id, 
        p_head_accessory_id) THEN
    	
        RAISE EXCEPTION 'Costume is inconsistency';
    END IF;

	BEGIN
		INSERT INTO Costumes (name, collection_id, gender_id, apron_id, caftan_id, petticoat_id, corset_id, skirt_id,
        belt_id, shirt_id, pants_id, boots_id, neck_accessory_id, head_accessory_id)
		VALUES (p_costume_name, p_collection_id, p_gender_id, p_apron_id, p_caftan_id, p_petticoat_id, p_corset_id,
        p_shirt_id, p_belt_id, p_shirt_id, p_pants_id, p_boots_id, p_neck_accessory_id, p_head_accessory_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_rental_costume_item_request(
    p_requester_user_id INTEGER,
    p_costume_item_id INTEGER
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_requester_user_id IS NULL OR 
    p_costume_item_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_requester_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_requester_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Rentals
    WHERE costume_item_id = p_costume_item_id AND date_of_return IS NULL;

    IF FOUND THEN
        RAISE EXCEPTION 'Costume item with id % is already rented', p_costume_item_id;
    END IF;
	
	BEGIN
        -- 1-> PENDING
		INSERT INTO Requests (datetime, requester_user_id, state_id)
        VALUES (NOW(), p_requester_user_id, 1) RETURNING id INTO i_id;

		INSERT INTO Rental_costume_item_requests (request_id, costume_item_id, approver_costumier_id)
		VALUES (i_id, p_costume_item_id, NULL);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_return_costume_item_request(
    p_requester_user_id INTEGER,
    p_costume_item_id INTEGER
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_requester_user_id IS NULL OR 
    p_costume_item_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_requester_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_requester_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Rentals
    WHERE user_id = p_requester_user_id AND costume_item_id = p_costume_item_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not rented';
    END IF;
	
	BEGIN
        -- 1-> PENDING
		INSERT INTO Requests (datetime, requester_user_id, state_id)
        VALUES (NOW(), p_requester_user_id, 1) RETURNING id INTO i_id;

		INSERT INTO Return_costume_item_requests (request_id, costume_item_id, approver_costumier_id)
		VALUES (i_id, p_costume_item_id, NULL);
        
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_borrow_costume_item_request(
    p_requester_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_approver_user_id INTEGER
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_requester_user_id IS NULL OR 
    p_costume_item_id IS NULL OR 
    p_approver_user_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_requester_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_requester_user_id;
    END IF;

    PERFORM 1
    FROM Users
    WHERE
        id = p_approver_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_approver_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Rentals
    WHERE user_id = p_approver_user_id AND costume_item_id = p_costume_item_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % was not rented by user with id %', p_costume_item_id, p_approver_user_id;
    END IF;

    IF p_requester_user_id = p_approver_user_id THEN
        RAISE EXCEPTION 'Requester user id and approver user id are the same';
    END IF;
	
	BEGIN
        -- 1-> PENDING
		INSERT INTO Requests (datetime, requester_user_id, state_id)
        VALUES (NOW(), p_requester_user_id, 1) RETURNING id INTO i_id;

		INSERT INTO Borrow_costume_item_requests (request_id, costume_item_id, approver_user_id)
		VALUES (i_id, p_costume_item_id, p_approver_user_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_notification(
    p_user_id INTEGER,
    p_notification_content TEXT,
    p_due_to_request_id INTEGER
) AS $$
DECLARE
    r_user_id INTEGER;
BEGIN
    IF p_user_id IS NULL OR 
    p_notification_content IS NULL OR 
    p_due_to_request_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_user_id;
    END IF;

    IF p_due_to_request_id IS NOT NULL THEN
        PERFORM 1
        FROM Requests
        WHERE
            id = p_due_to_request_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Request with id % does not exist', p_due_to_request_id;
        END IF;

        SELECT requester_user_id INTO r_user_id
        FROM Requests
        WHERE
            id = p_due_to_request_id;

        IF p_user_id = r_user_id THEN
            RAISE EXCEPTION 'User id and requester user id from request with % are not the same', p_due_to_request_id;
        END IF;
    END IF;

    IF LENGTH(p_notification_content) < 1 THEN
        RAISE EXCEPTION 'Notification must be at least 1 character';
    END IF;

	BEGIN
		INSERT INTO Notifications (user_id, content, datetime, due_to_request_id)
        VALUES (p_user_id, p_notification_content, NOW(), p_due_to_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_rental(
    p_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_done_due_request_id INTEGER,
    p_rental_date_of_rental TIMESTAMP
) AS $$
BEGIN
    IF p_user_id IS NULL OR 
    p_costume_item_id IS NULL OR 
    p_done_due_request_id IS NULL OR 
    p_rental_date_of_rental IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Requests
    WHERE
        id = p_done_due_request_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_done_due_request_id;
    END IF;

    IF check_rental_inconsistency(p_user_id, p_costume_item_id, p_done_due_request_id) THEN
        RAISE EXCEPTION 'Rental is inconsistency';
    END IF;
    
	BEGIN
		INSERT INTO Rentals (user_id, costume_item_id, done_due_request_id, date_of_rental)
        VALUES (p_user_id, p_costume_item_id, p_done_due_request_id, p_rental_date_of_rental);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_costume_item_location(
    p_costume_item_id INTEGER,
    p_location_id SMALLINT
) AS $$
BEGIN
    IF p_costume_item_id IS NULL OR 
    p_location_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Costumes_items
	WHERE
		id = p_costume_item_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;
	
	BEGIN
		PERFORM 1
	    FROM Costumes_items
	    WHERE
		    id = p_costume_item_id
        FOR UPDATE;

        UPDATE Costumes_items 
        SET 
            location_id = p_location_id 
        WHERE
		    id = p_costume_item_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_request(
    p_request_id INTEGER
) AS $$
DECLARE
    r_state_id INT;
BEGIN
    IF p_request_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;
	
    SELECT state_id INTO r_state_id
    FROM Requests
    WHERE
		id = p_request_id;

    IF r_state_id <> 1 THEN
        RAISE EXCEPTION 'Request closed - cannot delete';
    END IF;

	BEGIN
        DELETE FROM Requests WHERE id = p_request_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to delete: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE accept_rental_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    r_costume_item_id INT;
    notification_content TEXT;
BEGIN
    IF p_request_id IS NULL OR 
    p_approver_costumier_id IS NULL OR 
    p_comment IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;
	
    PERFORM 1
	FROM Rental_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not rental_costume_item_request', p_request_id;
	END IF;

    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        SELECT costume_item_id INTO r_costume_item_id
	    FROM Rental_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;
        
        -- 2-> ACCEPT
        UPDATE Requests 
        SET 
            state_id = 2 
        WHERE
		    id = p_request_id;

        UPDATE Rental_costume_item_requests
        SET 
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        notification_content := 'Request with id ' || p_request_id || ' has been accepted. You can rent costume item with id ' || r_costume_item_id || '. ' || p_comment;
        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE deny_rental_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT := 'Request with id ' || p_request_id || ' has been denied.' || p_comment;
BEGIN
    IF p_request_id IS NULL OR 
    p_approver_costumier_id IS NULL OR 
    p_comment IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Rental_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not rental_costume_item_request', p_request_id;
	END IF;
	
    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Rental_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;
        
        -- 3-> DENY
        UPDATE Requests 
        SET 
            state_id = 3
        WHERE
		    id = p_request_id;

        UPDATE Rental_costume_item_requests
        SET 
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE accept_return_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    r_costume_item_id INT;
    notification_content TEXT;
BEGIN
    IF p_request_id IS NULL OR 
    p_approver_costumier_id IS NULL OR 
    p_comment IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Return_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not return_costume_item_request', p_request_id;
	END IF;
	
    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        SELECT costume_item_id INTO r_costume_item_id
	    FROM Return_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;
        
        -- 2-> ACCEPT
        UPDATE Requests 
        SET 
            state_id = 2 
        WHERE
		    id = p_request_id;

        UPDATE Return_costume_item_requests
        SET 
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        notification_content := 'Request with id ' || p_request_id || ' has been accepted. You can return costume item with id ' || r_costume_item_id || '. ' || p_comment;
        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE deny_return_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT := 'Request with id ' || p_request_id || ' has been denied.' || p_comment;
BEGIN
    IF p_request_id IS NULL OR 
    p_approver_costumier_id IS NULL OR 
    p_comment IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Return_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not return_costume_item_request', p_request_id;
	END IF;
	
    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Return_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;
        
        -- 3-> DENY
        UPDATE Requests 
        SET 
            state_id = 3
        WHERE
		    id = p_request_id;

        UPDATE Return_costume_item_requests 
        SET 
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE accept_borrow_costume_item_request(
    p_request_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT;
BEGIN
    IF p_request_id IS NULL OR 
    p_comment IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Borrow_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not borrow_costume_item_request', p_request_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Borrow_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;
        
        -- 2-> ACCEPT
        UPDATE Requests 
        SET 
            state_id = 2 
        WHERE
		    id = p_request_id;

        notification_content := 'Request with id ' || p_request_id || ' has been accepted. ' || p_comment;
        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE deny_borrow_costume_item_request(
    p_request_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT := 'Request with id ' || p_request_id || ' has been denied.' || p_comment;
BEGIN
    IF p_request_id IS NULL OR 
    p_comment IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Borrow_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not borrow_costume_item_request', p_request_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Borrow_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;
        
        -- 3-> DENY
        UPDATE Requests 
        SET 
            state_id = 3
        WHERE
		    id = p_request_id;

        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE mark_notification_as_read(
    p_notification_id INTEGER
) AS $$
BEGIN
    IF p_notification_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Notifications
	WHERE
		id = p_notification_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Notification with id % does not exist', p_notification_id;
	END IF;

	BEGIN
		PERFORM 1
        FROM Notifications
        WHERE
            id = p_notification_id
        FOR UPDATE;

        UPDATE Notifications 
        SET 
            marked_as_read = 'T' 
        WHERE
		    id = p_notification_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE rent_costume_item(
    p_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_done_due_request_id INTEGER
) AS $$
BEGIN
    IF p_user_id IS NULL OR 
    p_costume_item_id IS NULL OR 
    p_done_due_request_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	BEGIN
		CALL add_rental(p_user_id, p_costume_item_id, p_done_due_request_id, date_trunc('minute', NOW()::TIMESTAMP));
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE return_costume_item(
    p_rental_id INTEGER,
    p_location_id SMALLINT
) AS $$
DECLARE
    r_costume_item_id INTEGER;
BEGIN
    IF p_rental_id IS NULL OR
    p_location_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
	FROM Rentals
	WHERE
		id = p_rental_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Rental with id % does not exist', p_rental_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

	BEGIN
        SELECT costume_item_id INTO r_costume_item_id
        FROM Rentals
        WHERE
            id = p_rental_id
        FOR UPDATE;

        UPDATE Rentals
        SET 
            date_of_return = date_trunc('minute', NOW()::TIMESTAMP)
        WHERE
            id = p_rental_id;
        CALL update_costume_item_location(r_costume_item_id, p_location_id)
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE borrow_costume_item(
    p_rental_id INTEGER,
    p_new_owner_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_done_due_request_id INTEGER
) AS $$
DECLARE
    swap_datetime TIMESTAMP;
BEGIN
    IF p_rental_id IS NULL OR 
    p_new_owner_user_id IS NULL OR 
    p_costume_item_id IS NULL OR 
    p_done_due_request_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
	FROM Rentals
	WHERE
		id = p_rental_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Rental with id % does not exist', p_rental_id;
	END IF;

	BEGIN
        PERFORM 1
        FROM Rentals
        WHERE
            id = p_rental_id
        FOR UPDATE;

        swap_datetime := date_trunc('minute', NOW()::TIMESTAMP);

		CALL add_rental(p_new_owner_user_id, p_costume_item_id, p_done_due_request_id, swap_datetime);

        UPDATE Rentals
        SET 
            date_of_return = swap_datetime
        WHERE
            id = p_rental_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_apron(
    p_apron_id INT,
    p_apron_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_apron_length SMALLINT,
    p_pattern_id SMALLINT
) AS $$
BEGIN
    IF p_apron_id IS NULL OR
       p_apron_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_apron_length IS NULL OR 
       p_pattern_id IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_apron_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exists', p_apron_id;
    END IF;

    PERFORM 1
    FROM Aprons
    WHERE costume_item_id = p_apron_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not apron';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_apron_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF LENGTH(p_apron_name) > 30 OR LENGTH(p_apron_name) < 1 THEN
        RAISE EXCEPTION 'Apron name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE name = p_apron_name
      AND id <> p_apron_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Apron with name % already exist', p_apron_name;
	END IF;

    BEGIN
        PERFORM 1
	    FROM Costumes_items
	    WHERE
		    id = p_apron_id
        FOR UPDATE;

        PERFORM 1
	    FROM Aprons
	    WHERE
		    costume_item_id = p_apron_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_apron_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_apron_id;

        UPDATE Aprons
        SET length = p_apron_length,
            pattern_id = p_pattern_id
        WHERE costume_item_id = p_apron_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_head_accessory(
    p_head_accessory_id INT,
    p_head_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_head_accessory_head_circumference SMALLINT,
    p_category_id SMALLINT
) AS $$
BEGIN
    IF p_head_accessory_id IS NULL OR
       p_head_accessory_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_category_id IS NULL THEN 
        RAISE EXCEPTION 'Only head circumference parameter can be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_head_accessory_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_head_accessory_id;
    END IF;

    PERFORM 1
    FROM Head_accessories
    WHERE costume_item_id = p_head_accessory_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a head accessory';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    PERFORM 1
    FROM Head_accessory_categories
    WHERE id = p_category_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Head accessory category with id % does not exist', p_category_id;
    END IF;

    IF p_head_accessory_head_circumference IS NOT NULL AND p_head_accessory_head_circumference <= 0 THEN
        RAISE EXCEPTION 'Head circumference must be greater than 0';
    END IF;

    IF LENGTH(p_head_accessory_name) > 30 OR LENGTH(p_head_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Head accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_head_accessory_name
      AND id <> p_head_accessory_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Head accessory with name % already exists', p_head_accessory_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_head_accessory_id
        FOR UPDATE;

        PERFORM 1
        FROM Head_accessories
        WHERE costume_item_id = p_head_accessory_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_head_accessory_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_head_accessory_id;

        UPDATE Head_accessories
        SET category_id = p_category_id,
            head_circumference = p_head_accessory_head_circumference
        WHERE costume_item_id = p_head_accessory_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_caftan(
    p_caftan_id INT,
    p_caftan_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_caftan_length SMALLINT,
    p_caftan_min_waist_circumference SMALLINT,
    p_caftan_max_waist_circumference SMALLINT,
    p_caftan_min_chest_circumference SMALLINT,
    p_caftan_max_chest_circumference SMALLINT
) AS $$
BEGIN
    IF p_caftan_id IS NULL OR
       p_caftan_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_caftan_length IS NULL OR 
       p_caftan_min_waist_circumference IS NULL OR 
       p_caftan_max_waist_circumference IS NULL OR 
       p_caftan_min_chest_circumference IS NULL OR 
       p_caftan_max_chest_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_caftan_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_caftan_id;
    END IF;

    PERFORM 1
    FROM Caftans
    WHERE costume_item_id = p_caftan_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a caftan';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_caftan_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_caftan_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_caftan_max_waist_circumference < p_caftan_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_caftan_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_caftan_max_chest_circumference < p_caftan_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_caftan_name) > 30 OR LENGTH(p_caftan_name) < 1 THEN
        RAISE EXCEPTION 'Caftan name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_caftan_name
      AND id <> p_caftan_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Caftan with name % already exists', p_caftan_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_caftan_id
        FOR UPDATE;

        PERFORM 1
        FROM Caftans
        WHERE costume_item_id = p_caftan_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_caftan_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_caftan_id;

        UPDATE Caftans
        SET length = p_caftan_length,
            min_waist_circumference = p_caftan_min_waist_circumference,
            max_waist_circumference = p_caftan_max_waist_circumference,
            min_chest_circumference = p_caftan_min_chest_circumference,
            max_chest_circumference = p_caftan_max_chest_circumference
        WHERE costume_item_id = p_caftan_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_petticoat(
    p_petticoat_id INT,
    p_petticoat_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_petticoat_length SMALLINT,
    p_petticoat_min_waist_circumference SMALLINT,
    p_petticoat_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_petticoat_id IS NULL OR
       p_petticoat_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_petticoat_length IS NULL OR 
       p_petticoat_min_waist_circumference IS NULL OR 
       p_petticoat_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_petticoat_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_petticoat_id;
    END IF;

    PERFORM 1
    FROM Petticoats
    WHERE costume_item_id = p_petticoat_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a petticoat';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_petticoat_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_petticoat_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_petticoat_max_waist_circumference < p_petticoat_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_petticoat_name) > 30 OR LENGTH(p_petticoat_name) < 1 THEN
        RAISE EXCEPTION 'Petticoat name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_petticoat_name
      AND id <> p_petticoat_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Petticoat with name % already exists', p_petticoat_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_petticoat_id
        FOR UPDATE;

        PERFORM 1
        FROM Petticoats
        WHERE costume_item_id = p_petticoat_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_petticoat_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_petticoat_id;

        UPDATE Petticoats
        SET length = p_petticoat_length,
            min_waist_circumference = p_petticoat_min_waist_circumference,
            max_waist_circumference = p_petticoat_max_waist_circumference
        WHERE costume_item_id = p_petticoat_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_corset(
    p_corset_id INT,
    p_corset_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_corset_length SMALLINT,
    p_corset_min_waist_circumference SMALLINT,
    p_corset_max_waist_circumference SMALLINT,
    p_corset_min_chest_circumference SMALLINT,
    p_corset_max_chest_circumference SMALLINT
) AS $$
BEGIN
    IF p_corset_id IS NULL OR
       p_corset_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_corset_length IS NULL OR 
       p_corset_min_waist_circumference IS NULL OR 
       p_corset_max_waist_circumference IS NULL OR 
       p_corset_min_chest_circumference IS NULL OR 
       p_corset_max_chest_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_corset_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_corset_id;
    END IF;

    PERFORM 1
    FROM Corsets
    WHERE costume_item_id = p_corset_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a corset';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_corset_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_corset_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_corset_max_waist_circumference < p_corset_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_corset_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_corset_max_chest_circumference < p_corset_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_corset_name) > 30 OR LENGTH(p_corset_name) < 1 THEN
        RAISE EXCEPTION 'Corset name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_corset_name
      AND id <> p_corset_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Corset with name % already exists', p_corset_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_corset_id
        FOR UPDATE;

        PERFORM 1
        FROM Corsets
        WHERE costume_item_id = p_corset_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_corset_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_corset_id;

        UPDATE Corsets
        SET length = p_corset_length,
            min_waist_circumference = p_corset_min_waist_circumference,
            max_waist_circumference = p_corset_max_waist_circumference,
            min_chest_circumference = p_corset_min_chest_circumference,
            max_chest_circumference = p_corset_max_chest_circumference
        WHERE costume_item_id = p_corset_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_skirt(
    p_skirt_id INT,
    p_skirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_skirt_length SMALLINT,
    p_skirt_min_waist_circumference SMALLINT,
    p_skirt_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_skirt_id IS NULL OR
       p_skirt_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_skirt_length IS NULL OR 
       p_skirt_min_waist_circumference IS NULL OR 
       p_skirt_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_skirt_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_skirt_id;
    END IF;

    PERFORM 1
    FROM Skirts
    WHERE costume_item_id = p_skirt_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a skirt';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_skirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_skirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_skirt_max_waist_circumference < p_skirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_skirt_name) > 30 OR LENGTH(p_skirt_name) < 1 THEN
        RAISE EXCEPTION 'Skirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_skirt_name
      AND id <> p_skirt_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Skirt with name % already exists', p_skirt_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_skirt_id
        FOR UPDATE;

        PERFORM 1
        FROM Skirts
        WHERE costume_item_id = p_skirt_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_skirt_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_skirt_id;

        UPDATE Skirts
        SET length = p_skirt_length,
            min_waist_circumference = p_skirt_min_waist_circumference,
            max_waist_circumference = p_skirt_max_waist_circumference
        WHERE costume_item_id = p_skirt_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_belt(
    p_belt_id INT,
    p_belt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_belt_min_waist_circumference SMALLINT,
    p_belt_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_belt_id IS NULL OR
       p_belt_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR  
       p_belt_min_waist_circumference IS NULL OR 
       p_belt_max_waist_circumference IS NULL THEN 
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_belt_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_belt_id;
    END IF;

    PERFORM 1
    FROM Belts
    WHERE costume_item_id = p_belt_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a belt';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_belt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_belt_max_waist_circumference < p_belt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_belt_name) > 30 OR LENGTH(p_belt_name) < 1 THEN
        RAISE EXCEPTION 'Belt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_belt_name
      AND id <> p_belt_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Belt with name % already exists', p_belt_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_belt_id
        FOR UPDATE;

        PERFORM 1
        FROM Belts
        WHERE costume_item_id = p_belt_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_belt_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_belt_id;

        UPDATE Belts
        SET min_waist_circumference = p_belt_min_waist_circumference,
            max_waist_circumference = p_belt_max_waist_circumference
        WHERE costume_item_id = p_belt_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_shirt(
    p_shirt_id INT,
    p_shirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_shirt_length SMALLINT,
    p_shirt_arm_length SMALLINT,
    p_shirt_min_waist_circumference SMALLINT,
    p_shirt_max_waist_circumference SMALLINT,
    p_shirt_min_chest_circumference SMALLINT,
    p_shirt_max_chest_circumference SMALLINT,
    p_shirt_min_neck_circumference SMALLINT,
    p_shirt_max_neck_circumference SMALLINT
) AS $$
BEGIN
    IF p_shirt_id IS NULL OR
       p_shirt_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_shirt_length IS NULL OR 
       p_shirt_arm_length IS NULL OR  
       p_shirt_min_waist_circumference IS NULL OR 
       p_shirt_max_waist_circumference IS NULL OR 
       p_shirt_min_chest_circumference IS NULL OR 
       p_shirt_max_chest_circumference IS NULL OR 
       p_shirt_min_neck_circumference IS NULL OR 
       p_shirt_max_neck_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_shirt_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_shirt_id;
    END IF;

    PERFORM 1
    FROM Shirts
    WHERE costume_item_id = p_shirt_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a shirt';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_shirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_shirt_arm_length <= 0 THEN
        RAISE EXCEPTION 'Arm length must be greater than 0';
    END IF;

    IF p_shirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_shirt_max_waist_circumference < p_shirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_shirt_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_shirt_max_chest_circumference < p_shirt_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF p_shirt_min_neck_circumference <= 0 THEN
        RAISE EXCEPTION 'Min neck circumference must be greater than 0';
    END IF;

    IF p_shirt_max_neck_circumference < p_shirt_min_neck_circumference THEN
        RAISE EXCEPTION 'Max neck circumference must be greater or equal than min neck circumference';
    END IF;

    IF LENGTH(p_shirt_name) > 30 OR LENGTH(p_shirt_name) < 1 THEN
        RAISE EXCEPTION 'Shirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_shirt_name
      AND id <> p_shirt_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Shirt with name % already exists', p_shirt_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_shirt_id
        FOR UPDATE;

        PERFORM 1
        FROM Shirts
        WHERE costume_item_id = p_shirt_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_shirt_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_shirt_id;

        UPDATE Shirts
        SET length = p_shirt_length,
	    arm_length = p_shirt_arm_length,
            min_waist_circumference = p_shirt_min_waist_circumference,
            max_waist_circumference = p_shirt_max_waist_circumference,
            min_chest_circumference = p_shirt_min_chest_circumference,
            max_chest_circumference = p_shirt_max_chest_circumference,
            min_neck_circumference = p_shirt_min_neck_circumference,
            max_neck_circumference = p_shirt_max_neck_circumference
        WHERE costume_item_id = p_shirt_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_pants(
    p_pants_id INT,
    p_pants_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_pants_length SMALLINT,
    p_pants_min_waist_circumference SMALLINT,
    p_pants_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_pants_id IS NULL OR
       p_pants_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_pants_length IS NULL OR 
       p_pants_min_waist_circumference IS NULL OR 
       p_pants_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_pants_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_pants_id;
    END IF;

    PERFORM 1
    FROM Pants
    WHERE costume_item_id = p_pants_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a pants';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_pants_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_pants_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_pants_max_waist_circumference < p_pants_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_pants_name) > 30 OR LENGTH(p_pants_name) < 1 THEN
        RAISE EXCEPTION 'Pants name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_pants_name
      AND id <> p_pants_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Pants with name % already exists', p_pants_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_pants_id
        FOR UPDATE;

        PERFORM 1
        FROM Pants
        WHERE costume_item_id = p_pants_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_pants_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_pants_id;

        UPDATE Pants
        SET length = p_pants_length,
            min_waist_circumference = p_pants_min_waist_circumference,
            max_waist_circumference = p_pants_max_waist_circumference
        WHERE costume_item_id = p_pants_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_boots(
    p_boots_id INT,
    p_boots_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_boots_shoe_size FLOAT
) AS $$
BEGIN
    IF p_boots_id IS NULL OR
       p_boots_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_boots_shoe_size IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_boots_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_boots_id;
    END IF;

    PERFORM 1
    FROM Boots
    WHERE costume_item_id = p_boots_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a boots';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_boots_shoe_size <= 0 THEN
        RAISE EXCEPTION 'Shoe size must be greater than 0';
    END IF;
    IF LENGTH(p_boots_name) > 30 OR LENGTH(p_boots_name) < 1 THEN
        RAISE EXCEPTION 'Boots name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_boots_name
      AND id <> p_boots_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Boots with name % already exists', p_boots_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_boots_id
        FOR UPDATE;

        PERFORM 1
        FROM Boots
        WHERE costume_item_id = p_boots_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_boots_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_boots_id;

        UPDATE Boots
        SET shoe_size = p_boots_shoe_size
        WHERE costume_item_id = p_boots_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_neck_accessory(
    p_neck_accessory_id INT,
    p_neck_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_neck_accessory_min_neck_circumference SMALLINT,
    p_neck_accessory_max_neck_circumference SMALLINT
) AS $$
BEGIN
    IF p_neck_accessory_id IS NULL OR
       p_neck_accessory_name IS NULL OR 
       p_collection_id IS NULL OR 
       p_gender_id IS NULL OR 
       p_color_id IS NULL OR 
       p_location_id IS NULL OR 
       p_neck_accessory_min_neck_circumference IS NULL OR 
       p_neck_accessory_max_neck_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE id = p_neck_accessory_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_neck_accessory_id;
    END IF;

    PERFORM 1
    FROM Neck_accessories
    WHERE costume_item_id = p_neck_accessory_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not a neck accessory';
    END IF;

    PERFORM 1
    FROM Collections
    WHERE id = p_collection_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
    END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male), 2 (female), or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
    FROM Genders
    WHERE id = p_gender_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
    END IF;

    PERFORM 1
    FROM Colors
    WHERE id = p_color_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Color with id % does not exist', p_color_id;
    END IF;

    PERFORM 1
    FROM Locations
    WHERE id = p_location_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
    END IF;

    IF p_neck_accessory_min_neck_circumference <= 0 THEN
        RAISE EXCEPTION 'Min neck circumference must be greater than 0';
    END IF;

    IF p_neck_accessory_max_neck_circumference < p_neck_accessory_min_waist_circumference THEN
        RAISE EXCEPTION 'Max neck circumference must be greater or equal than min neck circumference';
    END IF;

    IF LENGTH(p_neck_accessory_name) > 30 OR LENGTH(p_neck_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Neck accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_neck_accessory_name
      AND id <> p_neck_accessory_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Neck accessory with name % already exists', p_neck_accessory_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_neck_accessory_id
        FOR UPDATE;

        PERFORM 1
        FROM Neck_accessories
        WHERE costume_item_id = p_neck_accessory_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_neck_accessory_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_neck_accessory_id;

        UPDATE Neck_accessories
        SET min_neck_circumference = p_neck_accessory_min_neck_circumference,
            max_neck_circumference = p_neck_accessory_max_neck_circumference
        WHERE costume_item_id = p_neck_accessory_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;