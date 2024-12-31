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
    test_insert_query = """ CALL add_head_accessory_category(%s::VARCHAR); """

    # Dane do wstawienia
    dane = [
        (None,),  # Test 1: NULL (błąd: All parameters cannot be NULL)
        ('Krótkie_NazwyKrótkie_NazwyKrótkie_NazwyKrótkie_Nazwy',),
        # Test 2: Przekroczenie 20 znaków (błąd: Head accessory category name exceeded 20 characters)
        ('Kapelusze',),  # Test 3: Kategoria już istnieje (błąd: Head accessory category already exist)
        ('Kapelusze',),  # Test 3: Kategoria już istnieje (błąd: Head accessory category already exist)
        ('Czapki',),  # Test 4: Prawidłowy zapis
        ('Opaski_na_głowę',),
        # Test 5: Przekroczenie 20 znaków (błąd: Head accessory category name exceeded 20 characters)
        ('Koronki',),  # Test 6: Prawidłowy zapis
        ('Wiązane_kapelusze',),  # Test 7: Prawidłowy zapis
        ('Perłowe_opaski',),  # Test 8: Prawidłowy zapis
        ('Punkowe_kapelusze',)  # Test 9: Prawidłowy zapis
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
