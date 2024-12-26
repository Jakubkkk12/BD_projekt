CREATE OR REPLACE FUNCTION get_costume_item_rental_history(
    f_costume_element_id INT
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
        ci.name, 
        u.first_name, 
        u.last_name, 
        r.date_of_rental, 
        r.date_of_return
    FROM 
        Rentals r
    INNER JOIN 
        Users u
        ON r.user_id = u.id
    INNER JOIN 
        Costumes_items ci
        ON r.costume_item_id = ci.id
    WHERE 
        ci.id = f_costume_element_id
    ORDER BY
        date_of_rental
    ASC; 
END;
$$ LANGUAGE plpgsql;