CREATE FUNCTION check_costume_item_has_class_extenction() RETURNS TRIGGER AS $$
    BEGIN
      	IF NOT EXISTS (
			SELECT 1 
			FROM ((SELECT 1 AS "is_in" FROM Neck_accessories WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Boots WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Pants WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Shirts WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Belts WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Skirts WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Corsets WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Petticoats WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Caftans WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Aprons WHERE costume_item_id = NEW.costume_item_id)
				  UNION
			      (SELECT 1 AS "is_in" FROM Head_accessories WHERE costume_item_id = NEW.costume_item_id)) t
			GROUP BY 
			    t.is_in
			HAVING 
    			SUM(t.is_in) > 0
		) THEN
			RETURN NEW;
        END IF;
		
		RETURN NULL; 
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Head_accessories
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Aprons
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Caftans
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Petticoats
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Corsets
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Skirts
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Belts
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Shirts
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Pants
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Boots
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Neck_accessories
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();


CREATE FUNCTION check_costume_consistency()
RETURNS TRIGGER AS $$
BEGIN
    IF check_costume_inconsistency(
    NEW.collection_id, NEW.gender_id, NEW.apron_id, NEW.caftan_id, NEW.petticoat_id, NEW.corset_id,
    NEW.skirt_id, NEW.belt_id, NEW.shirt_id, NEW.pants_id, NEW.boots_id, NEW.neck_accessory_id, 
    NEW.head_accessory_id) THEN
        RAISE EXCEPTION 'Costume is inconsistancy';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_costume_insert_update BEFORE INSERT OR UPDATE ON Costumes
FOR EACH ROW EXECUTE FUNCTION check_costume_consistency();

CREATE FUNCTION check_request_state()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.state_id = 1 THEN
        RETURN OLD;
    END IF;
    RAISE NOTICE 'Cannot delete closed request';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_request_delete BEFORE DELETE ON Requests
FOR EACH ROW EXECUTE FUNCTION check_request_state();


CREATE FUNCTION check_request_has_type_extenction() 
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM ((SELECT 1 AS "is_in" FROM Return_costume_item_requests WHERE request_id = NEW.request_id)
                UNION
                (SELECT 1 AS "is_in" FROM Rental_costume_item_requests WHERE request_id = NEW.request_id)
                UNION
                (SELECT 1 AS "is_in" FROM Borrow_costume_item_requests WHERE request_id = NEW.request_id)) t
        GROUP BY 
            t.is_in
        HAVING 
            SUM(t.is_in) > 0
    ) THEN
        RETURN NEW;
    END IF;
    
    RAISE NOTICE 'Request has already extenction';
    RETURN NULL; 
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_request_insert BEFORE INSERT ON Rental_costume_item_requests
    FOR EACH ROW EXECUTE FUNCTION check_request_has_type_extenction();

CREATE TRIGGER prevent_invalid_request_insert BEFORE INSERT ON Return_costume_item_requests
    FOR EACH ROW EXECUTE FUNCTION check_request_has_type_extenction();

CREATE TRIGGER prevent_invalid_request_insert BEFORE INSERT ON Borrow_costume_item_requests
    FOR EACH ROW EXECUTE FUNCTION check_request_has_type_extenction();


CREATE FUNCTION check_rental_costume_item_request_costume_item()
RETURNS TRIGGER AS $$
BEGIN
	PERFORM 1
    FROM Rentals
    WHERE costume_item_id = NEW.costume_item_id AND date_of_return IS NULL;

    IF FOUND THEN
        RAISE EXCEPTION 'Cannot create request to rent costume item with id % because it is already rented', NEW.costume_item_id;
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_rental_costume_item_request_insert BEFORE INSERT ON Rental_costume_item_requests
FOR EACH ROW EXECUTE FUNCTION check_rental_costume_item_request_costume_item();


CREATE FUNCTION check_return_costume_item_request_costume_item()
RETURNS TRIGGER AS $$
DECLARE
    r_user_id INT;
BEGIN
    SELECT requester_user_id INTO r_user_id 
	FROM Requests
	WHERE id = NEW.request_id;

	PERFORM 1
    FROM Rentals
    WHERE user_id = r_user_id AND costume_item_id = NEW.costume_item_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cannot create request to return costume item which you do not rent';
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_return_costume_item_request_insert BEFORE INSERT ON Rental_costume_item_requests
FOR EACH ROW EXECUTE FUNCTION check_return_costume_item_request_costume_item();


CREATE FUNCTION check_borrow_costume_item_request_approver_and_costume_item()
RETURNS TRIGGER AS $$
DECLARE
    r_user_id INT;
BEGIN
	PERFORM 1
    FROM Rentals
    WHERE costume_item_id = NEW.costume_item_id AND user_id = NEW.approver_user_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User % does not have requested costume item', NEW.approver_user_id;
    END IF;

	SELECT requester_user_id INTO r_user_id 
	FROM Requests
	WHERE id = NEW.request_id;
	
    IF NEW.approver_user_id = r_user_id THEN
        RAISE EXCEPTION 'You cannot borrow costume item to yourself';
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_borrow_costume_item_request_insert BEFORE INSERT ON Borrow_costume_item_requests
FOR EACH ROW EXECUTE FUNCTION check_borrow_costume_item_request_approver_and_costume_item();


CREATE FUNCTION check_notification_due_to_request()
RETURNS TRIGGER AS $$
DECLARE
    r_user_id INT;
BEGIN
    IF NEW.due_to_request_id IS NOT NULL THEN
        SELECT requester_user_id INTO r_user_id 
        FROM Requests
        WHERE id = NEW.due_to_request_id;
        
        IF NEW.user_id = r_user_id THEN
            RAISE EXCEPTION 'User id and requester id from request are not the same';
        END IF;
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_notification_insert BEFORE INSERT ON Notifications
FOR EACH ROW EXECUTE FUNCTION check_notification_due_to_request();


CREATE FUNCTION check_rental_consistency()
RETURNS TRIGGER AS $$
BEGIN
    IF check_rental_inconsistency(NEW.user_id, NEW.costume_item_id, NEW.done_due_request_id) THEN
        RAISE EXCEPTION 'Rental is inconsistancy';
    END IF;
	
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_rental_insert BEFORE INSERT ON Rentals
FOR EACH ROW EXECUTE FUNCTION check_rental_consistency();