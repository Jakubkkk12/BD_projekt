import psycopg2


# Funkcja do wykonania testów
def run_tests(connection, query, data):
    results = []
    with connection.cursor() as cursor:
        for i, record in enumerate(data):
            try:
                cursor.execute(query, record)
                connection.commit()
                results.append((i + 1, "SUCCESS", None))
            except psycopg2.Error as e:
                connection.rollback()
                results.append((i + 1, "FAILURE", str(e)))
    return results

# Połączenie z bazą danych
conn = psycopg2.connect(
    dbname="postgres",
    user="postgres",
    password="filip2002",
    host="localhost"
)

# Testy dla każdej procedury
test_cases = {
    "add_country": {
        "query": "CALL add_country(%s::VARCHAR);",
        "data": [
            ('Polska',),
            ('Francja',),
            ('Australia',),
            ('Polska',),
            ('',),
            ('Polska' * 20,)
        ]
    },
    "add_region": {
        "query": "CALL add_region(%s::VARCHAR,%s::SMALLINT);",
        "data": [
            ('Malopolska', 1),
            ('Lombardia', 23),
            ('Lombardia', 2),
            ('Malopolska', 1),
            ('Skibidi', 3),
            ('Malopolska' * 20, 1),
        ]
    },
    "add_settlement": {
        "query": "CALL add_settlement(%s::VARCHAR,%s::SMALLINT);",
        "data": [
            ('Krakow', 2),
            ('Prayz', 2),
            ('Krakow', 2),
            ('Prayz', 7),
            ('Krakow' * 20, 2),
        ]
    },
    "add_location": {
        "query": "CALL add_location(%s::VARCHAR,%s::SMALLINT,%s::VARCHAR,%s::SMALLINT);",
        "data": [
            ('ulica1', 2, '30-001', 1),
            ('ulica2', 3, '40-002', 2),
            ('ulica1', 2, '30-001', 1),
            ('ulica3', 7, '40-003', 2),
            ('ulica4' * 20, 15, '12-3456', 1),
        ]
    },
    "add_gender": {
        "query": "CALL add_gender(%s::VARCHAR);",
        "data": [
            (None,),
            ('A very long gender name that exceeds 25 characters',),
            ('Male',),
            ('Female',),
            ('Non-Binary',),
            ('Transgender',),
            ('',)
        ]
    },
    "add_role": {
        "query": "CALL add_role(%s::VARCHAR);",
        "data": [
            (None,),
            ('A very long role name that exceeds 20 characters',),
            ('Admin',),
            ('User',),
            ('Guest',),
            ('Superuser',),
            ('Manager',),
            ('LongRoleNameExceedingMaxLength',)
        ]
    },
    "add_type_of_voice": {
        "query": "CALL add_type_of_voice(%s::VARCHAR);",
        "data": [
            (None,),
            ('A very long type of voice',),
            ('Male',),
            ('Female',),
            ('Child',),
            ('Bass',),
            ('Alto',),
            ('VeryLongVoiceName',)
        ]
    },
    "add_type_of_instrument": {
        "query": "CALL add_type_of_instrument(%s::VARCHAR);",
        "data": [
            (None,),
            ('A very long type of instrument',),
            ('Guitar',),
            ('Piano',),
            ('Violin',),
            ('Flute',),
            ('Drums',),
            ('Keyboard',)
        ]
    },
    "add_dance": {
        "query": "CALL add_dance(%s::VARCHAR);",
        "data": [
            (None,),
            ('A very long dance name',),
            ('Waltz',),
            ('Tango',),
            ('Salsa',),
            ('Ballet',),
            ('Cha Cha',),
            ('Foxtrot',)
        ]
    },
    "add_color": {
        "query": "CALL add_color(%s::VARCHAR);",
        "data": [
            (None,),
            ('A very long color name that exceeds the limit',),
            ('Red',),
            ('Blue',),
            ('Green',),
            ('Yellow',),
            ('Purple',),
            ('Orange',)
        ]
    },
    "add_collection": {
        "query": "CALL add_collection(%s::VARCHAR);",
        "data": [
            (None,),
            ('Tancerz_Styl_Gala',),
            ('Sukienki_Baletowe',),
            ('Garnitury_Taneczne',),
            ('Strój_Hip_Hopowy',),
            ('Ballet_Outfits',),
            ('Styl_Street_Style',),
            ('Dance_Collection_2024',),
            ('Sukienki_Party_Tancerzy',)
        ]
    },
    "add_pattern": {
        "query": "CALL add_pattern(%s::VARCHAR);",
        "data": [
            (None,),
            ('Czarny_Pas' * 4,),
            ('Kropeczki',),
            ('Paski_Szerokie',),
            ('Krata',),
            ('Kwiatki_Lato',),
            ('Motyw_Paski',),
            ('Zygzaki',),
            ('Tropikalne_Kwiaty',)
        ]
    },
    "add_head_accessory_category": {
        "query": "CALL add_head_accessory_category(%s::VARCHAR(20));",
        "data": [
            ("Hat", ), # Poprawny rekord - Przykład dla kategorii "Hat"
            ("Cap",  ),# Poprawny rekord - Przykład dla kategorii "Cap"
            ("Bandana", ), # Poprawny rekord - Przykład dla kategorii "Bandana"
            ("Headband", ), # Poprawny rekord - Przykład dla kategorii "Headband"
            ("Helmet",  ),# Poprawny rekord - Przykład dla kategorii "Helmet"

            # Rekord z błędem: Brak p_head_accessory_category_name (NULL)
            (None),  # Błąd: Parametr p_head_accessory_category_name = NULL

            # Rekord z błędem: Zbyt długa nazwa (więcej niż 20 znaków)
            ("SuperDuperExtraLongHatCategoryName", ), # Błąd: Nazwa kategorie przekracza 20 znaków

            # Rekord z błędem: Nazwa kategorii już istnieje
            ("Hat",)  # Błąd: Kategoria o nazwie "Hat" już istnieje
        ]
    },
    "add_state_of_request": {
        "query": "CALL add_state_of_request(%s::VARCHAR(15));",
        "data": [
            ("New",),  # Poprawny rekord - Przykład dla stanu "New"
            ("In Progress",),  # Poprawny rekord - Przykład dla stanu "In Progress"
            ("Completed",),  # Poprawny rekord - Przykład dla stanu "Completed"
            ("Pending", ), # Poprawny rekord - Przykład dla stanu "Pending"
            ("Rejected", ), # Poprawny rekord - Przykład dla stanu "Rejected"

            # Rekord z błędem: Brak p_state_of_request_name (NULL)
            (None),  # Błąd: Parametr p_state_of_request_name = NULL

            # Rekord z błędem: Zbyt długa nazwa (więcej niż 15 znaków)
            ("SuperLongStateName",),  # Błąd: Nazwa stanu przekracza 15 znaków

            # Rekord z błędem: Nazwa stanu już istnieje
            ("New", ), # Błąd: Stan o nazwie "New" już istnieje
        ]
    },
    "add_user": {
        "query": """CALL add_user(
            %s::VARCHAR, %s::VARCHAR, %s::DATE, %s::VARCHAR, %s::VARCHAR, 
            %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, 
            %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::FLOAT);""",
        "data": [
            ("Jan", "Kowalski", "1990-01-01", "jan.kowalski@example.com", "+48123456789", 1, 1, 180, 80, 100, 55, 40, 90, 40, 50, 42.5),
            ("Anna", "Nowak", "1985-05-15", "anna.nowak@example.com", "+48234567890", 2, 2, 160, 70, 90, 55, 35, 85, 38, 45, 38.0),
            ("Patryk", "Zieliński", "1992-12-20", "patryk.zielinski.com", "+48501234567", 1, 3, 175, 85, 95, 56, 42, 88, 41, 48, 43.0),
            ("Kasia", "Wiśniewska", "1997-03-10", "kasia.wisniewska@example.com", "+48123", 2, 4, 165, 65, 85, 54, 38, 86, 39, 46, 37.0),
            (None, "Nowak", "1985-05-15", "anna.nowak@example.com", "+48234567890", 2, 2, 160, 70, 90, 55, 35, 85, 38, 45, 38.0),
            ("Jan", "Kowalski", "1990-01-01", "jan.kowalski@example.com", "+48123456789", 999, 1, 180, 80, 100, 55, 40, 90, 40, 50, 42.5),
        ]
    },
    "make_user_costumier": {
        "query": "CALL make_user_costumier(%s::INTEGER,%s::SMALLINT,%s::SMALLINT);",
        "data": [
            (1, 1, 1),  # Poprawny rekord - Settlement ID 1
            (2, 1, 23),
            (999, 1, 3),
            (1, 1, 1)
        ]
    },
    "make_user_singer":{
        "query": "CALL make_user_singer(%s::INTEGER,%s::SMALLINT);",
        "data": [
            (1, 1, ),  # Poprawny rekord - Settlement ID 1
            (2, 23, ),
            (999, 1, ),
            (1, 1,)
        ]
    },
    "make_user_musician":{
        "query": "CALL make_user_musician(%s::INTEGER,%s::SMALLINT);",
        "data": [
            (1, 1,),  # Poprawny rekord - Settlement ID 1
            (2, 23,),
            (999, 1,),
            (1, 1,)
        ]
    },
    "make_user_dancer":{
        "query": "CALL make_user_dancer(%s::INTEGER,%s::SMALLINT);",
        "data": [
            (1, 1, ),  # Poprawny rekord - Settlement ID 1
            (2, 23, ),
            (999, 1, ),
            (1, 1,)
        ]
    },
    "add_voice_to_singer":{
        "query": "CALL add_voice_to_singer(%s::INTEGER,%s::SMALLINT);",
        "data": [
            (1, 1,),  # Poprawny rekord - Settlement ID 1
            (2, 23,),
            (999, 1,),
            (1, 1,)
        ]
    },
    "add_instrument_to_musician":{
        "query": "CALL add_instrument_to_musician(%s::INTEGER,%s::SMALLINT);",
        "data": [
            (1, 1,),  # Poprawny rekord - Settlement ID 1
            (2, 23,),
            (999, 1,),
            (1, 1,)
        ]
    },
    "add_dance_to_dancer":{
        "query": "CALL add_dance_to_dancer(%s::INTEGER,%s::SMALLINT);",
        "data": [
            (1, 1,),  # Poprawny rekord - Settlement ID 1
            (2, 23,),
            (999, 1,),
            (1, 1,)
        ]
    },
    "add_apron": {
    "query": "CALL add_apron(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
    "data": [
        ("Apron1", 1, 1, 1, 1, 10, 1),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
        ("Apron2", 2, 2, 2, 2, 12, 3),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

        # Rekord z błędem: Brak Collection_id (null)
        (None, 1, 1, 1, 1, 10, 1),        # Błąd: Parametr p_apron_name = null

        # Rekord z błędem: Nieistniejący collection_id
        ("Apron3", 10, 1, 1, 1, 10, 1),   # Błąd: Collection z id 10 nie istnieje

        # Rekord z błędem: Nieistniejący gender_id
        ("Apron4", 1, 99, 1, 1, 10, 1),   # Błąd: Gender z id 99 nie istnieje

        # Rekord z błędem: Nieistniejący color_id
        ("Apron5", 1, 1, 99, 1, 10, 1),   # Błąd: Color z id 99 nie istnieje

        # Rekord z błędem: Nieistniejący location_id
        ("Apron6", 1, 1, 1, 99, 10, 1),   # Błąd: Location z id 99 nie istnieje

        # Rekord z błędem: Długość fartucha <= 0
        ("Apron7", 1, 1, 1, 1, 0, 1),     # Błąd: p_apron_length <= 0

        # Rekord z błędem: Zbyt długa nazwa fartucha
        ("Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 1, 1, 1, 1, 10, 1),  # Błąd: Nazwa fartucha ma więcej niż 30 znaków

        # Rekord z błędem: Fartuch o tej nazwie już istnieje
        ("Apron1", 2, 1, 1, 1, 10, 1)      # Błąd: Fartuch o nazwie "Apron1" już istnieje
        ]
    },
    "add_head_accessory": {
        "query": "CALL add_head_accessory(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("HeadAccessory1", 1, 1, 1, 1, 55, 1),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1, Head Circumference 55, Category 1
            ("HeadAccessory2", 2, 2, 2, 2, 58, 2),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2, Head Circumference 58, Category 2

            # Rekord z błędem: Brak Collection_id (None)
            (None, 1, 1, 1, 1, 55, 1),        # Błąd: Parametr p_head_accessory_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("HeadAccessory3", 10, 1, 1, 1, 55, 1),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("HeadAccessory4", 1, 99, 1, 1, 55, 1),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("HeadAccessory5", 1, 1, 99, 1, 55, 1),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("HeadAccessory6", 1, 1, 1, 99, 55, 1),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący category_id
            ("HeadAccessory7", 1, 1, 1, 1, 55, 99),  # Błąd: Category z id 99 nie istnieje

            # Rekord z błędem: Długość obwodu głowy <= 0
            ("HeadAccessory8", 1, 1, 1, 1, -5, 1),   # Błąd: p_head_accessory_head_circumference <= 0

            # Rekord z błędem: Zbyt długa nazwa akcesorium
            ("A" + "A" * 31, 1, 1, 1, 1, 55, 1),  # Błąd: Nazwa akcesorium ma więcej niż 30 znaków

            # Rekord z błędem: Akcesorium o tej nazwie już istnieje
            ("HeadAccessory1", 2, 1, 1, 1, 55, 1)     # Błąd: Akcesorium o nazwie "HeadAccessory1" już istnieje
        ]
    },
    "add_caftan": {
        "query": "CALL add_caftan(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("Caftan1", 1, 1, 1, 1, 100, 70, 90, 80, 100),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Caftan2", 2, 2, 2, 2, 110, 75, 95, 85, 105),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak Collection_id (None)
            (None, 1, 1, 1, 1, 100, 70, 90, 80, 100),        # Błąd: Parametr p_caftan_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Caftan3", 10, 1, 1, 1, 100, 70, 90, 80, 100),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Caftan4", 1, 99, 1, 1, 100, 70, 90, 80, 100),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Caftan5", 1, 1, 99, 1, 100, 70, 90, 80, 100),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Caftan6", 1, 1, 1, 99, 100, 70, 90, 80, 100),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów
            ("Caftan7", 1, 1, 1, 1, 100, 70, None, 80, 100),  # Błąd: p_caftan_max_waist_circumference = None

            # Rekord z błędem: Długość caftana <= 0
            ("Caftan8", 1, 1, 1, 1, 0, 70, 90, 80, 100),     # Błąd: p_caftan_length <= 0

            # Rekord z błędem: Zbyt mała wartość dla min_waist_circumference
            ("Caftan9", 1, 1, 1, 1, 100, -10, 90, 80, 100),  # Błąd: p_caftan_min_waist_circumference <= 0

            # Rekord z błędem: max_waist_circumference < min_waist_circumference
            ("Caftan10", 1, 1, 1, 1, 100, 80, 70, 80, 100),  # Błąd: p_caftan_max_waist_circumference < p_caftan_min_waist_circumference

            # Rekord z błędem: Zbyt długa nazwa caftana
            ("C" + "C" * 31, 1, 1, 1, 1, 100, 70, 90, 80, 100),  # Błąd: Nazwa caftana ma więcej niż 30 znaków

            # Rekord z błędem: Caftan o tej nazwie już istnieje
            ("Caftan1", 2, 1, 1, 1, 100, 70, 90, 80, 100)     # Błąd: Caftan o nazwie "Caftan1" już istnieje
        ]
    },
    "add_petticoat": {
        "query": "CALL add_petticoat(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("Petticoat1", 1, 1, 1, 1, 100, 70, 90),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Petticoat2", 2, 2, 2, 2, 110, 75, 95),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak petticoat_name (None)
            (None, 1, 1, 1, 1, 100, 70, 90),        # Błąd: Parametr p_petticoat_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Petticoat3", 10, 1, 1, 1, 100, 70, 90),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Petticoat4", 1, 99, 1, 1, 100, 70, 90),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Petticoat5", 1, 1, 99, 1, 100, 70, 90),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Petticoat6", 1, 1, 1, 99, 100, 70, 90),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów (null)
            ("Petticoat7", 1, 1, 1, 1, 100, 70, None),  # Błąd: p_petticoat_max_waist_circumference = None

            # Rekord z błędem: Długość petticoat <= 0
            ("Petticoat8", 1, 1, 1, 1, 0, 70, 90),     # Błąd: p_petticoat_length <= 0

            # Rekord z błędem: Zbyt mała wartość dla min_waist_circumference
            ("Petticoat9", 1, 1, 1, 1, 100, -10, 90),  # Błąd: p_petticoat_min_waist_circumference <= 0

            # Rekord z błędem: max_waist_circumference < min_waist_circumference
            ("Petticoat10", 1, 1, 1, 1, 100, 80, 70),  # Błąd: p_petticoat_max_waist_circumference < p_petticoat_min_waist_circumference

            # Rekord z błędem: Zbyt długa nazwa petticoat
            ("P" + "P" * 31, 1, 1, 1, 1, 100, 70, 90),  # Błąd: Nazwa petticoat ma więcej niż 30 znaków

            # Rekord z błędem: Petticoat o tej nazwie już istnieje
            ("Petticoat1", 2, 1, 1, 1, 100, 70, 90)     # Błąd: Petticoat o nazwie "Petticoat1" już istnieje
        ]
    },
    "add_corset": {
        "query": "CALL add_corset(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("Corset1", 1, 1, 1, 1, 100, 70, 90, 80, 100),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Corset2", 2, 2, 2, 2, 110, 75, 95, 85, 105),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak corset_name (None)
            (None, 1, 1, 1, 1, 100, 70, 90, 80, 100),        # Błąd: Parametr p_corset_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Corset3", 10, 1, 1, 1, 100, 70, 90, 80, 100),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Corset4", 1, 99, 1, 1, 100, 70, 90, 80, 100),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Corset5", 1, 1, 99, 1, 100, 70, 90, 80, 100),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Corset6", 1, 1, 1, 99, 100, 70, 90, 80, 100),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów (null)
            ("Corset7", 1, 1, 1, 1, 100, 70, 90, 80, None),  # Błąd: p_corset_max_chest_circumference = None

            # Rekord z błędem: Długość corset <= 0
            ("Corset8", 1, 1, 1, 1, 0, 70, 90, 80, 100),     # Błąd: p_corset_length <= 0

            # Rekord z błędem: Zbyt mała wartość dla min_waist_circumference
            ("Corset9", 1, 1, 1, 1, 100, -10, 90, 80, 100),  # Błąd: p_corset_min_waist_circumference <= 0

            # Rekord z błędem: max_waist_circumference < min_waist_circumference
            ("Corset10", 1, 1, 1, 1, 100, 80, 70, 80, 100),  # Błąd: p_corset_max_waist_circumference < p_corset_min_waist_circumference

            # Rekord z błędem: Zbyt długa nazwa corset
            ("C" + "C" * 31, 1, 1, 1, 1, 100, 70, 90, 80, 100),  # Błąd: Nazwa corset ma więcej niż 30 znaków

            # Rekord z błędem: Corset o tej nazwie już istnieje
            ("Corset1", 2, 1, 1, 1, 100, 70, 90, 80, 100)     # Błąd: Corset o nazwie "Corset1" już istnieje
        ]
    },
    "add_skirt": {
        "query": "CALL add_skirt(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("Skirt1", 1, 1, 1, 1, 100, 70, 90),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Skirt2", 2, 2, 2, 2, 110, 75, 95),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak skirt_name (None)
            (None, 1, 1, 1, 1, 100, 70, 90),      # Błąd: Parametr p_skirt_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Skirt3", 10, 1, 1, 1, 100, 70, 90), # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Skirt4", 1, 99, 1, 1, 100, 70, 90), # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Skirt5", 1, 1, 99, 1, 100, 70, 90), # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Skirt6", 1, 1, 1, 99, 100, 70, 90), # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów (null)
            ("Skirt7", 1, 1, 1, 1, 100, 70, None), # Błąd: p_skirt_max_waist_circumference = None

            # Rekord z błędem: Długość skirt <= 0
            ("Skirt8", 1, 1, 1, 1, 0, 70, 90),    # Błąd: p_skirt_length <= 0

            # Rekord z błędem: Zbyt mała wartość dla min_waist_circumference
            ("Skirt9", 1, 1, 1, 1, 100, -10, 90), # Błąd: p_skirt_min_waist_circumference <= 0

            # Rekord z błędem: max_waist_circumference < min_waist_circumference
            ("Skirt10", 1, 1, 1, 1, 100, 80, 70),  # Błąd: p_skirt_max_waist_circumference < p_skirt_min_waist_circumference

            # Rekord z błędem: Zbyt długa nazwa skirt
            ("S" + "S" * 31, 1, 1, 1, 1, 100, 70, 90),  # Błąd: Nazwa skirt ma więcej niż 30 znaków

            # Rekord z błędem: Skirt o tej nazwie już istnieje
            ("Skirt1", 2, 1, 1, 1, 100, 70, 90)    # Błąd: Skirt o nazwie "Skirt1" już istnieje
        ]
    },
    "add_belt": {
        "query": "CALL add_belt(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("Belt1", 1, 1, 1, 1, 70, 90),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Belt2", 2, 2, 2, 2, 75, 95),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak p_belt_name (None)
            (None, 1, 1, 1, 1, 70, 90),      # Błąd: Parametr p_belt_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Belt3", 10, 1, 1, 1, 70, 90),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Belt4", 1, 99, 1, 1, 70, 90),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Belt5", 1, 1, 99, 1, 70, 90),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Belt6", 1, 1, 1, 99, 70, 90),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów (null)
            ("Belt7", 1, 1, 1, 1, 70, None),  # Błąd: p_belt_max_waist_circumference = None

            # Rekord z błędem: Min waist circumference <= 0
            ("Belt8", 1, 1, 1, 1, -10, 90),  # Błąd: p_belt_min_waist_circumference <= 0

            # Rekord z błędem: Max waist circumference < min waist circumference
            ("Belt9", 1, 1, 1, 1, 70, 60),   # Błąd: p_belt_max_waist_circumference < p_belt_min_waist_circumference

            # Rekord z błędem: Zbyt długa nazwa p_belt_name
            ("B" + "B" * 31, 1, 1, 1, 1, 70, 90),  # Błąd: Nazwa belt ma więcej niż 30 znaków

            # Rekord z błędem: Belt o tej nazwie już istnieje
            ("Belt1", 2, 1, 1, 1, 70, 90)    # Błąd: Belt o nazwie "Belt1" już istnieje
        ]
    },
    "add_shirt": {
        "query": "CALL add_shirt(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT );",
        "data": [
            ("Shirt1", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35, 40),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Shirt2", 2, 2, 2, 2, 75, 65, 75, 95, 42, 47, 36, 40),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak p_shirt_name (None)
            (None, 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35, 40),  # Błąd: Parametr p_shirt_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Shirt3", 10, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35, 40),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Shirt4", 1, 99, 1, 1, 70, 60, 70, 90, 40, 45, 35, 40),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Shirt5", 1, 1, 99, 1, 70, 60, 70, 90, 40, 45, 35, 40),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Shirt6", 1, 1, 1, 99, 70, 60, 70, 90, 40, 45, 35, 40),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów (null)
            ("Shirt7", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, None, 40),  # Błąd: p_shirt_max_neck_circumference = None

            # Rekord z błędem: Arm length <= 0
            ("Shirt8", 1, 1, 1, 1, 70, -10, 70, 90, 40, 45, 35, 40),  # Błąd: p_shirt_arm_length <= 0

            # Rekord z błędem: Min waist circumference <= 0
            ("Shirt9", 1, 1, 1, 1, 70, 60, -10, 90, 40, 45, 35, 40),  # Błąd: p_shirt_min_waist_circumference <= 0

            # Rekord z błędem: Max waist circumference < min waist circumference
            ("Shirt10", 1, 1, 1, 1, 70, 60, 50, 40, 40, 45, 35, 40),  # Błąd: p_shirt_max_waist_circumference < p_shirt_min_waist_circumference

            # Rekord z błędem: Max chest circumference < min chest circumference
            ("Shirt11", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 36, 40),  # Błąd: p_shirt_max_chest_circumference < p_shirt_min_chest_circumference

            # Rekord z błędem: Max neck circumference < min neck circumference
            ("Shirt12", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 30, 29),  # Błąd: p_shirt_max_neck_circumference < p_shirt_min_neck_circumference

            # Rekord z błędem: Zbyt długa nazwa p_shirt_name
            ("Sssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35, 40),  # Błąd: Nazwa shirt ma więcej niż 30 znaków

            # Rekord z błędem: Shirt o tej nazwie już istnieje
            ("Shirt1", 2, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35, 40)   # Błąd: Shirt o nazwie "Shirt1" już istnieje
        ]
    },
    "add_pants": {
        "query": "CALL add_pants(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("Pants1", 1, 1, 1, 1, 100, 70, 90),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Pants2", 2, 2, 2, 2, 105, 75, 95),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak p_pants_name (None)
            (None, 1, 1, 1, 1, 100, 70, 90),  # Błąd: Parametr p_pants_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Pants3", 10, 1, 1, 1, 100, 70, 90),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Pants4", 1, 99, 1, 1, 100, 70, 90),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Pants5", 1, 1, 99, 1, 100, 70, 90),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Pants6", 1, 1, 1, 99, 100, 70, 90),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów (null)
            ("Pants7", 1, 1, 1, 1, 100, 70, None),  # Błąd: p_pants_max_waist_circumference = None

            # Rekord z błędem: Length <= 0
            ("Pants8", 1, 1, 1, 1, -1, 70, 90),  # Błąd: p_pants_length <= 0

            # Rekord z błędem: Min waist circumference <= 0
            ("Pants9", 1, 1, 1, 1, 100, -10, 90),  # Błąd: p_pants_min_waist_circumference <= 0

            # Rekord z błędem: Max waist circumference < min waist circumference
            ("Pants10", 1, 1, 1, 1, 100, 110, 90),  # Błąd: p_pants_max_waist_circumference < p_pants_min_waist_circumference

            # Rekord z błędem: Zbyt długa nazwa p_pants_name
            ("P" + "P" * 31, 1, 1, 1, 1, 100, 70, 90),  # Błąd: Nazwa pants ma więcej niż 30 znaków

            # Rekord z błędem: Pants o tej nazwie już istnieje
            ("Pants1", 2, 1, 1, 1, 100, 70, 90)  # Błąd: Pants o nazwie "Pants1" już istnieje
        ]
    },
    "add_boots": {
        "query": "CALL add_boots(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::FLOAT);",
        "data": [
            ("Boots1", 1, 1, 1, 1, 42.5),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1, rozmiar 42.5
            ("Boots2", 2, 2, 2, 2, 38),    # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2, rozmiar 38

            # Rekord z błędem: Brak p_boots_name (None)
            (None, 1, 1, 1, 1, 42.5),  # Błąd: Parametr p_boots_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Boots3", 10, 1, 1, 1, 43),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Boots4", 1, 99, 1, 1, 44),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Boots5", 1, 1, 99, 1, 45),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Boots6", 1, 1, 1, 99, 46),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Shoe size <= 0
            ("Boots7", 1, 1, 1, 1, -1),   # Błąd: p_boots_shoe_size <= 0

            # Rekord z błędem: Zbyt długa nazwa p_boots_name
            ("B" + "B" * 31, 1, 1, 1, 1, 47),  # Błąd: Nazwa boots ma więcej niż 30 znaków

            # Rekord z błędem: Boots o tej nazwie już istnieje
            ("Boots1", 2, 1, 1, 1, 48)  # Błąd: Boots o nazwie "Boots1" już istnieje
        ]
    },
    "add_neck_accessory": {
        "query": "CALL add_neck_accessory(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("NeckAccessory1", 1, 1, 1, 1, 30, 40),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1, min/max waist circumference 30-40
            ("NeckAccessory2", 2, 2, 2, 2, 25, 35),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2, min/max waist circumference 25-35

            # Rekord z błędem: Brak p_neck_accessory_name (None)
            (None, 1, 1, 1, 1, 30, 40),  # Błąd: Parametr p_neck_accessory_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("NeckAccessory3", 10, 1, 1, 1, 30, 40),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("NeckAccessory4", 1, 99, 1, 1, 30, 40),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("NeckAccessory5", 1, 1, 99, 1, 30, 40),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("NeckAccessory6", 1, 1, 1, 99, 30, 40),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Min waist circumference <= 0
            ("NeckAccessory7", 1, 1, 1, 1, 0, 40),  # Błąd: p_neck_accessory_min_waist_circumference <= 0

            # Rekord z błędem: Max waist circumference < min waist circumference
            ("NeckAccessory8", 1, 1, 1, 1, 45, 40),  # Błąd: p_neck_accessory_max_waist_circumference < p_neck_accessory_min_waist_circumference

            # Rekord z błędem: Zbyt długa nazwa p_neck_accessory_name
            ("N" + "A" * 31, 1, 1, 1, 1, 30, 40),  # Błąd: Nazwa neck accessory ma więcej niż 30 znaków

            # Rekord z błędem: Neck accessory o tej nazwie już istnieje
            ("NeckAccessory1", 2, 1, 1, 1, 30, 40)  # Błąd: Neck accessory o nazwie "NeckAccessory1" już istnieje
        ]
    },
    "update_apron": {
        "query": "CALL update_apron(%s::INT, %s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawne rekordy
            (1, "ApronA", 1, 1, 1, 1, 120, 1),  # Poprawny rekord: apron_id = 1
            (2, "ApronB", 2, 2, 2, 2, 130, 2),  # Poprawny rekord: apron_id = 2
            (3, "ApronC", 3, 3, 3, 3, 140, 3),  # Poprawny rekord: apron_id = 3

            # Rekord z błędem: Nieistniejący `p_apron_id`
            (999, "ApronD", 1, 1, 1, 1, 120, 1),  # Błąd: `p_apron_id` = 999 nie istnieje

            # Rekord z błędem: `p_apron_id` nie jest fartuszkiem
            (4, "ApronE", 1, 1, 1, 1, 120, 1),  # Błąd: Costume item z id 4 nie jest fartuszkiem

            # Rekord z błędem: Nieistniejący `p_collection_id`
            (1, "ApronF", 10, 1, 1, 1, 120, 1),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący `p_gender_id`
            (1, "ApronG", 1, 99, 1, 1, 120, 1),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_color_id`
            (1, "ApronH", 1, 1, 99, 1, 120, 1),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_location_id`
            (1, "ApronI", 1, 1, 1, 99, 120, 1),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Negatywna długość fartucha
            (1, "ApronJ", 1, 1, 1, 1, -50, 1),  # Błąd: Długość fartucha <= 0

            # Rekord z błędem: Zbyt długa nazwa fartucha
            (1, "ApronTooLongNameThatExceedsThirtyChars", 1, 1, 1, 1, 120, 1),  # Błąd: Nazwa fartucha > 30 znaków

            # Rekord z błędem: Dublowanie nazwy fartucha
            (2, "ApronA", 2, 2, 2, 2, 130, 2)  # Błąd: Nazwa `ApronA` już istnieje dla innego fartucha
        ]
    },
    "update_head_accessory": {
        "query": "CALL update_head_accessory(%s::INT, %s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawne rekordy
            (4, "HatA", 1, 1, 1, 1, 56, 1),  # Poprawny rekord: head_accessory_id = 4
            (5, "HatB", 2, 2, 2, 2, 60, 2),  # Poprawny rekord: head_accessory_id = 5
            (6, "HatC", 3, 3, 3, 3, 58, 3),  # Poprawny rekord: head_accessory_id = 6

            # Rekord z błędem: Nieistniejący `p_head_accessory_id`
            (999, "HatD", 1, 1, 1, 1, 56, 1),  # Błąd: `p_head_accessory_id` = 999 nie istnieje

            # Rekord z błędem: `p_head_accessory_id` nie jest akcesorium głowy
            (7, "HatE", 1, 1, 1, 1, 56, 1),  # Błąd: Costume item z id 7 nie jest akcesorium głowy

            # Rekord z błędem: Nieistniejący `p_collection_id`
            (4, "HatF", 10, 1, 1, 1, 56, 1),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący `p_gender_id`
            (4, "HatG", 1, 99, 1, 1, 56, 1),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_color_id`
            (4, "HatH", 1, 1, 99, 1, 56, 1),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_location_id`
            (4, "HatI", 1, 1, 1, 99, 56, 1),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_category_id`
            (4, "HatJ", 1, 1, 1, 1, 56, 99),  # Błąd: Category z id 99 nie istnieje

            # Rekord z błędem: Ujemny obwód głowy
            (4, "HatK", 1, 1, 1, 1, -5, 1),  # Błąd: Obwód głowy <= 0

            # Rekord z błędem: Zbyt długa nazwa akcesorium głowy
            (4, "HatWithNameThatExceedsThirtyCharacters", 1, 1, 1, 1, 56, 1),  # Błąd: Nazwa > 30 znaków

            # Rekord z błędem: Dublowanie nazwy akcesorium głowy
            (5, "HatA", 2, 2, 2, 2, 60, 2)  # Błąd: Nazwa `HatA` już istnieje dla innego akcesorium
        ]
    },
    "update_caftan": {
        "query": "CALL update_caftan(%s::INT, %s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawne rekordy
            (7, "CaftanA", 1, 1, 1, 1, 120, 50, 70, 60, 80),  # Poprawny rekord: caftan_id = 7
            (8, "CaftanB", 2, 2, 2, 2, 150, 60, 90, 70, 100), # Poprawny rekord: caftan_id = 8
            (9, "CaftanC", 3, 3, 3, 3, 130, 55, 75, 65, 85),  # Poprawny rekord: caftan_id = 9

            # Rekord z błędem: Nieistniejący `p_caftan_id`
            (999, "CaftanD", 1, 1, 1, 1, 120, 50, 70, 60, 80),  # Błąd: `p_caftan_id` = 999 nie istnieje

            # Rekord z błędem: `p_caftan_id` nie jest kaftanem
            (10, "CaftanE", 1, 1, 1, 1, 120, 50, 70, 60, 80),  # Błąd: Costume item z id 10 nie jest kaftanem

            # Rekord z błędem: Nieistniejący `p_collection_id`
            (7, "CaftanF", 10, 1, 1, 1, 120, 50, 70, 60, 80),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący `p_gender_id`
            (7, "CaftanG", 1, 99, 1, 1, 120, 50, 70, 60, 80),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_color_id`
            (7, "CaftanH", 1, 1, 99, 1, 120, 50, 70, 60, 80),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_location_id`
            (7, "CaftanI", 1, 1, 1, 99, 120, 50, 70, 60, 80),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Długość <= 0
            (7, "CaftanJ", 1, 1, 1, 1, 0, 50, 70, 60, 80),  # Błąd: Długość <= 0

            # Rekord z błędem: Min. obwód talii <= 0
            (7, "CaftanK", 1, 1, 1, 1, 120, -10, 70, 60, 80),  # Błąd: Min. obwód talii <= 0

            # Rekord z błędem: Max. obwód talii < Min. obwód talii
            (7, "CaftanL", 1, 1, 1, 1, 120, 70, 50, 60, 80),  # Błąd: Max. < Min. obwód talii

            # Rekord z błędem: Min. obwód klatki <= 0
            (7, "CaftanM", 1, 1, 1, 1, 120, 50, 70, 0, 80),  # Błąd: Min. obwód klatki <= 0

            # Rekord z błędem: Max. obwód klatki < Min. obwód klatki
            (7, "CaftanN", 1, 1, 1, 1, 120, 50, 70, 60, 50),  # Błąd: Max. < Min. obwód klatki

            # Rekord z błędem: Zbyt długa nazwa kaftana
            (7, "CaftanWithNameThatExceedsThirtyCharacters", 1, 1, 1, 1, 120, 50, 70, 60, 80),  # Błąd: Nazwa > 30 znaków

            # Rekord z błędem: Dublowanie nazwy kaftana
            (8, "CaftanA", 2, 2, 2, 2, 150, 60, 90, 70, 100)  # Błąd: Nazwa `CaftanA` już istnieje dla innego kaftana
        ]
    },
    "update_corset": {
        "query": "CALL update_corset(%s::INT, %s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawne rekordy
            (13, "CorsetA", 1, 1, 1, 1, 70, 40, 60, 50, 80),  # Poprawny rekord: corset_id = 13
            (14, "CorsetB", 2, 2, 2, 2, 80, 45, 65, 55, 85), # Poprawny rekord: corset_id = 14

            # Rekord z błędem: Nieistniejący `p_corset_id`
            (999, "CorsetC", 1, 1, 1, 1, 70, 40, 60, 50, 80),  # Błąd: `p_corset_id` = 999 nie istnieje

            # Rekord z błędem: `p_corset_id` nie jest gorsetem
            (15, "CorsetD", 1, 1, 1, 1, 70, 40, 60, 50, 80),  # Błąd: Costume item z id 15 nie jest gorsetem

            # Rekord z błędem: Nieistniejący `p_collection_id`
            (13, "CorsetE", 10, 1, 1, 1, 70, 40, 60, 50, 80),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący `p_gender_id`
            (13, "CorsetF", 1, 99, 1, 1, 70, 40, 60, 50, 80),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_color_id`
            (13, "CorsetG", 1, 1, 99, 1, 70, 40, 60, 50, 80),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_location_id`
            (13, "CorsetH", 1, 1, 1, 99, 70, 40, 60, 50, 80),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Długość <= 0
            (13, "CorsetI", 1, 1, 1, 1, 0, 40, 60, 50, 80),  # Błąd: Długość <= 0

            # Rekord z błędem: Min. obwód talii <= 0
            (13, "CorsetJ", 1, 1, 1, 1, 70, -10, 60, 50, 80),  # Błąd: Min. obwód talii <= 0

            # Rekord z błędem: Max. obwód talii < Min. obwód talii
            (13, "CorsetK", 1, 1, 1, 1, 70, 60, 40, 50, 80),  # Błąd: Max. < Min. obwód talii

            # Rekord z błędem: Min. obwód klatki <= 0
            (13, "CorsetL", 1, 1, 1, 1, 70, 40, 60, 0, 80),  # Błąd: Min. obwód klatki <= 0

            # Rekord z błędem: Max. obwód klatki < Min. obwód klatki
            (13, "CorsetM", 1, 1, 1, 1, 70, 40, 60, 50, 40),  # Błąd: Max. < Min. obwód klatki

            # Rekord z błędem: Zbyt długa nazwa gorsetu
            (13, "CorsetWithNameThatExceedsThirtyCharacters", 1, 1, 1, 1, 70, 40, 60, 50, 80),  # Błąd: Nazwa > 30 znaków

            # Rekord z błędem: Dublowanie nazwy gorsetu
            (14, "CorsetA", 2, 2, 2, 2, 80, 45, 65, 55, 85)  # Błąd: Nazwa `CorsetA` już istnieje dla innego gorsetu
        ]
    },
    "update_skirt": {
        "query": "CALL update_skirt(%s::INT, %s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawne rekordy
            (15, "SkirtA", 1, 1, 1, 1, 70, 40, 60),  # Poprawny rekord: skirt_id = 15
            (16, "SkirtB", 2, 2, 2, 2, 80, 45, 65),  # Poprawny rekord: skirt_id = 16
            (17, "SkirtC", 3, 3, 3, 3, 90, 50, 70),  # Poprawny rekord: skirt_id = 17

            # Rekord z błędem: Nieistniejący `p_skirt_id`
            (999, "SkirtD", 1, 1, 1, 1, 70, 40, 60),  # Błąd: `p_skirt_id` = 999 nie istnieje

            # Rekord z błędem: `p_skirt_id` nie jest spódnicą
            (18, "SkirtE", 1, 1, 1, 1, 70, 40, 60),  # Błąd: Costume item z id 18 nie jest spódnicą

            # Rekord z błędem: Nieistniejący `p_collection_id`
            (15, "SkirtF", 10, 1, 1, 1, 70, 40, 60),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący `p_gender_id`
            (15, "SkirtG", 1, 99, 1, 1, 70, 40, 60),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_color_id`
            (15, "SkirtH", 1, 1, 99, 1, 70, 40, 60),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący `p_location_id`
            (15, "SkirtI", 1, 1, 1, 99, 70, 40, 60),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Długość <= 0
            (15, "SkirtJ", 1, 1, 1, 1, 0, 40, 60),  # Błąd: Długość <= 0

            # Rekord z błędem: Min. obwód talii <= 0
            (15, "SkirtK", 1, 1, 1, 1, 70, -10, 60),  # Błąd: Min. obwód talii <= 0

            # Rekord z błędem: Max. obwód talii < Min. obwód talii
            (15, "SkirtL", 1, 1, 1, 1, 70, 60, 40),  # Błąd: Max. < Min. obwód talii

            # Rekord z błędem: Zbyt długa nazwa spódnicy
            (15, "SkirtWithNameThatExceedsThirtyCharacters", 1, 1, 1, 1, 70, 40, 60),  # Błąd: Nazwa > 30 znaków

            # Rekord z błędem: Dublowanie nazwy spódnicy
            (16, "SkirtA", 2, 2, 2, 2, 80, 45, 65)  # Błąd: Nazwa `SkirtA` już istnieje dla innej spódnicy
        ]
    },
    "update_shirt": {
        "query": "CALL update_shirt(%s::INT, %s::VARCHAR, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawny przypadek
            (1, 'Shirt A', 1, 1, 1, 1, 70, 60, 30, 50, 40, 60, 35, 45),

            # Błędne przypadki - różne wyjątki
            (None, 'Shirt A', 1, 1, 1, 1, 70, 60, 30, 50, 40, 60, 35, 45),  # NULL jako `p_shirt_id`
            (1, 'Shirt A', 1, 1, 1, 1, 70, 60, 30, 50, 40, 60, 35, 45),  # Empty string error (fixed or replaced by valid name)
            (1, 'Shirt B', 1, 1, 1, 1, -10, 60, 30, 50, 40, 60, 35, 45),  # Negatywna długość
            (1, 'Shirt C', 1, 1, 1, 1, 70, -20, 30, 50, 40, 60, 35, 45),  # Negatywna długość rękawa
            (1, 'Shirt D', 1, 1, 1, 1, 70, 60, -5, 50, 40, 60, 35, 45),  # Negatywna min talia
            (1, 'Shirt E', 1, 1, 1, 1, 70, 60, 50, 30, 40, 60, 35, 45),  # Max talia < Min talia
            (1, 'Shirt F', 1, 1, 1, 1, 70, 60, 30, 50, 60, 40, 35, 45),  # Max klatka < Min klatka
            (1, 'Shirt G', 1, 1, 1, 1, 70, 60, 30, 50, 40, 60, 45, 35),  # Max szyja < Min szyja
            (1, 'Shirt A', 1, 1, 1, 1, 70, 60, 30, 50, 40, 60, 35, 45),  # Nazwa już istnieje
            (1, 'Shirt H', 999, 1, 1, 1, 70, 60, 30, 50, 40, 60, 35, 45),  # Błędne `p_collection_id`
            (1, 'Shirt I', 1, 1, 1, 1, 0, 60, 30, 50, 40, 60, 35, 45)  # Długość = 0
        ]
    },

    "update_pants": {
        "query": "CALL update_pants(%s::INT, %s::VARCHAR, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawny przypadek
            (1, 'Pants A', 1, 1, 1, 1, 100, 70, 90),

            # Błędne przypadki - różne wyjątki
            (None, 'Pants A', 1, 1, 1, 1, 100, 70, 90),  # NULL jako `p_pants_id`
            (1, '', 1, 1, 1, 1, 100, 70, 90),  # Zbyt krótka nazwa
            (1, 'Pants B', 1, 1, 1, 1, -100, 70, 90),  # Negatywna długość
            (1, 'Pants C', 1, 1, 1, 1, 100, -70, 90),  # Negatywna min talia
            (1, 'Pants D', 1, 1, 1, 1, 100, 70, 60),  # Max talia < Min talia
            (1, 'Pants A', 1, 1, 1, 1, 100, 70, 90),  # Nazwa już istnieje
            (1, 'Pants E', 999, 1, 1, 1, 100, 70, 90),  # Błędne `p_collection_id`
            (1, 'Pants F', 1, 1, 1, 1, 0, 70, 90)  # Długość = 0
        ]
    },

    "update_boots": {
        "query": "CALL update_boots(%s::INT, %s::VARCHAR, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::FLOAT);",
        "data": [
            # Poprawny przypadek
            (1, 'Boots A', 1, 1, 1, 1, 42.5),

            # Błędne przypadki - różne wyjątki
            (None, 'Boots A', 1, 1, 1, 1, 42.5),  # NULL jako `p_boots_id`
            (1, '', 1, 1, 1, 1, 42.5),  # Zbyt krótka nazwa
            (1, 'Boots B', 1, 1, 1, 1, -1),  # Negatywna rozmiar buta
            (1, 'Boots C', 1, 1, 1, 1, 42.5),  # Nazwa już istnieje
            (1, 'Boots D', 1, 1, 1, 1, 0),  # Zerowy rozmiar buta
            (1, 'Boots E', 999, 1, 1, 1, 42.5)  # Błędne `p_collection_id`
        ]
    },

    "update_neck_accessory": {
        "query": "CALL update_neck_accessory(%s::INT, %s::VARCHAR, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            # Poprawny przypadek
            (1, 'Neck Accessory A', 1, 1, 1, 1, 30, 40),

            # Błędne przypadki - różne wyjątki
            (None, 'Neck Accessory A', 1, 1, 1, 1, 30, 40),  # NULL jako `p_neck_accessory_id`
            (1, '', 1, 1, 1, 1, 30, 40),  # Zbyt krótka nazwa
            (1, 'Neck Accessory B', 1, 1, 1, 1, -10, 40),  # Negatywna min obwód szyi
            (1, 'Neck Accessory C', 1, 1, 1, 1, 30, 20),  # Max obwód szyi < Min obwód szyi
            (1, 'Neck Accessory D', 1, 1, 1, 1, 30, 40),  # Nazwa już istnieje
            (1, 'Neck Accessory E', 999, 1, 1, 1, 30, 40)  # Błędne `p_collection_id`
        ]
    },

    "add_costume": {
        "query": "CALL add_costume(%s::VARCHAR, %s::SMALLINT, %s::SMALLINT, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER);",
        "data": [
            # Poprawny przypadek
            ('Costume A', 1, 1, 2, 39, 42, 43, 17, 19, 21, 25, 27, 1, 1), #podmienic niektóre id

            # Błędne przypadki - różne wyjątki
            # (None, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),           # None jako `p_costume_name`
            # ('Costume B', None, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),   # None jako `p_collection_id`
            # ('Costume C', 1, None, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),   # None jako `p_gender_id`
            # ('Costume D', 1, 134, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),     # Błędny `p_gender_id`
            # ('Costume E', 999, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1),   # Błędne `p_collection_id`
            # ('Costume F', 1, 1, None, 1, 1, 1, 1, 1, 1, 1, 1),      # Błędny `p_apron_id`
            # ('Costume G', 1, 1, 1, None, 1, 1, 1, 1, 1, 1, 1, 1),   # Błędny `p_caftan_id`
            # ('Costume H', 1, 1, 1, 1, None, 1, 1, 1, 1, 1, 1, 1),   # Błędny `p_petticoat_id`
            # ('Costume I', 1, 1, 1, 1, 1, None, 1, 1, 1, 1, 1, 1),   # Błędny `p_corset_id`
            # ('Costume J', 1, 1, 1, 1, 1, 1, None, 1, 1, 1, 1, 1),   # Błędny `p_skirt_id`
            # ('Costume K', 1, 1, 1, 1, 1, 1, 1, None, 1, 1, 1, 1),   # Błędny `p_belt_id`
            # ('Costume L', 1, 1, 1, 1, 1, 1, 1, 1, None, 1, 1, 1),   # Błędny `p_shirt_id`
            # ('Costume M', 1, 1, 1, 1, 1, 1, 1, 1, 1, None, 1, 1),   # Błędny `p_pants_id`
            # ('Costume N', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, None, 1),   # Błędny `p_boots_id`
            # ('Costume O', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, None),   # Błędny `p_neck_accessory_id`
        ]
    },


    "add_rental_costume_item_request": {
        "query": "CALL add_rental_costume_item_request(%s::INTEGER, %s::INTEGER);",
        "data": [
            # Poprawne rekordy
            (1, 1),  # Poprawny rekord: requester_user_id = 1, costume_item_id = 1
            (2, 2),  # Poprawny rekord: requester_user_id = 2, costume_item_id = 2
            (2, 3),  # Poprawny rekord: requester_user_id = 2, costume_item_id = 3

            # Rekord z błędem: requester_user_id = NULL
            (None, 1),  # Błąd: requester_user_id = NULL

            # Rekord z błędem: costume_item_id = NULL
            (1, None),  # Błąd: costume_item_id = NULL

            # Rekord z błędem: requester_user_id nie istnieje
            (101, 1),  # Błąd: requester_user_id = 101 nie istnieje

            # Rekord z błędem: costume_item_id nie istnieje
            (1, 102),  # Błąd: costume_item_id = 102 nie istnieje

            # Rekord z błędem: costume_item_id jest już wynajęty
            # (1, 1),  # Błąd: costume_item_id = 1 już wynajęty (przy założeniu, że istnieje aktywna pozycja w Rentals)

            # Rekord z błędem: Brak powiązania pomiędzy użytkownikiem i przedmiotem
            (103, 104)  # Błąd: Zarówno requester_user_id = 103, jak i costume_item_id = 104 nie istnieją
        ]
    },
    "accept_rental_costume_item_request": {
        "query": "CALL accept_rental_costume_item_request(%s::INTEGER, %s::INTEGER, %s::TEXT);",
        "data": [
            # Poprawny rekord
            (1, 1, 'Accept the request and proceed with the rental.'),  # Poprawny rekord: request_id = 1, approver_costumier_id = 1, comment = 'Accept the request and proceed with the rental.'
            (2, 1, 'Accept the request and proceed with the rental.'),
            # Poprawny rekord: request_id = 1, approver_costumier_id = 1, comment = 'Accept the request and proceed with the rental.'

            # Rekord z błędem: request_id = NULL
            (None, 1, 'Accept the request and proceed with the rental.'),  # Błąd: request_id = NULL

            # Rekord z błędem: approver_costumier_id = NULL
            (1, None, 'Accept the request and proceed with the rental.'),  # Błąd: approver_costumier_id = NULL

            # Rekord z błędem: comment = NULL
            (1, 1, None),  # Błąd: comment = NULL

            # Rekord z błędem: request_id nie istnieje
            (101, 1, 'Accept the request and proceed with the rental.'),  # Błąd: request_id = 101 nie istnieje

            # Rekord z błędem: nie jest to rental_costume_item_request
            # (1, 1, 'Accept the request and proceed with the rental.'),  # Błąd: request_id nie jest powiązany z rental_costume_item_request

            # Rekord z błędem: approver_costumier_id nie istnieje
            (1, 102, 'Accept the request and proceed with the rental.'),  # Błąd: approver_costumier_id = 102 nie istnieje

            # Rekord z błędem: comment jest za krótki
            (1, 1, '')  # Błąd: comment jest za krótki (<1 znak)
        ]
    },
    "deny_rental_costume_item_request": {
        "query": "CALL deny_rental_costume_item_request(%s::INTEGER, %s::INTEGER, %s::TEXT);",
        "data": [
            # Poprawny rekord
            (3, 1, 'Deny the request.'),  # Poprawny rekord: request_id = 1, approver_costumier_id = 1, comment = 'Accept the request and proceed with the rental.'

            # Rekord z błędem: request_id = NULL
            (None, 1, 'Accept the request and proceed with the rental.'),  # Błąd: request_id = NULL

            # Rekord z błędem: approver_costumier_id = NULL
            (3, None, 'Accept the request and proceed with the rental.'),  # Błąd: approver_costumier_id = NULL

            # Rekord z błędem: comment = NULL
            (3, 1, None),  # Błąd: comment = NULL

            # Rekord z błędem: request_id nie istnieje
            (101, 1, 'Accept the request and proceed with the rental.'),  # Błąd: request_id = 101 nie istnieje

            # Rekord z błędem: nie jest to rental_costume_item_request
            # (1, 1, 'Accept the request and proceed with the rental.'),  # Błąd: request_id nie jest powiązany z rental_costume_item_request

            # Rekord z błędem: approver_costumier_id nie istnieje
            (3, 102, 'Accept the request and proceed with the rental.'),  # Błąd: approver_costumier_id = 102 nie istnieje

            # Rekord z błędem: comment jest za krótki
            (3, 1, '')  # Błąd: comment jest za krótki (<1 znak)
        ]
    },
    "rent_costume_item": {
        "query": "CALL rent_costume_item(%s::INTEGER, %s::INTEGER, %s::INTEGER);",
        "data": [
            # Poprawny przypadek
            (1, 1, 1),
            (2, 2, 2),

            # Przypadki z błędami
            (None, 10, 100),   # NULL dla `p_user_id`
            (1, None, 100),    # NULL dla `p_costume_item_id`
            (1, 10, None),     # NULL dla `p_done_due_request_id`
            (999, 10, 100),    # Nieistniejący `p_user_id`
            (1, 999, 100),     # Nieistniejący `p_costume_item_id`
            (1, 10, 999),      # Nieistniejący `p_done_due_request_id`
        ]
    },


    "add_return_costume_item_request": {
        "query": "CALL add_return_costume_item_request(%s::INTEGER, %s::INTEGER);",
        "data": [
            # Poprawne rekordy
            (1, 1),  # Poprawny rekord: requester_user_id = 1, costume_item_id = 1
            (2, 2),  # Poprawny rekord: requester_user_id = 2, costume_item_id = 2
            # Rekord z błędem: requester_user_id = NULL
            (None, 1),  # Błąd: requester_user_id = NULL

            # Rekord z błędem: costume_item_id = NULL
            (1, None),  # Błąd: costume_item_id = NULL

            # Rekord z błędem: requester_user_id nie istnieje
            (101, 1),  # Błąd: requester_user_id = 101 nie istnieje

            # Rekord z błędem: costume_item_id nie istnieje
            (1, 102),  # Błąd: costume_item_id = 102 nie istnieje

            # Rekord z błędem: costume_item_id jest już wynajęty
            # (1, 1),  # Błąd: costume_item_id = 1 już wynajęty (przy założeniu, że istnieje aktywna pozycja w Rentals)

            # Rekord z błędem: Brak powiązania pomiędzy użytkownikiem i przedmiotem
            (103, 104)  # Błąd: Zarówno requester_user_id = 103, jak i costume_item_id = 104 nie istnieją
        ]
    },
    "accept_return_costume_item_request": {
        "query": "CALL accept_return_costume_item_request(%s::INTEGER, %s::INTEGER, %s::TEXT);",
        "data": [
            # Poprawny rekord
            (4, 1, 'Item return accepted. Please proceed with the return.'),
            # Poprawny rekord: request_id = 1, approver_costumier_id = 1, comment = 'Item return accepted. Please proceed with the return.'

            # Rekord z błędem: request_id = NULL
            (None, 1, 'Item return accepted. Please proceed with the return.'),  # Błąd: request_id = NULL

            # Rekord z błędem: approver_costumier_id = NULL
            (1, None, 'Item return accepted. Please proceed with the return.'),  # Błąd: approver_costumier_id = NULL

            # Rekord z błędem: comment = NULL
            (1, 1, None),  # Błąd: comment = NULL

            # Rekord z błędem: request_id nie istnieje
            (101, 1, 'Item return accepted. Please proceed with the return.'),  # Błąd: request_id = 101 nie istnieje

            # Rekord z błędem: request_id nie jest powiązany z Return_costume_item_requests
            (2, 1, 'Item return accepted. Please proceed with the return.'),
            # Błąd: request_id nie jest powiązany z Return_costume_item_requests

            # Rekord z błędem: approver_costumier_id nie istnieje
            (1, 102, 'Item return accepted. Please proceed with the return.'),
            # Błąd: approver_costumier_id = 102 nie istnieje

            # Rekord z błędem: comment jest za krótki
            (1, 1, ''),  # Błąd: comment jest za krótki (<1 znak)

            # Rekord z błędem: request_id istnieje, ale został już zaakceptowany
            # (1, 1, 'Request already accepted.')  # Błąd: request_id jest już zaakceptowany (state_id != 1)
        ]
    },
    "deny_return_costume_item_request": {
        "query": "CALL deny_return_costume_item_request(%s::INTEGER, %s::INTEGER, %s::TEXT);",
        "data": [
            # Poprawny rekord
            (5, 1, 'Request denied due to incorrect item return process.'),

            # Rekord z błędem: p_request_id = NULL
            (None, 1, 'Request denied due to incorrect item return process.'),

            # Rekord z błędem: p_approver_costumier_id = NULL
            (1, None, 'Request denied due to incorrect item return process.'),

            # Rekord z błędem: p_comment = NULL
            (1, 1, None),

            # Rekord z błędem: request_id nie istnieje
            (999, 1, 'Request denied due to incorrect item return process.'),

            # Rekord z błędem: request_id nie jest powiązany z Return_costume_item_requests
            # (2, 1, 'Request denied due to incorrect item return process.'),

            # Rekord z błędem: approver_costumier_id nie istnieje
            (1, 999, 'Request denied due to incorrect item return process.'),

            # Rekord z błędem: comment jest za krótki
            (1, 1, ''),

            # Rekord z błędem: request_id istnieje, ale został już zaakceptowany lub odrzucony
            # (1, 1, 'Request already processed.'),
        ]
    },
    "return_costume_item": {
        "query": "CALL return_costume_item(%s::INTEGER);",
        "data":[
            (4,),
            (None,),
            (1234,),
        ]
    },


    "add_borrow_costume_item_request": {
        "query": "CALL add_borrow_costume_item_request(%s::INTEGER, %s::INTEGER, %s::INTEGER);",
        "data": [
            # Poprawne rekordy
            (1, 2, 2),  # Poprawny rekord: requester_user_id = 1, costume_item_id = 1, approver_user_id = 2
            (2, 1, 1),  # Poprawny rekord: requester_user_id = 2, costume_item_id = 2, approver_user_id = 1
            (1, 2, 2),  # Poprawny rekord: requester_user_id = 1, costume_item_id = 1, approver_user_id = 2

            # Rekord z błędem: requester_user_id = NULL
            (None, 1, 2),  # Błąd: requester_user_id = NULL

            # Rekord z błędem: costume_item_id = NULL
            (1, None, 2),  # Błąd: costume_item_id = NULL

            # Rekord z błędem: approver_user_id = NULL
            (1, 1, None),  # Błąd: approver_user_id = NULL

            # Rekord z błędem: requester_user_id nie istnieje
            (101, 1, 2),  # Błąd: requester_user_id = 101 nie istnieje

            # Rekord z błędem: approver_user_id nie istnieje
            (1, 1, 103),  # Błąd: approver_user_id = 103 nie istnieje

            # Rekord z błędem: costume_item_id nie istnieje
            (1, 102, 2),  # Błąd: costume_item_id = 102 nie istnieje

            # Rekord z błędem: costume_item_id nie wypożyczony przez approver_user_id
            # (1, 2, 2),  # Błąd: costume_item_id = 2 nie zostało wypożyczone przez approver_user_id = 2

            # Rekord z błędem: requester_user_id i approver_user_id są takie same
            # (1, 1, 1)   # Błąd: requester_user_id i approver_user_id są takie same
        ]
    },
    "accept_borrow_costume_item_request": {
        "query": "CALL accept_borrow_costume_item_request(%s::INTEGER, %s::TEXT);",
        "data": [
            # Poprawny rekord
            (6, 'Request accepted. Borrowing approved.'),

            # Rekord z błędem: p_request_id = NULL
            (None, 'Request accepted. Borrowing approved.'),

            # Rekord z błędem: p_comment = NULL
            (1, None),

            # Rekord z błędem: request_id nie istnieje
            (999, 'Request accepted. Borrowing approved.'),

            # Rekord z błędem: request_id nie jest powiązany z Borrow_costume_item_requests
            # (2, 'Request accepted. Borrowing approved.'),

            # Rekord z błędem: comment jest za krótki
            (1, ''),

            # Rekord z błędem: request_id istnieje, ale został już zaakceptowany lub odrzucony
            # (1, 'Request already processed.'),
        ]
    },
    "deny_borrow_costume_item_request": {
        "query": "CALL deny_borrow_costume_item_request(%s::INTEGER, %s::TEXT);",
        "data": [
            # Poprawny rekord
            (7, 'Request denied due to unavailability.'),

            # Rekord z błędem: p_request_id = NULL
            (None, 'Request denied due to unavailability.'),

            # Rekord z błędem: p_comment = NULL
            (1, None),

            # Rekord z błędem: request_id nie istnieje
            (999, 'Request denied due to unavailability.'),

            # Rekord z błędem: request_id nie jest powiązany z Borrow_costume_item_requests
            # (2, 'Request denied due to unavailability.'),

            # Rekord z błędem: comment jest za krótki
            (1, ''),

            # Rekord z błędem: request_id istnieje, ale został już zaakceptowany lub odrzucony
            # (1, 'Request already processed.'),
        ]
    },
    "borrow_costume_item": {
        "query": "CALL borrow_costume_item(%s::INTEGER, %s::INTEGER, %s::INTEGER, %s::INTEGER);",
        "data": [
            # Poprawny przypadek
            (2, 1, 2, 6),

            # Przypadki z błędami
            (None, 2, 10, 1),  # NULL jako `p_rental_id`
            (1, None, 10, 1),  # NULL jako `p_new_owner_user_id`
            (1, 2, None, 1),  # NULL jako `p_costume_item_id`
            (1, 2, 10, None),  # NULL jako `p_done_due_request_id`
            (999, 2, 10, 1)  # Nieistniejący `p_rental_id`
        ]
    },

    "add_notification": {
        "query": "CALL add_notification(%s::INTEGER, %s::TEXT, %s::INTEGER);",
        "data": [
            # Poprawne rekordy
            (1, 'Notification content for user 1', 1),  # Poprawny rekord: user_id = 1, notification_content = 'Notification content for user 1', due_to_request_id = 1

            # Rekord z błędem: user_id = NULL
            (None, 'Notification content', 1),  # Błąd: user_id = NULL

            # Rekord z błędem: notification_content = NULL
            (1, None, 1),  # Błąd: notification_content = NULL

            # Rekord z błędem: due_to_request_id = NULL
            (1, 'Notification content', None),  # Błąd: due_to_request_id = NULL

            # Rekord z błędem: user_id nie istnieje
            (101, 'Notification for non-existing user', 1),  # Błąd: user_id = 101 nie istnieje

            # Rekord z błędem: due_to_request_id nie istnieje
            (1, 'Notification content', 102),  # Błąd: due_to_request_id = 102 nie istnieje

            # Rekord z błędem: user_id i requester_user_id z requestu są takie same
            # (1, 'Notification content', 1),  # Błąd: user_id i requester_user_id z requestu = 1 są takie same

            # Rekord z błędem: notification_content ma mniej niż 1 znak
            (1, '', 1)   # Błąd: notification_content ma mniej niż 1 znak
        ]
    },

    "update_costume_item_location": {
        "query": "CALL update_costume_item_location(%s::INTEGER, %s::INTEGER);",
        "data": [
            # Poprawne rekordy
            (1, 1),  # Poprawny rekord: costume_item_id = 1, location_id = 1
            (2, 2),  # Poprawny rekord: costume_item_id = 2, location_id = 2

            # Rekord z błędem: costume_item_id = NULL
            (None, 1),  # Błąd: costume_item_id = NULL

            # Rekord z błędem: location_id = NULL
            (1, None),  # Błąd: location_id = NULL

            # Rekord z błędem: costume_item_id nie istnieje
            (101, 1),  # Błąd: costume_item_id = 101 nie istnieje

            # Rekord z błędem: location_id nie istnieje
            (1, 101),  # Błąd: location_id = 101 nie istnieje

            # Rekord z błędem: błędny zaktualizowany rekord
            # (1, 2)  # Błąd: inny konflikt związany z aktualizacją (np. już zaktualizowane)
        ]
    },
    "delete_request": {
        "query": "CALL delete_request(%s::INTEGER);",
        "data": [
            # Poprawny rekord
            (8,),  # Poprawny rekord: request_id = 2 (zakładając, że request_id = 2 istnieje i jego stan = 1)

            # Rekord z błędem: request_id = NULL
            (None,),  # Błąd: request_id = NULL

            # Rekord z błędem: request_id nie istnieje
            (101,),  # Błąd: request_id = 101 nie istnieje

            # Rekord z błędem: request już zamknięty (r_state_id <> 1)
            # (3,)  # Błąd: request_id = 3, który ma r_state_id != 1 (przykład zamkniętego requestu)
        ]
    },
    "mark_notification_as_read": {
        "query": "CALL mark_notification_as_read(%s::INTEGER);",
        "data": [
            # Poprawny przypadek
            (1,),

            # Przypadki z błędami
            (None,),          # Brak parametru (NULL)
            (999,)           # Nieistniejące id powiadomienia
        ]
    }
}

# Wykonaj testy
for procedure, test in test_cases.items():
    print(f"Testing procedure: {procedure}")
    results = run_tests(conn, test["query"], test["data"])
    for result in results:
        print(result)

conn.close()
