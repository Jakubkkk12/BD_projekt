CREATE OR REPLACE FUNCTION get_costume_item_rental_history(
    f_costume_item_id INT
)
RETURNS TABLE (
    costume_item_name VARCHAR,
    user_id INT,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    date_of_rental TIMESTAMP,
    date_of_return TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.costume_item_name,
        d.user_id,
        d.user_first_name,
        d.user_last_name,
        d.date_of_rental,
        d.date_of_return
    FROM 
        Detailed_rentals d
    WHERE 
        d.costume_item_id = f_costume_item_id
    ORDER BY
        d.date_of_rental
    ASC; 
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_rental_history(
    f_user_id INT
)
RETURNS TABLE (
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR,
    date_of_rental TIMESTAMP,
    date_of_return TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.user_first_name,
        d.user_last_name,
        d.costume_item_id,
        d.costume_item_name,
        d.date_of_rental,
        d.date_of_return
    FROM 
        Detailed_rentals d
    WHERE 
        d.user_id = f_user_id
    ORDER BY
        d.date_of_rental
    ASC;  
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_costumier_unresolved_requests()
RETURNS TABLE (
    request_id INT,
    request_state VARCHAR,
    request_datetie TIMESTAMP,
    user_id INT,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM ((SELECT r.id, r.state, r.datetime, r.requester_user_id, u.first_name, u.last_name, r.costume_item_id, ci.name
    FROM
        Detaild_rental_costume_item_requests r
    INNER JOIN 
        Users u
        ON r.requester_user_id = u.id
    INNER JOIN 
        Costumes_items ci
        ON r.costume_item_id = ci.id
    WHERE
        r.approver_costumier_id IS NULL)
    UNION
    (SELECT r.id, r.state, r.datetime, r.requester_user_id, u.first_name, u.last_name, r.costume_item_id, ci.name
    FROM
        Detaild_return_costume_item_requests r
    INNER JOIN 
        Users u
        ON r.requester_user_id = u.id
    INNER JOIN 
        Costumes_items ci
        ON r.costume_item_id = ci.id
    WHERE
        r.approver_costumier_id IS NULL)) t
    ORDER BY
        t.datetime
    ASC; 
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_unresolved_borrow_requests(
    f_user_id INT
)
RETURNS TABLE (
    request_id INT,
    request_state TEXT,
    request_datetie TIMESTAMP,
    user_id INT,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        r.id, 
        r.state, 
        r.datetime, 
        r.requester_user_id, 
        u.first_name, 
        u.last_name, 
        r.costume_item_id, 
        ci.name
    FROM
        Detaild_borrow_costume_item_requests r
    INNER JOIN 
        Users u
        ON r.requester_user_id = u.id
    INNER JOIN 
        Costumes_items ci
        ON r.costume_item_id = ci.id
    WHERE
        r.approver_costumier_id = f_user_id
        AND
        (r.state <> 'ACCEPT' AND r.state <> 'DENY')
    ORDER BY
        r.datetime
    ASC; 
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_current_rentals(
    f_user_id INT
)
RETURNS TABLE (
    rental_id INT,
    date_of_rental TIMESTAMP,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id,
        d.date_of_rental,
        d.user_first_name,
        d.user_last_name,
        d.costume_item_id,
        d.costume_item_name
    FROM 
        Detailed_current_rentals d
    WHERE 
        d.user_id = f_user_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_function_percentage()
RETURNS TABLE (
    user_function TEXT,
    percentage_of_users_with_this_function TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        ufc.user_function, 
        CONCAT(((ufc.number_of_users_with_this_function/(SELECT COUNT(*) FROM Users))*100), '%')
    FROM 
        User_function_counts ufc;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_aprons(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    length SMALLINT, 
    pattern VARCHAR
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.length, 
        d.pattern
    FROM 
        Detailed_aprons d
    WHERE 
        d.length >= 0.76*user_leg_length - 5
        AND
        d.length <= 0.76*user_leg_length + 5;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_boots(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    shoe_size FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.shoe_size
    FROM 
        Detailed_boots d
    WHERE 
        d.shoe_size = (SELECT u.shoe_size FROM Users u WHERE u.id = f_user_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_petticoats(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    length SMALLINT, 
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.length, 
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM 
        Detailed_petticoats d
    WHERE 
        d.length >= 0.76*user_leg_length - 5
        AND
        d.length <= 0.76*user_leg_length + 5
        AND 
        user_waist_circumference >= d.min_waist_circumference
        AND 
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_skirts(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    length SMALLINT, 
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.length, 
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM 
        Detailed_skirts d
    WHERE 
        d.length >= 0.76*user_leg_length - 5
        AND
        d.length <= 0.76*user_leg_length + 5
        AND 
        user_waist_circumference >= d.min_waist_circumference
        AND 
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_caftans(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    length SMALLINT, 
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT,
    min_chest_circumference SMALLINT,
    max_chest_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
    user_chest_circumference SMALLINT := (SELECT u.chest_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.length, 
        d.min_waist_circumference,
        d.max_waist_circumference,
        d.min_chest_circumference,
        d.max_chest_circumference
    FROM 
        Detailed_caftans d
    WHERE 
        d.length >= 0.60*user_leg_length
        AND 
        user_waist_circumference >= d.min_waist_circumference
        AND 
        user_waist_circumference <= d.max_waist_circumference
        AND 
        user_chest_circumference >= d.min_chest_circumference
        AND 
        user_chest_circumference <= d.max_chest_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_corsets(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    length SMALLINT, 
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT,
    min_chest_circumference SMALLINT,
    max_chest_circumference SMALLINT
) AS $$
DECLARE
    user_torso_length SMALLINT := (SELECT u.torso_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
    user_chest_circumference SMALLINT := (SELECT u.chest_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.length, 
        d.min_waist_circumference,
        d.max_waist_circumference,
        d.min_chest_circumference,
        d.max_chest_circumference
    FROM 
        Detailed_corsets d
    WHERE 
        d.length >= user_torso_length
        AND 
        user_waist_circumference >= d.min_waist_circumference
        AND 
        user_waist_circumference <= d.max_waist_circumference
        AND 
        user_chest_circumference >= d.min_chest_circumference
        AND 
        user_chest_circumference <= d.max_chest_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_neck_accessories(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    min_neck_circumference SMALLINT,
    max_neck_circumference SMALLINT
) AS $$
DECLARE
    user_neck_circumference SMALLINT := (SELECT u.neck_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.min_neck_circumference,
        d.max_neck_circumference
    FROM 
        Detailed_neck_accessories d
    WHERE  
        user_neck_circumference >= d.min_neck_circumference
        AND 
        user_neck_circumference <= d.max_neck_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_head_accessories(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    head_circumference SMALLINT,
    category VARCHAR
) AS $$
DECLARE
    user_head_circumference SMALLINT := (SELECT u.head_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.head_circumference,
        d.category
    FROM 
        Detailed_head_accessories d
    WHERE  
        d.head_circumference IS NULL 
        OR 
        (user_head_circumference - 2 >= d.head_circumference
        AND 
        user_head_circumference + 2 <= d.head_circumference);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_belts(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM 
        Detailed_belts d
    WHERE 
        user_waist_circumference >= d.min_waist_circumference
        AND 
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_pants(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    length SMALLINT, 
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.length, 
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM 
        Detailed_pants d
    WHERE 
        d.length >= user_leg_length - 3
        AND
        d.length <= user_leg_length + 3
        AND 
        user_waist_circumference >= d.min_waist_circumference
        AND 
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_shirts(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    name VARCHAR, 
    collection VARCHAR, 
    color VARCHAR, 
    gender VARCHAR, 
    length SMALLINT,
    arm_length SMALLINT, 
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT,
    min_chest_circumference SMALLINT,
    max_chest_circumference SMALLINT,
    min_neck_circumference SMALLINT,
    max_neck_circumference SMALLINT
) AS $$
DECLARE
    user_torso_length SMALLINT := (SELECT u.torso_length FROM Users u WHERE u.id = f_user_id);
    user_arm_length SMALLINT := (SELECT u.arm_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
    user_chest_circumference SMALLINT := (SELECT u.chest_circumference FROM Users u WHERE u.id = f_user_id);
    user_neck_circumference SMALLINT := (SELECT u.neck_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.name, 
        d.collection, 
        d.color, 
        d.gender, 
        d.length, 
        d.arm_length, 
        d.min_waist_circumference,
        d.max_waist_circumference,
        d.min_chest_circumference,
        d.max_chest_circumference,
        d.min_neck_circumference,
        d.max_neck_circumference
    FROM 
        Detailed_shirts d
    WHERE 
        d.length >= user_torso_length
        AND 
        d.arm_length >= user_arm_length
        AND
        user_waist_circumference >= d.min_waist_circumference
        AND 
        user_waist_circumference <= d.max_waist_circumference
        AND 
        user_chest_circumference >= d.min_chest_circumference
        AND 
        user_chest_circumference <= d.max_chest_circumference
        AND 
        user_neck_circumference >= d.min_neck_circumference
        AND 
        user_neck_circumference <= d.max_neck_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_unread_notifications(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    content TEXT, 
    datetime TIMESTAMP, 
    due_to_request_id INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.content, 
        d.datetime, 
        d.due_to_request_id
    FROM 
        Not_read_notifications d
    WHERE 
        d.user_id = f_user_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_unclosed_costume_item_requests(
    f_user_id INT
)
RETURNS TABLE (
    id INT, 
    datetime TIMESTAMP, 
    type TEXT,
    state VARCHAR,
    costume_item_id INT,
    approver_id INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id, 
        d.datetime,
        d.type, 
        d.state,
        d.costume_item_id,
        d.approver_id
    FROM 
        Detaild_costume_item_requests d
    WHERE 
        d.requester_user_id = f_user_id;
END;
$$ LANGUAGE plpgsql;
