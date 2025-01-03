CREATE ROLE normal_user WITH LOGIN PASSWORD 'zasxZSXA23!@#';
GRANT EXECUTE ON FUNCTION get_user_unresolved_borrow_requests TO normal_user;
GRANT EXECUTE ON FUNCTION get_user_current_rentals TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_aprons TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_boots TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_petticoats TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_skirts TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_caftans TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_corsets TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_neck_accessories TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_head_accessories TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_belts TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_pants TO normal_user;
GRANT EXECUTE ON FUNCTION get_fits_shirts TO normal_user;
GRANT EXECUTE ON FUNCTION get_user_unread_notifications TO normal_user;
GRANT EXECUTE ON FUNCTION get_user_unclosed_costume_item_requests TO normal_user;
GRANT EXECUTE ON PROCEDURE add_rental_costume_item_request TO normal_user;
GRANT EXECUTE ON PROCEDURE add_return_costume_item_request TO normal_user;
GRANT EXECUTE ON PROCEDURE add_borrow_costume_item_request TO normal_user;
GRANT EXECUTE ON PROCEDURE delete_request TO normal_user;
GRANT EXECUTE ON PROCEDURE accept_borrow_costume_item_request TO normal_user;
GRANT EXECUTE ON PROCEDURE deny_borrow_costume_item_request TO normal_user;
GRANT EXECUTE ON PROCEDURE borrow_costume_item TO normal_user;
GRANT SELECT ON TABLE Detailed_aprons TO normal_user;
GRANT SELECT ON TABLE Detailed_boots TO normal_user;
GRANT SELECT ON TABLE Detailed_petticoats TO normal_user;
GRANT SELECT ON TABLE Detailed_skirts TO normal_user;
GRANT SELECT ON TABLE Detailed_caftans TO normal_user;
GRANT SELECT ON TABLE Detailed_corsets TO normal_user;
GRANT SELECT ON TABLE Detailed_neck_accessories TO normal_user;
GRANT SELECT ON TABLE Detailed_head_accessories TO normal_user;
GRANT SELECT ON TABLE Detailed_belts TO normal_user;
GRANT SELECT ON TABLE Detailed_pants TO normal_user;
GRANT SELECT ON TABLE Detailed_shirts TO normal_user;
GRANT SELECT ON TABLE Costume_with_costume_items_name TO normal_user;



CREATE ROLE costumier WITH LOGIN PASSWORD 'vfgESDy^%783';
GRANT EXECUTE ON FUNCTION get_costume_item_rental_history TO costumier;
GRANT EXECUTE ON FUNCTION get_user_rental_history TO costumier;
GRANT EXECUTE ON FUNCTION get_costumier_unresolved_requests TO costumier;
GRANT EXECUTE ON FUNCTION get_user_current_rentals TO costumier;
GRANT EXECUTE ON PROCEDURE add_color TO costumier;
GRANT EXECUTE ON PROCEDURE add_collection TO costumier;
GRANT EXECUTE ON PROCEDURE add_pattern TO costumier;
GRANT EXECUTE ON PROCEDURE add_head_accessory_category TO costumier;
GRANT EXECUTE ON PROCEDURE add_apron TO costumier;
GRANT EXECUTE ON PROCEDURE add_head_accessory TO costumier;
GRANT EXECUTE ON PROCEDURE add_caftan TO costumier;
GRANT EXECUTE ON PROCEDURE add_petticoat TO costumier;
GRANT EXECUTE ON PROCEDURE add_corset TO costumier;
GRANT EXECUTE ON PROCEDURE add_skirt TO costumier;
GRANT EXECUTE ON PROCEDURE add_belt TO costumier;
GRANT EXECUTE ON PROCEDURE add_shirt TO costumier;
GRANT EXECUTE ON PROCEDURE add_pants TO costumier;
GRANT EXECUTE ON PROCEDURE add_boots TO costumier;
GRANT EXECUTE ON PROCEDURE add_neck_accessory TO costumier;
GRANT EXECUTE ON PROCEDURE add_apron TO costumier;
GRANT EXECUTE ON PROCEDURE update_head_accessory TO costumier;
GRANT EXECUTE ON PROCEDURE update_caftan TO costumier;
GRANT EXECUTE ON PROCEDURE update_petticoat TO costumier;
GRANT EXECUTE ON PROCEDURE update_corset TO costumier;
GRANT EXECUTE ON PROCEDURE update_skirt TO costumier;
GRANT EXECUTE ON PROCEDURE update_belt TO costumier;
GRANT EXECUTE ON PROCEDURE update_shirt TO costumier;
GRANT EXECUTE ON PROCEDURE update_pants TO costumier;
GRANT EXECUTE ON PROCEDURE update_boots TO costumier;
GRANT EXECUTE ON PROCEDURE update_neck_accessory TO costumier;
GRANT EXECUTE ON PROCEDURE add_costume TO costumier;
GRANT EXECUTE ON PROCEDURE update_costume_item_location TO costumier;
GRANT EXECUTE ON PROCEDURE accept_rental_costume_item_request TO costumier;
GRANT EXECUTE ON PROCEDURE accept_return_costume_item_request TO costumier;
GRANT EXECUTE ON PROCEDURE deny_rental_costume_item_request TO costumier;
GRANT EXECUTE ON PROCEDURE deny_return_costume_item_request TO costumier;
GRANT EXECUTE ON PROCEDURE rent_costume_item TO costumier;
GRANT EXECUTE ON PROCEDURE return_costume_item TO costumier;
GRANT SELECT ON TABLE Locations_with_settlements_regions_countries TO costumier;
GRANT SELECT ON TABLE Detailed_aprons TO costumier;
GRANT SELECT ON TABLE Detailed_boots TO costumier;
GRANT SELECT ON TABLE Detailed_petticoats TO costumier;
GRANT SELECT ON TABLE Detailed_skirts TO costumier;
GRANT SELECT ON TABLE Detailed_caftans TO costumier;
GRANT SELECT ON TABLE Detailed_corsets TO costumier;
GRANT SELECT ON TABLE Detailed_neck_accessories TO costumier;
GRANT SELECT ON TABLE Detailed_head_accessories TO costumier;
GRANT SELECT ON TABLE Detailed_belts TO costumier;
GRANT SELECT ON TABLE Detailed_pants TO costumier;
GRANT SELECT ON TABLE Detailed_shirts TO costumier;
GRANT SELECT ON TABLE Costume_with_costume_items_name TO costumier;
GRANT SELECT ON TABLE Costume_item_count_by_collection_and_class TO costumier;
GRANT SELECT ON TABLE Costume_item_count_by_class TO costumier;
GRANT SELECT ON TABLE Current_rentals_count_by_costume_item_class TO costumier;
GRANT SELECT ON TABLE Current_rentals_count_by_user_function TO costumier;
GRANT SELECT ON TABLE Detailed_rentals TO costumier;
GRANT SELECT ON TABLE Detailed_current_rentals TO costumier;
GRANT SELECT ON TABLE Colors TO costumier;
GRANT SELECT ON TABLE Collections TO costumier;
GRANT SELECT ON TABLE Patterns TO costumier;
GRANT SELECT ON TABLE Genders TO costumier;
GRANT SELECT ON TABLE Head_accessory_categories TO costumier;



CREATE ROLE mamager WITH LOGIN PASSWORD 'jydseF75@#cBjuF$%sufAQ3%nF^*KpHF0';
GRANT EXECUTE ON FUNCTION get_user_function_percentage TO mamager;
GRANT EXECUTE ON PROCEDURE add_country TO mamager;
GRANT EXECUTE ON PROCEDURE add_region TO mamager;
GRANT EXECUTE ON PROCEDURE add_settlement TO mamager;
GRANT EXECUTE ON PROCEDURE add_location TO mamager;
GRANT EXECUTE ON PROCEDURE add_gender TO mamager;
GRANT EXECUTE ON PROCEDURE add_role TO mamager;
GRANT EXECUTE ON PROCEDURE add_type_of_voice TO mamager;
GRANT EXECUTE ON PROCEDURE add_type_of_instrument TO mamager;
GRANT EXECUTE ON PROCEDURE add_dance TO mamager;
GRANT EXECUTE ON PROCEDURE add_state_of_request TO mamager;
GRANT EXECUTE ON PROCEDURE add_user TO mamager;
GRANT EXECUTE ON PROCEDURE make_user_costumier TO mamager;
GRANT EXECUTE ON PROCEDURE make_user_dancer TO mamager;
GRANT EXECUTE ON PROCEDURE make_user_musician TO mamager;
GRANT EXECUTE ON PROCEDURE make_user_singer TO mamager;
GRANT EXECUTE ON PROCEDURE add_voice_to_singer TO mamager;
GRANT EXECUTE ON PROCEDURE add_instrument_to_musician TO mamager;
GRANT EXECUTE ON PROCEDURE add_dance_to_dancer TO mamager;
GRANT SELECT ON TABLE Current_rentals_count_by_user_function TO mamager;
GRANT SELECT ON TABLE User_count_by_settlement TO mamager;
GRANT SELECT ON TABLE User_function_counts TO mamager;
GRANT SELECT ON TABLE Detailed_users TO mamager;
GRANT SELECT ON TABLE Detailed_singers TO mamager;
GRANT SELECT ON TABLE Detailed_musicians TO mamager;
GRANT SELECT ON TABLE Detailed_dancers TO mamager;
GRANT SELECT ON TABLE Singer_count_by_voice_type TO mamager;
GRANT SELECT ON TABLE Musician_count_by_instrument_type TO mamager;
GRANT SELECT ON TABLE Dancer_count_by_dance_type TO mamager;
GRANT SELECT ON TABLE Countries TO mamager;
GRANT SELECT ON TABLE Regions TO mamager;
GRANT SELECT ON TABLE Settlements TO mamager;
GRANT SELECT ON TABLE Locations TO mamager;
GRANT SELECT ON TABLE Genders TO mamager;
GRANT SELECT ON TABLE Users TO mamager;
GRANT SELECT ON TABLE Roles TO mamager;
GRANT SELECT ON TABLE Types_of_voices TO mamager;
GRANT SELECT ON TABLE Types_of_instruments TO mamager;
GRANT SELECT ON TABLE Dances TO mamager;
GRANT SELECT ON TABLE Costumiers TO mamager;
GRANT SELECT ON TABLE Singers TO mamager;
GRANT SELECT ON TABLE Singer_voices TO mamager;
GRANT SELECT ON TABLE Musicians TO mamager;
GRANT SELECT ON TABLE Musician_instrument TO mamager;
GRANT SELECT ON TABLE Dancers TO mamager;
GRANT SELECT ON TABLE Dancer_dance TO mamager;



CREATE ROLE para_admin WITH LOGIN PASSWORD 'jydseF75@#cBjuF$%sufAQ3%nF^*KpHF0';
GRANT EXECUTE ON FUNCTION get_user_unresolved_borrow_requests TO para_admin;
GRANT EXECUTE ON FUNCTION get_user_current_rentals TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_aprons TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_boots TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_petticoats TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_skirts TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_caftans TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_corsets TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_neck_accessories TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_head_accessories TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_belts TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_pants TO para_admin;
GRANT EXECUTE ON FUNCTION get_fits_shirts TO para_admin;
GRANT EXECUTE ON FUNCTION get_user_unread_notifications TO para_admin;
GRANT EXECUTE ON FUNCTION get_user_unclosed_costume_item_requests TO para_admin;
GRANT EXECUTE ON FUNCTION get_costume_item_rental_history TO para_admin;
GRANT EXECUTE ON FUNCTION get_user_rental_history TO para_admin;
GRANT EXECUTE ON FUNCTION get_costumier_unresolved_requests TO para_admin;
GRANT EXECUTE ON FUNCTION get_user_function_percentage TO para_admin;
GRANT EXECUTE ON PROCEDURE add_rental_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE add_return_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE add_borrow_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE delete_request TO para_admin;
GRANT EXECUTE ON PROCEDURE accept_borrow_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE deny_borrow_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE borrow_costume_item TO para_admin;
GRANT EXECUTE ON PROCEDURE add_apron TO para_admin;
GRANT EXECUTE ON PROCEDURE add_head_accessory TO para_admin;
GRANT EXECUTE ON PROCEDURE add_caftan TO para_admin;
GRANT EXECUTE ON PROCEDURE add_petticoat TO para_admin;
GRANT EXECUTE ON PROCEDURE add_corset TO para_admin;
GRANT EXECUTE ON PROCEDURE add_skirt TO para_admin;
GRANT EXECUTE ON PROCEDURE add_belt TO para_admin;
GRANT EXECUTE ON PROCEDURE add_shirt TO para_admin;
GRANT EXECUTE ON PROCEDURE add_pants TO para_admin;
GRANT EXECUTE ON PROCEDURE add_boots TO para_admin;
GRANT EXECUTE ON PROCEDURE add_neck_accessory TO para_admin;
GRANT EXECUTE ON PROCEDURE add_apron TO para_admin;
GRANT EXECUTE ON PROCEDURE update_head_accessory TO para_admin;
GRANT EXECUTE ON PROCEDURE update_caftan TO para_admin;
GRANT EXECUTE ON PROCEDURE update_petticoat TO para_admin;
GRANT EXECUTE ON PROCEDURE update_corset TO para_admin;
GRANT EXECUTE ON PROCEDURE update_skirt TO para_admin;
GRANT EXECUTE ON PROCEDURE update_belt TO para_admin;
GRANT EXECUTE ON PROCEDURE update_shirt TO para_admin;
GRANT EXECUTE ON PROCEDURE update_pants TO para_admin;
GRANT EXECUTE ON PROCEDURE update_boots TO para_admin;
GRANT EXECUTE ON PROCEDURE update_neck_accessory TO para_admin;
GRANT EXECUTE ON PROCEDURE add_costume TO para_admin;
GRANT EXECUTE ON PROCEDURE update_costume_item_location TO para_admin;
GRANT EXECUTE ON PROCEDURE accept_rental_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE accept_return_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE deny_rental_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE deny_return_costume_item_request TO para_admin;
GRANT EXECUTE ON PROCEDURE rent_costume_item TO para_admin;
GRANT EXECUTE ON PROCEDURE return_costume_item TO para_admin;
GRANT EXECUTE ON PROCEDURE add_color TO para_admin;
GRANT EXECUTE ON PROCEDURE add_collection TO para_admin;
GRANT EXECUTE ON PROCEDURE add_pattern TO para_admin;
GRANT EXECUTE ON PROCEDURE add_head_accessory_category TO para_admin;
GRANT EXECUTE ON PROCEDURE add_country TO para_admin;
GRANT EXECUTE ON PROCEDURE add_region TO para_admin;
GRANT EXECUTE ON PROCEDURE add_settlement TO para_admin;
GRANT EXECUTE ON PROCEDURE add_location TO para_admin;
GRANT EXECUTE ON PROCEDURE add_gender TO para_admin;
GRANT EXECUTE ON PROCEDURE add_role TO para_admin;
GRANT EXECUTE ON PROCEDURE add_type_of_voice TO para_admin;
GRANT EXECUTE ON PROCEDURE add_type_of_instrument TO para_admin;
GRANT EXECUTE ON PROCEDURE add_dance TO para_admin;
GRANT EXECUTE ON PROCEDURE add_state_of_request TO para_admin;
GRANT EXECUTE ON PROCEDURE add_user TO para_admin;
GRANT EXECUTE ON PROCEDURE make_user_costumier TO para_admin;
GRANT EXECUTE ON PROCEDURE make_user_dancer TO para_admin;
GRANT EXECUTE ON PROCEDURE make_user_musician TO para_admin;
GRANT EXECUTE ON PROCEDURE make_user_singer TO para_admin;
GRANT EXECUTE ON PROCEDURE add_voice_to_singer TO para_admin;
GRANT EXECUTE ON PROCEDURE add_instrument_to_musician TO para_admin;
GRANT EXECUTE ON PROCEDURE add_dance_to_dancer TO para_admin;
GRANT SELECT ON TABLE Detailed_aprons TO para_admin;
GRANT SELECT ON TABLE Detailed_boots TO para_admin;
GRANT SELECT ON TABLE Detailed_petticoats TO para_admin;
GRANT SELECT ON TABLE Detailed_skirts TO para_admin;
GRANT SELECT ON TABLE Detailed_caftans TO para_admin;
GRANT SELECT ON TABLE Detailed_corsets TO para_admin;
GRANT SELECT ON TABLE Detailed_neck_accessories TO para_admin;
GRANT SELECT ON TABLE Detailed_head_accessories TO para_admin;
GRANT SELECT ON TABLE Detailed_belts TO para_admin;
GRANT SELECT ON TABLE Detailed_pants TO para_admin;
GRANT SELECT ON TABLE Detailed_shirts TO para_admin;
GRANT SELECT ON TABLE Costume_with_costume_items_name TO para_admin;
GRANT SELECT ON TABLE Costume_item_count_by_collection_and_class TO para_admin;
GRANT SELECT ON TABLE Costume_item_count_by_class TO para_admin;
GRANT SELECT ON TABLE Current_rentals_count_by_costume_item_class TO para_admin;
GRANT SELECT ON TABLE Current_rentals_count_by_user_function TO para_admin;
GRANT SELECT ON TABLE Detailed_rentals TO para_admin;
GRANT SELECT ON TABLE Detailed_current_rentals TO para_admin;
GRANT SELECT ON TABLE User_count_by_settlement TO para_admin;
GRANT SELECT ON TABLE User_function_counts TO para_admin;
GRANT SELECT ON TABLE Detailed_users TO para_admin;
GRANT SELECT ON TABLE Detailed_singers TO para_admin;
GRANT SELECT ON TABLE Detailed_musicians TO para_admin;
GRANT SELECT ON TABLE Detailed_dancers TO para_admin;
GRANT SELECT ON TABLE Singer_count_by_voice_type TO para_admin;
GRANT SELECT ON TABLE Musician_count_by_instrument_type TO para_admin;
GRANT SELECT ON TABLE Dancer_count_by_dance_type TO para_admin;
GRANT SELECT ON TABLE Not_read_notifications TO para_admin;
GRANT SELECT ON TABLE Detailed_rental_costume_item_requests TO para_admin;
GRANT SELECT ON TABLE Detailed_return_costume_item_requests TO para_admin;
GRANT SELECT ON TABLE Detailed_borrow_costume_item_requests TO para_admin;
GRANT SELECT ON TABLE Detailed_costume_item_requests TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Colors TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Collections TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Patterns TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Head_accessory_categories TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Countries TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Regions TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Settlements TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Locations TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Genders TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Users TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Roles TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Types_of_voices TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Types_of_instruments TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Dances TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Costumiers TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Singers TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Singer_voices TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Musicians TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Musician_instrument TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Dancers TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Dancer_dance TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Costumes_items TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Head_accessories TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Aprons TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Caftans TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Petticoats TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Corsets TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Skirts TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Belts TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Shirts TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Pants TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Boots TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Neck_accessories TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Costumes TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE States_of_requests TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Requests TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Rental_costume_item_requests TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Return_costume_item_requests TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Borrow_costume_item_requests TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Notifications TO para_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE Rentals TO para_admin;
