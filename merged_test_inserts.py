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
        "query": "CALL add_shirt(%s::VARCHAR(30), %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT, %s::SMALLINT);",
        "data": [
            ("Shirt1", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35),  # Poprawny rekord - Przykład dla Collection 1, Gender male, Color Red, Location ulica1
            ("Shirt2", 2, 2, 2, 2, 75, 65, 75, 95, 42, 47, 36),  # Poprawny rekord - Przykład dla Collection 2, Gender female, Color Blue, Location ulica2

            # Rekord z błędem: Brak p_shirt_name (None)
            (None, 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35),  # Błąd: Parametr p_shirt_name = None

            # Rekord z błędem: Nieistniejący collection_id
            ("Shirt3", 10, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35),  # Błąd: Collection z id 10 nie istnieje

            # Rekord z błędem: Nieistniejący gender_id
            ("Shirt4", 1, 99, 1, 1, 70, 60, 70, 90, 40, 45, 35),  # Błąd: Gender z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący color_id
            ("Shirt5", 1, 1, 99, 1, 70, 60, 70, 90, 40, 45, 35),  # Błąd: Color z id 99 nie istnieje

            # Rekord z błędem: Nieistniejący location_id
            ("Shirt6", 1, 1, 1, 99, 70, 60, 70, 90, 40, 45, 35),  # Błąd: Location z id 99 nie istnieje

            # Rekord z błędem: Brak wymaganych parametrów (null)
            ("Shirt7", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, None),  # Błąd: p_shirt_max_neck_circumference = None

            # Rekord z błędem: Arm length <= 0
            ("Shirt8", 1, 1, 1, 1, 70, -10, 70, 90, 40, 45, 35),  # Błąd: p_shirt_arm_length <= 0

            # Rekord z błędem: Min waist circumference <= 0
            ("Shirt9", 1, 1, 1, 1, 70, 60, -10, 90, 40, 45, 35),  # Błąd: p_shirt_min_waist_circumference <= 0

            # Rekord z błędem: Max waist circumference < min waist circumference
            ("Shirt10", 1, 1, 1, 1, 70, 60, 50, 40, 40, 45, 35),  # Błąd: p_shirt_max_waist_circumference < p_shirt_min_waist_circumference

            # Rekord z błędem: Max chest circumference < min chest circumference
            ("Shirt11", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 36),  # Błąd: p_shirt_max_chest_circumference < p_shirt_min_chest_circumference

            # Rekord z błędem: Max neck circumference < min neck circumference
            ("Shirt12", 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 30),  # Błąd: p_shirt_max_neck_circumference < p_shirt_min_neck_circumference

            # Rekord z błędem: Zbyt długa nazwa p_shirt_name
            ("S" + "S" * 31, 1, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35),  # Błąd: Nazwa shirt ma więcej niż 30 znaków

            # Rekord z błędem: Shirt o tej nazwie już istnieje
            ("Shirt1", 2, 1, 1, 1, 70, 60, 70, 90, 40, 45, 35)   # Błąd: Shirt o nazwie "Shirt1" już istnieje
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
    }

















}

# Wykonaj testy
for procedure, test in test_cases.items():
    print(f"Testing procedure: {procedure}")
    results = run_tests(conn, test["query"], test["data"])
    for result in results:
        print(result)

conn.close()
