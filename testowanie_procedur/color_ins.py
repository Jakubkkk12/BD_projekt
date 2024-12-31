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
    test_insert_query = """ CALL add_color(%s::VARCHAR); """

    # Dane do wstawienia
    dane = [
        (None,),  # Test 1: NULL
        ('A very long color name that exceeds the limit',),  # Test 2: Przekroczenie 25 znaków
        ('Red',),  # Test 3: Kolor już istnieje
        ('Red',),  # Test 3: Kolor już istnieje
        ('Blue',),  # Test 4: Prawidłowy zapis
        ('Green',),  # Test 5: Prawidłowy zapis
        ('Yellow',),  # Test 6: Prawidłowy zapis
        ('Purple',),  # Test 7: Prawidłowy zapis
        ('Orange',)  # Test 8: Prawidłowy zapis
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
