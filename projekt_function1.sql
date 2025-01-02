CREATE FUNCTION check_costume_inconsistency(
    f_collection_id     SMALLINT, 
    f_gender_id         SMALLINT,
    f_apron_id          INTEGER,
    f_caftan_id         INTEGER, 
    f_petticoat_id      INTEGER, 
    f_corset_id         INTEGER, 
    f_skirt_id          INTEGER, 
    f_belt_id           INTEGER, 
    f_shirt_id          INTEGER, 
    f_pants_id          INTEGER, 
    f_boots_id          INTEGER, 
    f_neck_accessory_id INTEGER, 
    f_head_accessory_id INTEGER 
)
RETURNS BOOLEAN AS $$
DECLARE
    inconsistency_found BOOLEAN := FALSE;
BEGIN
    IF f_apron_id IS NOT NULL THEN
        PERFORM 1
        FROM Aprons
        WHERE costume_item_id = f_apron_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Apron does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_belt_id IS NOT NULL THEN
        PERFORM 1
        FROM Belts
        WHERE costume_item_id = f_belt_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Belt does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_boots_id IS NOT NULL THEN
        PERFORM 1
        FROM Boots
        WHERE costume_item_id = f_boots_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Boots do not match collection % or are not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_caftan_id IS NOT NULL THEN
        PERFORM 1
        FROM Caftans
        WHERE costume_item_id = f_caftan_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Caftan does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_corset_id IS NOT NULL THEN
        PERFORM 1
        FROM Corsets
        WHERE costume_item_id = f_corset_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Corset does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_petticoat_id IS NOT NULL THEN
        PERFORM 1
        FROM Petticoats
        WHERE costume_item_id = f_petticoat_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Petticoat does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_skirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Skirts
        WHERE costume_item_id = f_skirt_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Skirt does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_shirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Shirts
        WHERE costume_item_id = f_shirt_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Shirt does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_pants_id IS NOT NULL THEN
        PERFORM 1
        FROM Pants
        WHERE costume_item_id = f_pants_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Pants does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_neck_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Neck_accessories
        WHERE costume_item_id = f_neck_accessory_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Neck accessory does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_head_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Head_accessories
        WHERE costume_item_id = f_head_accessory_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Head accessory does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_apron_id IS NOT NULL THEN
        PERFORM 1
        FROM Aprons
        WHERE costume_item_id = f_apron_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Apron does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_belt_id IS NOT NULL THEN
        PERFORM 1
        FROM Belts
        WHERE costume_item_id = f_belt_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Belt does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_boots_id IS NOT NULL THEN
        PERFORM 1
        FROM Boots
        WHERE costume_item_id = f_boots_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Boots do not match gender % or are not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_caftan_id IS NOT NULL THEN
        PERFORM 1
        FROM Caftans
        WHERE costume_item_id = f_caftan_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Caftan does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_corset_id IS NOT NULL THEN
        PERFORM 1
        FROM Corsets
        WHERE costume_item_id = f_corset_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Corset does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_petticoat_id IS NOT NULL THEN
        PERFORM 1
        FROM Petticoats
        WHERE costume_item_id = f_petticoat_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Petticoat does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_skirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Skirts
        WHERE costume_item_id = f_skirt_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Skirt does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_shirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Shirts
        WHERE costume_item_id = f_shirt_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Shirts does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_pants_id IS NOT NULL THEN
        PERFORM 1
        FROM Pants
        WHERE costume_item_id = f_pants_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Pants does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_neck_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Neck_accessories
        WHERE costume_item_id = f_neck_accessory_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Neck accessory does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_head_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Head_accessories
        WHERE costume_item_id = f_head_accessory_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Head accessory does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF inconsistency_found THEN
        RETURN TRUE;
    END IF;

    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;



CREATE FUNCTION check_rental_inconsistency(
    f_user_id                INTEGER, 
    f_costume_item_id        INTEGER, 
    f_done_due_request_id    INTEGER
)
RETURNS BOOLEAN AS $$
DECLARE
    r_user_id INT;
    r_costume_item_id INT;
    inconsistency_found BOOLEAN := FALSE;
BEGIN
	SELECT r.requester_user_id, COALESCE(ren_r.costume_item_id, ret_r.costume_item_id, b_r.costume_item_id) INTO r_user_id, r_costume_item_id
	FROM Requests r
    LEFT JOIN Rental_costume_item_requests ren_r
        ON r.id=ren_r.request_id
    LEFT JOIN Return_costume_item_requests ret_r
        ON r.id=ret_r.request_id
    LEFT JOIN Borrow_costume_item_requests b_r
        ON r.id=b_r.request_id
	WHERE r.id = f_done_due_request_id;
	
    IF f_user_id <> r_user_id THEN
        RAISE NOTICE 'user_id are not consistency with request %', f_done_due_request_id;
        inconsistency_found := TRUE;
    END IF;

    IF f_costume_item_id <> r_costume_item_id THEN
        RAISE NOTICE 'costume_item_id are not consistency with request %', f_done_due_request_id;
        inconsistency_found := TRUE;
    END IF;

    IF inconsistency_found THEN
        RETURN TRUE;
    END IF;
	
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;



CREATE FUNCTION check_if_error_in_costume_item_common_part(
    f_collection_id                SMALLINT, 
    f_gender_id        SMALLINT, 
    f_color_id    SMALLINT,
    f_location_id    SMALLINT
)
RETURNS BOOLEAN AS $$
DECLARE
    error_found BOOLEAN := FALSE;
BEGIN
	PERFORM 1
	FROM Collections
	WHERE
		id = f_collection_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Collection with id % does not exist', f_collection_id;
        error_found := TRUE;
	END IF;

    IF f_gender_id NOT IN (1, 2, 3) THEN
        RAISE NOTICE 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
        error_found := TRUE;
    END IF;
	
    PERFORM 1
	FROM Genders
	WHERE
		id = f_gender_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Gender with id % does not exist', f_gender_id;
        error_found := TRUE;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = f_color_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Color with id % does not exist', f_color_id;
        error_found := TRUE;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = f_location_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Location with id % does not exist', f_location_id;
        error_found := TRUE;
	END IF;

    IF error_found THEN
        RETURN TRUE;
    END IF;
	
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;