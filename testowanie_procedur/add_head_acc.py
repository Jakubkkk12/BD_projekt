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
        # Poprawne dane
        ('Hat A', 1, 1, 1, 1, 55, 1),
        # Poprawne dane bez obwodu głowy
        ('Hat B', 1, 2, 2, 2, None, 2),
        # Błędy
        ('', 1, 1, 1, 1, 55, 1),  # Nazwa za krótka
        ('This is a very long head accessory name', 1, 1, 1, 1, 55, 1),  # Nazwa za długa
        ('Hat C', None, 1, 1, 1, 55, 1),  # Brak collection_id
        ('Hat D', 1, 4, 1, 1, 55, 1),  # Niepoprawny gender_id
        ('Hat E', 1, 1, 999, 1, 55, 1),  # Nieistniejący color_id
        ('Hat F', 1, 1, 1, 1, -10, 1),  # Obwód głowy <= 0
        ('Hat G', 1, 1, 1, None, 55, 1),  # Brak location_id
        ('Hat A', 1, 1, 1, 1, 55, 1),  # Duplikat nazwy
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
