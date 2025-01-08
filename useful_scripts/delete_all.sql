DO $$
DECLARE
    r RECORD;
BEGIN
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END $$;
DO $$
DECLARE
    r RECORD;
BEGIN
    -- Usunięcie wszystkich widoków
    FOR r IN (SELECT table_name FROM information_schema.views WHERE table_schema = 'public') LOOP
        EXECUTE 'DROP VIEW IF EXISTS ' || quote_ident(r.table_name) || ' CASCADE';
    END LOOP;

    -- Usunięcie wszystkich tabel
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
        EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;

    -- Usunięcie wszystkich sekwencji
    FOR r IN (SELECT sequencename FROM pg_sequences WHERE schemaname = 'public') LOOP
        EXECUTE 'DROP SEQUENCE IF EXISTS ' || quote_ident(r.sequencename) || ' CASCADE';
    END LOOP;

    -- Usunięcie wszystkich funkcji
    FOR r IN (SELECT proname, oidvectortypes(proargtypes) AS args
              FROM pg_proc
              INNER JOIN pg_namespace ON pg_proc.pronamespace = pg_namespace.oid
              WHERE nspname = 'public') LOOP
        EXECUTE 'DROP FUNCTION IF EXISTS ' || quote_ident(r.proname) || '(' || r.args || ') CASCADE';
    END LOOP;

    -- Usunięcie wszystkich procedur
    FOR r IN (SELECT proname, oidvectortypes(proargtypes) AS args
              FROM pg_proc
              INNER JOIN pg_namespace ON pg_proc.pronamespace = pg_namespace.oid
              WHERE nspname = 'public' AND prokind = 'p') LOOP
        EXECUTE 'DROP PROCEDURE IF EXISTS ' || quote_ident(r.proname) || '(' || r.args || ') CASCADE';
    END LOOP;

    -- Usunięcie wszystkich wyzwalaczy
    FOR r IN (SELECT tgname, relname
              FROM pg_trigger
              INNER JOIN pg_class ON pg_trigger.tgrelid = pg_class.oid
              INNER JOIN pg_namespace ON pg_class.relnamespace = pg_namespace.oid
              WHERE nspname = 'public' AND NOT tgisinternal) LOOP
        EXECUTE 'DROP TRIGGER IF EXISTS ' || quote_ident(r.tgname) || ' ON ' || quote_ident(r.relname) || ' CASCADE';
    END LOOP;

    -- Usunięcie wszystkich typów użytkownika
    FOR r IN (SELECT typname FROM pg_type
              INNER JOIN pg_namespace ON pg_type.typnamespace = pg_namespace.oid
              WHERE nspname = 'public' AND typtype = 'c') LOOP
        EXECUTE 'DROP TYPE IF EXISTS ' || quote_ident(r.typname) || ' CASCADE';
    END LOOP;

END $$;
