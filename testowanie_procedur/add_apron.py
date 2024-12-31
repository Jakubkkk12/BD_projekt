import psycopg2
from psycopg2 import sql
from scipy.linalg import null_space

# Dane do połączenia z bazą PostgreSQL
DB_HOST = "localhost"  # adres hosta
DB_NAME = "postgres"  # nazwa bazy danych
DB_USER = "postgres"  # nazwa użytkownika
DB_PASSWORD = "filip2002"  # hasło do bazy danych

# Połączenie z bazą danych
try:
    # Tworzymy połączenie
    conn = psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
    # Tworzymy kursor do wykonywania zapytań
    cursor = conn.cursor()

    # Definiowanie zapytania INSERT
    test_insert_query = """ CALL add_apron(%s::VARCHAR,%s::SMALLINT,%s::SMALLINT,%s::SMALLINT,%s::SMALLINT,%s::SMALLINT,%s::SMALLINT); """

    # Dane do wstawienia
    dane = [
        ("Basic Apron", 1, 1, 1, 1, 100, 1),  # Poprawny rekord
        ("Stylish Apron", 2, 2, 2, 2, 120, 2),  # Poprawny rekord
        ("Fancy Apron", 3, 3, 3, 3, 80, 3),  # Poprawny rekord
        (None, 1, 1, 1, 1, 100, 1),  # Nazwa fartucha jest NULL
        ("", 1, 1, 1, 1, 100, 1),  # Nazwa fartucha jest pusta
        ("Very Long Apron Name That Exceeds Thirty Characters", 1, 1, 1, 1, 100, 1),  # Nazwa > 30 znaków
        ("Basic Apron", None, 1, 1, 1, 100, 1),  # Brak kolekcji
        ("Basic Apron", 1, None, 1, 1, 100, 1),  # Brak płci
        ("Basic Apron", 1, 4, 1, 1, 100, 1),  # Nieistniejący ID płci (4)
        ("Basic Apron", 1, 1, None, 1, 100, 1),  # Brak koloru
        ("Basic Apron", 1, 1, 1, None, 100, 1),  # Brak lokalizacji
        ("Basic Apron", 1, 1, 1, 1, 0, 1),  # Długość fartucha <= 0
        ("Basic Apron", 1, 1, 1, 1, 100, None),  # Brak wzoru
        ("Duplicate Apron", 1, 1, 1, 1, 100, 1),
    ]

    # Pętla po danych, aby obsłużyć każdy rekord osobno
    for rekord in dane:
        try:
            cursor.execute(test_insert_query, rekord)  # Wywołujemy procedurę dla pojedynczego rekordu
            conn.commit()  # Zatwierdzenie transakcji
            print(f"Rekord {rekord} został pomyślnie dodany.")
        except Exception as e:
            conn.rollback()  # Wycofanie transakcji w przypadku błędu
            print(f"Błąd przy danych {rekord}: {e}")

except Exception as e:
    print("Wystąpił błąd połączenia lub konfiguracji:", e)

finally:
    # Zamykamy połączenie i kursor
    if cursor:
        cursor.close()
    if conn:
        conn.close()
