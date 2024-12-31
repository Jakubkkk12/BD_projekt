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
    test_insert_query = """ CALL add_location(%s::VARCHAR,%s::SMALLINT,%s::VARCHAR,%s::SMALLINT); """

    # Dane do wstawienia
    dane = [
        ('Krakow', 2, '30-001', 1),  # Poprawny rekord - Settlement ID 1
        ('Prayz', 3, '40-002', 2),  # Poprawny rekord - Settlement ID 2
        ('Krakow', 2, '30-001', 1),  # Duplikat - Settlement ID 1
        ('Prayz', 7, '40-003', 2),  # Poprawny rekord - Settlement ID 2
        (
        'Krakowwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww',
        2, '30-004', 1),  # Zbyt długa nazwa ulicy
        ('Warszawa', 15, '12-3456', 1),  # Poprawny rekord - Settlement ID 1
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
