# Testowe dane wejściowe
dane_testowe = [
    ("Jan", "Kowalski", "1990-01-01", "jan.kowalski@example.com", "123456789", 1, 1, 180, 80, 100, 55, 40, 90, 40, 50, 42.5),
    ("Anna", "Nowak", "1985-05-15", "anna.nowak@example.com", "234567890", 2, 2, 160, 70, 90, 55, 35, 85, 38, 45, 38.0),
    ("Patryk", "Zieliński", "1992-12-20", "patryk.zielinski@example.com", "501234567", 1, 3, 175, 85, 95, 56, 42, 88, 41, 48, 43.0),
    ("Kasia", "Wiśniewska", "1997-03-10", "kasia.wisniewska@example.com", "123456788", 2, 4, 165, 65, 85, 54, 38, 86, 39, 46, 37.0),
    ("Jan" * 10, "Kowalski", "1990-01-01", "jan.kowalski@example.com", "123456789", 1, 1, 180, 80, 100, 55, 40, 90, 40, 50, 42.5),  # imię > 25 znaków

    # Zbyt długie nazwisko
    ("Anna", "Nowak" * 10, "1985-05-15", "anna.nowak@example.com", "234567890", 2, 2, 160, 70, 90, 55, 35, 85, 38, 45, 38.0),  # nazwisko > 30 znaków

    # Niepoprawny email (brak @)
    ("Patryk", "Zieliński", "1992-12-20", "patryk.zielinski.com", "501234567", 1, 3, 175, 85, 95, 56, 42, 88, 41, 48, 43.0),  # email bez @

    # Niepoprawny numer telefonu (za mało znaków)
    ("Kasia", "Wiśniewska", "1997-03-10", "kasia.wisniewska@example.com", "123", 2, 4, 165, 65, 85, 54, 38, 86, 39, 46, 37.0),  # numer telefonu za krótki

    # Puste dane (brak imienia)
    (None, "Nowak", "1985-05-15", "anna.nowak@example.com", "234567890", 2, 2, 160, 70, 90, 55, 35, 85, 38, 45, 38.0),  # brak imienia

    # Wartość fizyczna = 0 (np. wysokość 0)
    ("Jan", "Kowalski", "1990-01-01", "jan.kowalski@example.com", "123456789", 1, 1, 0, 80, 100, 55, 40, 90, 40, 50, 42.5),  # wysokość <= 0

    # Niepoprawny ID płci (np. nieistniejąca płeć o id 999)
    ("Jan", "Kowalski", "1990-01-01", "jan.kowalski@example.com", "123456789", 999, 1, 180, 80, 100, 55, 40, 90, 40, 50, 42.5),  # nieistniejący ID płci

    # Niepoprawny ID lokalizacji (np. nieistniejąca lokalizacja o id 999)
    ("Anna", "Nowak", "1985-05-15", "anna.nowak@example.com", "234567890", 2, 999, 160, 70, 90, 55, 35, 85, 38, 45, 38.0),  # nieistniejący ID lokalizacji

    # Istniejący email (powtórzony)
    ("Patryk", "Zieliński", "1992-12-20", "patryk.zielinski@example.com", "501234567", 1, 3, 175, 85, 95, 56, 42, 88, 41, 48, 43.0),  # powtórzony email

]

# Procedura wykonania zapytania
import psycopg2

# Połączenie z bazą danych
try:
    conn = psycopg2.connect(
        host="localhost",
        database="postgres",
        user="postgres",
        password="filip2002"
    )
    cursor = conn.cursor()

    # Zapytanie do procedury
    insert_query = """CALL add_user(
    %s::VARCHAR,     
    %s::VARCHAR,      
    %s::DATE,             
    %s::VARCHAR,      
    %s::VARCHAR,      
    %s::SMALLINT,         
    %s::SMALLINT,         
    %s::SMALLINT,         
    %s::SMALLINT,         
    %s::SMALLINT,         
    %s::SMALLINT,         
    %s::SMALLINT,         
    %s::SMALLINT,        
    %s::SMALLINT,         
    %s::SMALLINT,         
    %s::FLOAT             
);"""

    # Testowanie procedury z danymi wejściowymi
    for rekord in dane_testowe:
        try:
            cursor.execute(insert_query, rekord)  # Wywołujemy procedurę dla pojedynczego rekordu
            conn.commit()  # Zatwierdzenie transakcji
            print(f"Rekord {rekord} został pomyślnie dodany.")
        except Exception as e:
            conn.rollback()  # Wycofanie transakcji w przypadku błędu
            print(f"Błąd przy danych {rekord}: {e}")

    # Zamykanie połączenia
    cursor.close()
    conn.close()

except Exception as e:
    print(f"Błąd połączenia: {e}")
