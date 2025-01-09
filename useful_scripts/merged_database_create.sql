CREATE TABLE Countries 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY  NOT NULL , 
     name VARCHAR(30)  NOT NULL 
    ) 
;

ALTER TABLE Countries 
    ADD CONSTRAINT Countries_PK PRIMARY KEY ( id ) ;

ALTER TABLE Countries 
    ADD CONSTRAINT Countries_UN UNIQUE ( name ) ;


CREATE TABLE Regions 
    ( 
     id         SMALLINT GENERATED ALWAYS AS IDENTITY  NOT NULL , 
     name       VARCHAR (30)  NOT NULL , 
     country_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Regions 
    ADD CONSTRAINT Regions_PK PRIMARY KEY ( id ) ;

ALTER TABLE Regions 
    ADD CONSTRAINT Regions_UN UNIQUE ( name , country_id ) ;

ALTER TABLE Regions 
    ADD CONSTRAINT Regions_Countries_FK FOREIGN KEY 
    ( 
     country_id
    ) 
    REFERENCES Countries 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE TABLE Settlements 
    ( 
     id        SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL, 
     name      VARCHAR(30)  NOT NULL , 
     region_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Settlements 
    ADD CONSTRAINT Settlements_PK PRIMARY KEY ( id ) ;

ALTER TABLE Settlements 
    ADD CONSTRAINT Settlements_UN UNIQUE ( name , region_id ) ;

ALTER TABLE Settlements 
    ADD CONSTRAINT Settlements_Regions_FK FOREIGN KEY 
    ( 
     region_id
    ) 
    REFERENCES Regions 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;


CREATE TABLE Locations 
    ( 
     id              SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     street          VARCHAR (30)  NOT NULL , 
     building_number SMALLINT  NOT NULL , 
     postal_code     VARCHAR (10)  NOT NULL , 
     settlement_id   SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Locations 
    ADD CONSTRAINT Locations_PK PRIMARY KEY ( id ) ;

ALTER TABLE Locations 
    ADD CONSTRAINT Locations_UN UNIQUE ( street , building_number , postal_code , settlement_id ) ;

ALTER TABLE Locations 
    ADD CONSTRAINT Locations_Settlements_FK FOREIGN KEY 
    ( 
     settlement_id
    ) 
    REFERENCES Settlements 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;


CREATE TABLE Genders 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (25)  NOT NULL 
    ) 
;

ALTER TABLE Genders 
    ADD CONSTRAINT Genders_PK PRIMARY KEY ( id ) ;

ALTER TABLE Genders 
    ADD CONSTRAINT Genders_UN UNIQUE ( name ) ;

INSERT INTO Genders (name) VALUES ('male'), ('female'), ('bigender');

CREATE TABLE Users 
    ( 
     id                  INTEGER GENERATED ALWAYS AS IDENTITY  NOT NULL , 
     first_name          VARCHAR (25)  NOT NULL , 
     last_name           VARCHAR (30)  NOT NULL , 
     date_of_birth       DATE  NOT NULL , 
     email               VARCHAR (50)  NOT NULL , 
     phone_number        VARCHAR (12)  NOT NULL , 
     gender_id           SMALLINT  NOT NULL , 
     home_location_id    SMALLINT  NOT NULL , 
     height              SMALLINT  NOT NULL , 
     waist_circumference SMALLINT  NOT NULL , 
     chest_circumference SMALLINT  NOT NULL , 
     head_circumference  SMALLINT  NOT NULL , 
     neck_circumference  SMALLINT  NOT NULL , 
     leg_length          SMALLINT  NOT NULL , 
     arm_length          SMALLINT  NOT NULL , 
     torso_length        SMALLINT  NOT NULL , 
     shoe_size           FLOAT  NOT NULL 
    ) 
;

ALTER TABLE Users 
    ADD CONSTRAINT Users_PK PRIMARY KEY ( id ) ;

ALTER TABLE Users 
    ADD CONSTRAINT Users_UN UNIQUE ( email ) ;

ALTER TABLE Users 
    ADD CONSTRAINT chk_email_format CHECK (email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

ALTER TABLE Users 
    ADD CONSTRAINT chk_phone_format CHECK (phone_number ~* '^\+\d{2}\d{9}$');

ALTER TABLE Users 
    ADD CONSTRAINT chk_height_value CHECK (height > 0);

ALTER TABLE Users 
    ADD CONSTRAINT chk_waist_circumference_value CHECK (waist_circumference > 0);

ALTER TABLE Users 
    ADD CONSTRAINT chk_chest_circumference_value CHECK (chest_circumference > 0);

ALTER TABLE Users 
    ADD CONSTRAINT chk_head_circumference_value CHECK (head_circumference > 0);

ALTER TABLE Users 
    ADD CONSTRAINT chk_neck_circumference_value CHECK (neck_circumference > 0);

ALTER TABLE Users 
    ADD CONSTRAINT chk_leg_length_value CHECK (leg_length > 0 AND leg_length < height);

ALTER TABLE Users 
    ADD CONSTRAINT chk_arm_length_value CHECK (arm_length > 0 AND arm_length < height);

ALTER TABLE Users 
    ADD CONSTRAINT chk_torso_length_value CHECK (torso_length > 0 AND torso_length < height);

ALTER TABLE Users 
    ADD CONSTRAINT chk_shoe_size_value CHECK (shoe_size > 0);

ALTER TABLE Users 
    ADD CONSTRAINT Users_Genders_FK FOREIGN KEY 
    ( 
     gender_id
    ) 
    REFERENCES Genders 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Users 
    ADD CONSTRAINT Users_Locations_FK FOREIGN KEY 
    ( 
     home_location_id
    ) 
    REFERENCES Locations 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_users_first_last ON Users (first_name, last_name);
CREATE INDEX idx_users_phone_number ON Users (phone_number);
CREATE INDEX idx_users_home_location_id ON Users (home_location_id);

CREATE TABLE Roles 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (20)  NOT NULL 
    ) 
;

ALTER TABLE Roles 
    ADD CONSTRAINT Roles_PK PRIMARY KEY ( id ) ;

ALTER TABLE Roles 
    ADD CONSTRAINT Roles_UN UNIQUE ( name ) ;


CREATE TABLE Types_of_voices 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (10)  NOT NULL 
    ) 
;

ALTER TABLE Types_of_voices 
    ADD CONSTRAINT Types_of_voices_PK PRIMARY KEY ( id ) ;

ALTER TABLE Types_of_voices 
    ADD CONSTRAINT Types_of_voices_UN UNIQUE ( name ) ;


CREATE TABLE Types_of_instruments 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (20)  NOT NULL 
    ) 
;

ALTER TABLE Types_of_instruments 
    ADD CONSTRAINT Types_of_instruments_PK PRIMARY KEY ( id ) ;

ALTER TABLE Types_of_instruments 
    ADD CONSTRAINT Types_of_instruments_UN UNIQUE ( name ) ;


CREATE TABLE Dances 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (20)  NOT NULL 
    ) 
;

ALTER TABLE Dances 
    ADD CONSTRAINT Dances_PK PRIMARY KEY ( id ) ;

ALTER TABLE Dances 
    ADD CONSTRAINT Dances_UN UNIQUE ( name ) ;


CREATE TABLE Costumiers 
    ( 
     user_id          INTEGER  NOT NULL , 
     role_id          SMALLINT  NOT NULL , 
     work_location_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Costumiers 
    ADD CONSTRAINT Costumiers_PK PRIMARY KEY ( user_id ) ;

ALTER TABLE Costumiers 
    ADD CONSTRAINT Costumiers_Locations_FK FOREIGN KEY 
    ( 
     work_location_id
    ) 
    REFERENCES Locations 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumiers 
    ADD CONSTRAINT Costumiers_Roles_FK FOREIGN KEY 
    ( 
     role_id
    ) 
    REFERENCES Roles 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumiers 
    ADD CONSTRAINT Costumiers_Users_FK FOREIGN KEY 
    ( 
     user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
; 

CREATE INDEX idx_costumiers_role_id ON Costumiers(role_id);
CREATE INDEX idx_costumiers_work_location_id ON Costumiers(work_location_id);

CREATE TABLE Singers 
    ( 
     user_id INTEGER  NOT NULL , 
     role_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Singers 
    ADD CONSTRAINT Singers_PK PRIMARY KEY ( user_id ) ;

ALTER TABLE Singers 
    ADD CONSTRAINT Singers_Roles_FK FOREIGN KEY 
    ( 
     role_id
    ) 
    REFERENCES Roles 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Singers 
    ADD CONSTRAINT Singers_Users_FK FOREIGN KEY 
    ( 
     user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

CREATE INDEX idx_singers_role_id ON Singers(role_id);

CREATE TABLE Singer_voices 
    ( 
     singer_id        INTEGER  NOT NULL , 
     type_of_voice_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Singer_voices 
    ADD CONSTRAINT Singer_voices_PK PRIMARY KEY ( singer_id, type_of_voice_id ) ;

ALTER TABLE Singer_voices 
    ADD CONSTRAINT Singer_voices_Singers_FK FOREIGN KEY 
    ( 
     singer_id
    ) 
    REFERENCES Singers 
    ( 
     user_id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE Singer_voices 
    ADD CONSTRAINT Singer_voices_Types_of_voices_FK FOREIGN KEY 
    ( 
     type_of_voice_id
    ) 
    REFERENCES Types_of_voices 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;


CREATE TABLE Musicians 
    ( 
     user_id INTEGER  NOT NULL , 
     role_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Musicians 
    ADD CONSTRAINT Musicians_PK PRIMARY KEY ( user_id ) ;

ALTER TABLE Musicians 
    ADD CONSTRAINT Musicians_Roles_FK FOREIGN KEY 
    ( 
     role_id
    ) 
    REFERENCES Roles 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Musicians 
    ADD CONSTRAINT Musicians_Users_FK FOREIGN KEY 
    ( 
     user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

CREATE INDEX idx_musicians_role_id ON Musicians(role_id);

CREATE TABLE Musician_instrument 
    ( 
     musician_id           INTEGER  NOT NULL , 
     type_of_instrument_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Musician_instrument 
    ADD CONSTRAINT Musician_instrument_PK PRIMARY KEY ( musician_id, type_of_instrument_id ) ;

ALTER TABLE Musician_instrument 
    ADD CONSTRAINT Musician_instrument_Musicians_FK FOREIGN KEY 
    ( 
     musician_id
    ) 
    REFERENCES Musicians 
    ( 
     user_id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE Musician_instrument 
    ADD CONSTRAINT Musician_instrument_Types_of_instruments_FK FOREIGN KEY 
    ( 
     type_of_instrument_id
    ) 
    REFERENCES Types_of_instruments 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;


CREATE TABLE Dancers 
    ( 
     user_id INTEGER  NOT NULL , 
     role_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Dancers 
    ADD CONSTRAINT Dancers_PK PRIMARY KEY ( user_id ) ;

ALTER TABLE Dancers 
    ADD CONSTRAINT Dancers_Roles_FK FOREIGN KEY 
    ( 
     role_id
    ) 
    REFERENCES Roles 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Dancers 
    ADD CONSTRAINT Dancers_Users_FK FOREIGN KEY 
    ( 
     user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

CREATE INDEX idx_dancers_role_id ON Dancers(role_id);

CREATE TABLE Dancer_dance 
    ( 
     dancer_id        INTEGER  NOT NULL , 
     dance_id SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Dancer_dance 
    ADD CONSTRAINT Dancer_dance_PK PRIMARY KEY ( dancer_id, dance_id ) ;

ALTER TABLE Dancer_dance 
    ADD CONSTRAINT Dancer_dance_Dancers_FK FOREIGN KEY 
    ( 
     dancer_id
    ) 
    REFERENCES Dancers 
    ( 
     user_id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE Dancer_dance 
    ADD CONSTRAINT Dancer_dance_Dances_FK FOREIGN KEY 
    ( 
     Dance_id
    ) 
    REFERENCES Dances 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
; 


CREATE TABLE Colors 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (25)  NOT NULL 
    ) 
;

ALTER TABLE Colors 
    ADD CONSTRAINT Colors_PK PRIMARY KEY ( id ) ;

ALTER TABLE Colors 
    ADD CONSTRAINT Colors_UN UNIQUE ( name ) ;


CREATE TABLE Collections 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (20)  NOT NULL 
    ) 
;

ALTER TABLE Collections 
    ADD CONSTRAINT Collections_PK PRIMARY KEY ( id ) ;

ALTER TABLE Collections 
    ADD CONSTRAINT Collections_UN UNIQUE ( name ) ;

INSERT INTO collections (name) VALUES ('universal');

CREATE TABLE Costumes_items 
    ( 
     id            INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name          VARCHAR (30)  NOT NULL , 
     collection_id SMALLINT  NOT NULL , 
     gender_id     SMALLINT  NOT NULL , 
     color_id      SMALLINT  NOT NULL , 
     location_id   SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Costumes_items 
    ADD CONSTRAINT Costumes_items_PK PRIMARY KEY ( id ) ;

ALTER TABLE Costumes_items 
    ADD CONSTRAINT Costumes_items_UN UNIQUE ( name ) ;

ALTER TABLE Costumes_items ADD CONSTRAINT chk_gender_id_value CHECK (gender_id in (1, 2, 3));

ALTER TABLE Costumes_items 
    ADD CONSTRAINT Costumes_items_Collections_FK FOREIGN KEY 
    ( 
     collection_id
    ) 
    REFERENCES Collections 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes_items 
    ADD CONSTRAINT Costumes_items_Colors_FK FOREIGN KEY 
    ( 
     color_id
    ) 
    REFERENCES Colors 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes_items 
    ADD CONSTRAINT Costumes_items_Genders_FK FOREIGN KEY 
    ( 
     gender_id
    ) 
    REFERENCES Genders 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes_items 
    ADD CONSTRAINT Costumes_items_Locations_FK FOREIGN KEY 
    ( 
     location_id
    ) 
    REFERENCES Locations 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_costumes_items_collection_id ON Costumes_items (collection_id);
CREATE INDEX idx_costumes_items_gender_id ON Costumes_items (gender_id);
CREATE INDEX idx_costumes_items_color_id ON Costumes_items (color_id);
CREATE INDEX idx_costumes_items_location_id ON Costumes_items (location_id);

CREATE TABLE Patterns 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (20)  NOT NULL 
    ) 
;

ALTER TABLE Patterns 
    ADD CONSTRAINT Patterns_PK PRIMARY KEY ( id ) ;

ALTER TABLE Patterns 
    ADD CONSTRAINT Patterns_UN UNIQUE ( name ) ;


CREATE TABLE Head_accessory_categories 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name VARCHAR (20)  NOT NULL 
    ) 
;

ALTER TABLE Head_accessory_categories 
    ADD CONSTRAINT Head_accessory_categories_PK PRIMARY KEY ( id ) ;

ALTER TABLE Head_accessory_categories 
    ADD CONSTRAINT Head_accessory_categories_UN UNIQUE ( name ) ;


CREATE TABLE Head_accessories 
    ( 
     costume_item_id    INTEGER  NOT NULL , 
     category_id        SMALLINT  NOT NULL , 
     head_circumference SMALLINT
    ) 
;

ALTER TABLE Head_accessories 
    ADD CONSTRAINT Head_accessories_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Head_accessories 
    ADD CONSTRAINT chk_head_circumference_value CHECK (head_circumference > 0 OR head_circumference IS NULL);


ALTER TABLE Head_accessories 
    ADD CONSTRAINT Head_accessories_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE Head_accessories 
    ADD CONSTRAINT Head_accessories_Head_accessory_categories_FK FOREIGN KEY 
    ( 
     category_id
    ) 
    REFERENCES Head_accessory_categories 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
; 

CREATE INDEX Idx_head_accessories_category_id ON Head_accessories(category_id);

CREATE TABLE Aprons 
    ( 
     costume_item_id INTEGER  NOT NULL , 
     length          SMALLINT  NOT NULL , 
     pattern_id      SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Aprons 
    ADD CONSTRAINT Aprons_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Aprons 
    ADD CONSTRAINT chk_length_value CHECK (length > 0);

ALTER TABLE Aprons 
    ADD CONSTRAINT Aprons_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE Aprons 
    ADD CONSTRAINT Aprons_Patterns_FK FOREIGN KEY 
    ( 
     pattern_id
    ) 
    REFERENCES Patterns 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_aprons_pattern_id ON Aprons(pattern_id);

CREATE TABLE Caftans 
    ( 
     costume_item_id           INTEGER  NOT NULL , 
     length                    SMALLINT  NOT NULL , 
     min_waist_circumference   SMALLINT  NOT NULL , 
     max_waist_circumference   SMALLINT  NOT NULL , 
     min_chest_circumference SMALLINT  NOT NULL , 
     max_chest_circumference   SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Caftans 
    ADD CONSTRAINT Caftans_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Caftans 
    ADD CONSTRAINT chk_length_value CHECK (length > 0);

ALTER TABLE Caftans 
    ADD CONSTRAINT chk_min_waist_circumference_value CHECK (min_waist_circumference > 0);

ALTER TABLE Caftans 
    ADD CONSTRAINT chk_max_waist_circumference_value CHECK (max_waist_circumference > 0);

ALTER TABLE Caftans 
    ADD CONSTRAINT chk_min_chest_circumference_value CHECK (min_chest_circumference > 0);

ALTER TABLE Caftans 
    ADD CONSTRAINT chk_max_chest_circumference_value CHECK (max_chest_circumference > 0);

ALTER TABLE Caftans 
    ADD CONSTRAINT chk_min_max_waist_circumference_value CHECK (min_waist_circumference <= max_waist_circumference);

ALTER TABLE Caftans 
    ADD CONSTRAINT chk_min_max_chest_circumference_value CHECK (min_chest_circumference <= max_chest_circumference);

ALTER TABLE Caftans 
    ADD CONSTRAINT Caftans_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
; 


CREATE TABLE Petticoats 
    ( 
     costume_item_id         INTEGER  NOT NULL , 
     length                  SMALLINT  NOT NULL , 
     min_waist_circumference SMALLINT  NOT NULL , 
     max_waist_circumference SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Petticoats 
    ADD CONSTRAINT Petticoats_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Petticoats 
    ADD CONSTRAINT chk_length_value CHECK (length > 0);

ALTER TABLE Petticoats 
    ADD CONSTRAINT chk_min_waist_circumference_value CHECK (min_waist_circumference > 0);

ALTER TABLE Petticoats 
    ADD CONSTRAINT chk_max_waist_circumference_value CHECK (max_waist_circumference > 0);

ALTER TABLE Petticoats 
    ADD CONSTRAINT chk_min_max_waist_circumference_value CHECK (min_waist_circumference <= max_waist_circumference);

ALTER TABLE Petticoats 
    ADD CONSTRAINT Petticoats_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;


CREATE TABLE Corsets 
    ( 
     costume_item_id         INTEGER  NOT NULL , 
     length                  SMALLINT  NOT NULL , 
     min_waist_circumference SMALLINT  NOT NULL , 
     max_waist_circumference SMALLINT  NOT NULL , 
     min_chest_circumference SMALLINT  NOT NULL , 
     max_chest_circumference SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Corsets 
    ADD CONSTRAINT Corsets_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Corsets 
    ADD CONSTRAINT chk_length_value CHECK (length > 0);

ALTER TABLE Corsets 
    ADD CONSTRAINT chk_min_waist_circumference_value CHECK (min_waist_circumference > 0);

ALTER TABLE Corsets 
    ADD CONSTRAINT chk_max_waist_circumference_value CHECK (max_waist_circumference > 0);

ALTER TABLE Corsets 
    ADD CONSTRAINT chk_min_max_waist_circumference_value CHECK (min_waist_circumference <= max_waist_circumference);

ALTER TABLE Corsets 
    ADD CONSTRAINT chk_min_chest_circumference_value CHECK (min_chest_circumference > 0);

ALTER TABLE Corsets 
    ADD CONSTRAINT chk_max_chest_circumference_value CHECK (max_chest_circumference > 0);

ALTER TABLE Corsets 
    ADD CONSTRAINT chk_min_max_chest_circumference_value CHECK (min_chest_circumference <= max_chest_circumference);

ALTER TABLE Corsets 
    ADD CONSTRAINT Corsets_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
; 


CREATE TABLE Skirts 
    ( 
     costume_item_id         INTEGER  NOT NULL , 
     length                  SMALLINT  NOT NULL , 
     min_waist_circumference SMALLINT  NOT NULL , 
     max_waist_circumference SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Skirts 
    ADD CONSTRAINT Skirts_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Skirts 
    ADD CONSTRAINT chk_length_value CHECK (length > 0);

ALTER TABLE Skirts 
    ADD CONSTRAINT chk_min_waist_circumference_value CHECK (min_waist_circumference > 0);

ALTER TABLE Skirts 
    ADD CONSTRAINT chk_max_waist_circumference_value CHECK (max_waist_circumference > 0);

ALTER TABLE Skirts 
    ADD CONSTRAINT chk_min_max_waist_circumference_value CHECK (min_waist_circumference <= max_waist_circumference);

ALTER TABLE Skirts 
    ADD CONSTRAINT Skirts_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
; 


CREATE TABLE Belts 
    ( 
     costume_item_id         INTEGER  NOT NULL , 
     min_waist_circumference SMALLINT  NOT NULL , 
     max_waist_circumference SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Belts 
    ADD CONSTRAINT Belts_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Belts 
    ADD CONSTRAINT chk_min_waist_circumference_value CHECK (min_waist_circumference > 0);

ALTER TABLE Belts 
    ADD CONSTRAINT chk_max_waist_circumference_value CHECK (max_waist_circumference > 0);

ALTER TABLE Belts 
    ADD CONSTRAINT chk_min_max_waist_circumference_value CHECK (min_waist_circumference <= max_waist_circumference);

ALTER TABLE Belts 
    ADD CONSTRAINT Belts_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;


CREATE TABLE Shirts 
    ( 
     costume_item_id         INTEGER  NOT NULL , 
     length                  SMALLINT  NOT NULL , 
     arm_length              SMALLINT  NOT NULL , 
     min_neck_circumference  SMALLINT  NOT NULL , 
     max_neck_circumference  SMALLINT  NOT NULL , 
     min_waist_circumference SMALLINT  NOT NULL , 
     max_waist_circumference SMALLINT  NOT NULL , 
     min_chest_circumference SMALLINT  NOT NULL , 
     max_chest_circumference SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Shirts 
    ADD CONSTRAINT Shirts_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_length_value CHECK (length > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_arm_length_value CHECK (arm_length > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_min_waist_circumference_value CHECK (min_waist_circumference > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_max_waist_circumference_value CHECK (max_waist_circumference > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_min_max_waist_circumference_value CHECK (min_waist_circumference <= max_waist_circumference);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_min_chest_circumference_value CHECK (min_chest_circumference > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_max_chest_circumference_value CHECK (max_chest_circumference > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_min_max_chest_circumference_value CHECK (min_chest_circumference <= max_chest_circumference);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_min_neck_circumference_value CHECK (min_neck_circumference > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_max_neck_circumference_value CHECK (max_neck_circumference > 0);

ALTER TABLE Shirts 
    ADD CONSTRAINT chk_min_max_neck_circumference_value CHECK (min_neck_circumference <= max_neck_circumference);

ALTER TABLE Shirts 
    ADD CONSTRAINT Shirts_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;


CREATE TABLE Pants 
    ( 
     costume_item_id         INTEGER  NOT NULL , 
     length                  SMALLINT  NOT NULL , 
     min_waist_circumference SMALLINT  NOT NULL , 
     max_waist_circumference SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Pants 
    ADD CONSTRAINT Pants_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Pants 
    ADD CONSTRAINT chk_length_value CHECK (length > 0);

ALTER TABLE Pants 
    ADD CONSTRAINT chk_min_waist_circumference_value CHECK (min_waist_circumference > 0);

ALTER TABLE Pants 
    ADD CONSTRAINT chk_max_waist_circumference_value CHECK (max_waist_circumference > 0);

ALTER TABLE Pants 
    ADD CONSTRAINT chk_min_max_waist_circumference_value CHECK (min_waist_circumference <= max_waist_circumference);

ALTER TABLE Pants 
    ADD CONSTRAINT Pants_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
; 


CREATE TABLE Boots 
    ( 
     costume_item_id INTEGER  NOT NULL , 
     shoe_size       FLOAT  NOT NULL 
    ) 
;

ALTER TABLE Boots 
    ADD CONSTRAINT Boots_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Boots 
    ADD CONSTRAINT chk_shoe_size_value CHECK (shoe_size > 0);

ALTER TABLE Boots 
    ADD CONSTRAINT Boots_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;


CREATE TABLE Neck_accessories 
    ( 
     costume_item_id        INTEGER  NOT NULL , 
     min_neck_circumference SMALLINT  NOT NULL , 
     max_neck_circumference SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Neck_accessories 
    ADD CONSTRAINT Neck_accessories_PK PRIMARY KEY ( costume_item_id ) ;

ALTER TABLE Neck_accessories 
    ADD CONSTRAINT chk_min_neck_circumference_value CHECK (min_neck_circumference > 0);

ALTER TABLE Neck_accessories 
    ADD CONSTRAINT chk_max_neck_circumference_value CHECK (max_neck_circumference > 0);

ALTER TABLE Neck_accessories 
    ADD CONSTRAINT chk_min_max_neck_circumference_value CHECK (min_neck_circumference <= max_neck_circumference);

ALTER TABLE Neck_accessories 
    ADD CONSTRAINT Neck_accessories_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
; 


CREATE TABLE Costumes 
    ( 
     id                SMALLINT GENERATED ALWAYS AS IDENTITY NOT NULL , 
     name              VARCHAR (30)  NOT NULL , 
     collection_id     SMALLINT  NOT NULL , 
     gender_id         SMALLINT  NOT NULL , 
     apron_id          INTEGER ,
     caftan_id         INTEGER , 
     petticoat_id      INTEGER , 
     corset_id         INTEGER , 
     skirt_id          INTEGER , 
     belt_id           INTEGER , 
     shirt_id          INTEGER , 
     pants_id          INTEGER , 
     boots_id          INTEGER , 
     neck_accessory_id INTEGER , 
     head_accessory_id INTEGER 
    ) 
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_PK PRIMARY KEY ( id ) ;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_UN UNIQUE ( name ) ;

ALTER TABLE Costumes ADD CONSTRAINT chk_gender_id_value CHECK (gender_id in (1, 2, 3));

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Aprons_FK FOREIGN KEY 
    ( 
     apron_id
    ) 
    REFERENCES Aprons 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Belts_FK FOREIGN KEY 
    ( 
     belt_id
    ) 
    REFERENCES Belts 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Boots_FK FOREIGN KEY 
    ( 
     boots_id
    ) 
    REFERENCES Boots 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Caftans_FK FOREIGN KEY 
    ( 
     caftan_id
    ) 
    REFERENCES Caftans 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Collections_FK FOREIGN KEY 
    ( 
     collection_id
    ) 
    REFERENCES Collections 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Corsets_FK FOREIGN KEY 
    ( 
     corset_id
    ) 
    REFERENCES Corsets 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Genders_FK FOREIGN KEY 
    ( 
     gender_id
    ) 
    REFERENCES Genders 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Head_accessories_FK FOREIGN KEY 
    ( 
     head_accessory_id
    ) 
    REFERENCES Head_accessories 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Neck_accessories_FK FOREIGN KEY 
    ( 
     neck_accessory_id
    ) 
    REFERENCES Neck_accessories 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Pants_FK FOREIGN KEY 
    ( 
     pants_id
    ) 
    REFERENCES Pants 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Petticoats_FK FOREIGN KEY 
    ( 
     petticoat_id
    ) 
    REFERENCES Petticoats 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Shirts_FK FOREIGN KEY 
    ( 
     shirt_id
    ) 
    REFERENCES Shirts 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Costumes 
    ADD CONSTRAINT Costumes_Skirts_FK FOREIGN KEY 
    ( 
     skirt_id
    ) 
    REFERENCES Skirts 
    ( 
     costume_item_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_costumes_collection_id ON Costumes(collection_id);
CREATE INDEX idx_costumes_gender_id ON Costumes(gender_id);
CREATE INDEX idx_costumes_apron_id ON Costumes(apron_id);
CREATE INDEX idx_costumes_caftan_id ON Costumes(caftan_id);
CREATE INDEX idx_costumes_petticoat_id ON Costumes(petticoat_id);
CREATE INDEX idx_costumes_corset_id ON Costumes(corset_id);
CREATE INDEX idx_costumes_skirt_id ON Costumes(skirt_id);
CREATE INDEX idx_costumes_belt_id ON Costumes(belt_id);
CREATE INDEX idx_costumes_shirt_id ON Costumes(shirt_id);
CREATE INDEX idx_costumes_pants_id ON Costumes(pants_id);
CREATE INDEX idx_costumes_boots_id ON Costumes(boots_id);
CREATE INDEX idx_costumes_neck_accessory_id ON Costumes(neck_accessory_id);
CREATE INDEX idx_costumes_head_accessory_id ON Costumes(head_accessory_id);


CREATE TABLE States_of_requests 
    ( 
     id   SMALLINT GENERATED ALWAYS AS IDENTITY  NOT NULL , 
     name VARCHAR (15)  NOT NULL 
    ) 
;

ALTER TABLE States_of_requests 
    ADD CONSTRAINT States_of_requests_PK PRIMARY KEY ( id ) ;

ALTER TABLE States_of_requests 
    ADD CONSTRAINT States_of_requests_UN UNIQUE ( name ) ;

INSERT INTO States_of_requests (name) VALUES ('PENDING'), ('ACCEPT'), ('DENY');

CREATE TABLE Requests 
    ( 
     id                INTEGER GENERATED ALWAYS AS IDENTITY  NOT NULL , 
     datetime          TIMESTAMP  NOT NULL , 
     requester_user_id INTEGER  NOT NULL , 
     state_id          SMALLINT  NOT NULL 
    ) 
;

ALTER TABLE Requests 
    ADD CONSTRAINT Requests_PK PRIMARY KEY ( id ) ;

ALTER TABLE Requests 
    ADD CONSTRAINT Requests_States_of_requests_FK FOREIGN KEY 
    ( 
     state_id
    ) 
    REFERENCES States_of_requests 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Requests 
    ADD CONSTRAINT Requests_Users_FK FOREIGN KEY 
    ( 
     requester_user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_requests_state_id ON Requests (state_id);
CREATE INDEX idx_requests_requester_user_id ON Requests (requester_user_id);
CREATE INDEX idx_requests_datetime ON Requests (datetime);

CREATE TABLE Rental_costume_item_requests 
    ( 
     request_id             INTEGER  NOT NULL , 
     costume_item_id       INTEGER  NOT NULL , 
     approver_costumier_id INTEGER  
    ) 
;

ALTER TABLE Rental_costume_item_requests 
    ADD CONSTRAINT Rental_costume_item_requests_PK PRIMARY KEY ( request_id ) ;

ALTER TABLE Rental_costume_item_requests 
    ADD CONSTRAINT Rental_costume_item_requests_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Rental_costume_item_requests 
    ADD CONSTRAINT Rental_costume_item_requests_Costumiers_FK FOREIGN KEY 
    ( 
     approver_costumier_id
    ) 
    REFERENCES Costumiers 
    ( 
     user_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Rental_costume_item_requests 
    ADD CONSTRAINT Rental_costume_item_requests_Requests_FK FOREIGN KEY 
    ( 
     request_id
    ) 
    REFERENCES Requests 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

CREATE INDEX idx_rental_requests_costume_item_id ON Rental_costume_item_requests (costume_item_id);
CREATE INDEX idx_rental_requests_approver_costumier_id ON Rental_costume_item_requests (approver_costumier_id);


CREATE TABLE Return_costume_item_requests 
    ( 
     request_id             INTEGER  NOT NULL , 
     costume_item_id       INTEGER  NOT NULL , 
     approver_costumier_id INTEGER  
    ) 
;

ALTER TABLE Return_costume_item_requests 
    ADD CONSTRAINT Return_costume_item_requests_PK PRIMARY KEY ( request_id ) ;

ALTER TABLE Return_costume_item_requests 
    ADD CONSTRAINT Return_costume_item_requests_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Return_costume_item_requests 
    ADD CONSTRAINT Return_costume_item_requests_Costumiers_FK FOREIGN KEY 
    ( 
     approver_costumier_id
    ) 
    REFERENCES Costumiers 
    ( 
     user_id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Return_costume_item_requests 
    ADD CONSTRAINT Return_costume_item_requests_Requests_FK FOREIGN KEY 
    ( 
     request_id
    ) 
    REFERENCES Requests 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

CREATE INDEX idx_return_requests_costume_item_id ON Return_costume_item_requests (costume_item_id);
CREATE INDEX idx_return_requests_approver_costumier_id ON Return_costume_item_requests (approver_costumier_id);


CREATE TABLE Borrow_costume_item_requests 
    ( 
     request_id        INTEGER  NOT NULL , 
     costume_item_id  INTEGER  NOT NULL , 
     approver_user_id INTEGER  NOT NULL 
    ) 
;

ALTER TABLE Borrow_costume_item_requests 
    ADD CONSTRAINT Borrow_costume_item_requests_PK PRIMARY KEY ( request_id ) ;

ALTER TABLE Borrow_costume_item_requests 
    ADD CONSTRAINT Borrow_costume_item_requests_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Borrow_costume_item_requests 
    ADD CONSTRAINT Borrow_costume_item_requests_Requests_FK FOREIGN KEY 
    ( 
     request_id
    ) 
    REFERENCES Requests 
    ( 
     id
    ) 
    ON DELETE CASCADE
    ON UPDATE CASCADE
;


ALTER TABLE Borrow_costume_item_requests 
    ADD CONSTRAINT Borrow_costume_item_requests_Users_FK FOREIGN KEY 
    ( 
     approver_user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_borrow_requests_costume_item_id ON Borrow_costume_item_requests (costume_item_id);
CREATE INDEX idx_borrow_requests_approver_costumier_id ON Borrow_costume_item_requests (approver_user_id);

CREATE TABLE Notifications 
    ( 
     id             INTEGER GENERATED ALWAYS AS IDENTITY  NOT NULL , 
     user_id        INTEGER  NOT NULL ,  
     content        TEXT  NOT NULL , 
     datetime       TIMESTAMP  NOT NULL , 
     marked_as_read CHAR (1) DEFAULT 'F'  NOT NULL,
     due_to_request_id    INTEGER 
    ) 
;

ALTER TABLE Notifications 
    ADD CONSTRAINT Notifications_PK PRIMARY KEY ( id ) ;

ALTER TABLE Notifications
    ADD CONSTRAINT chk_marked_as_read CHECK (marked_as_read in ('F', 'T'));

ALTER TABLE Notifications 
    ADD CONSTRAINT Notifications_Requests_FK FOREIGN KEY 
    ( 
     due_to_request_id
    ) 
    REFERENCES Requests 
    ( 
     id
    )
    ON DELETE CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE Notifications 
    ADD CONSTRAINT Notifications_Users_FK FOREIGN KEY 
    ( 
     user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_notifications_user_id ON Notifications (user_id);
CREATE INDEX idx_notifications_datetime ON Notifications (datetime);
CREATE INDEX idx_notifications_due_to_request_id ON Notifications (due_to_request_id);

CREATE TABLE Rentals 
    ( 
     id                     INTEGER GENERATED ALWAYS AS IDENTITY NOT NULL , 
     user_id                INTEGER  NOT NULL , 
     costume_item_id        INTEGER  NOT NULL , 
     done_due_request_id INTEGER  NOT NULL , 
     date_of_rental         TIMESTAMP  NOT NULL , 
     date_of_return         TIMESTAMP
    ) 
;

ALTER TABLE Rentals 
    ADD CONSTRAINT Rentals_PK PRIMARY KEY ( id ) ;

ALTER TABLE Rentals 
    ADD CONSTRAINT chk_date_of_rental_and_return_value CHECK (date_of_return IS NULL OR date_of_return > date_of_rental);

ALTER TABLE Rentals 
    ADD CONSTRAINT Rentals_Requests_FK FOREIGN KEY 
    ( 
     done_due_request_id
    ) 
    REFERENCES Requests 
    ( 
     id
    )
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Rentals 
    ADD CONSTRAINT Rentals_Costumes_items_FK FOREIGN KEY 
    ( 
     costume_item_id
    ) 
    REFERENCES Costumes_items 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

ALTER TABLE Rentals 
    ADD CONSTRAINT Rentals_Users_FK FOREIGN KEY 
    ( 
     user_id
    ) 
    REFERENCES Users 
    ( 
     id
    ) 
    ON DELETE RESTRICT
    ON UPDATE CASCADE
;

CREATE INDEX idx_rentals_user_id ON Rentals (user_id);
CREATE INDEX idx_rentals_costume_item_id ON Rentals (costume_item_id);
CREATE INDEX idx_rentals_date_of_rental ON Rentals (date_of_rental);
CREATE INDEX idx_rentals_date_of_return ON Rentals (date_of_return);
CREATE INDEX idx_rentals_done_due_request_id ON Rentals (done_due_request_id);

CREATE FUNCTION check_costume_inconsistency(
    f_collection_id     SMALLINT,
    f_gender_id         SMALLINT,
    f_apron_id          INTEGER,
    f_caftan_id         INTEGER,
    f_petticoat_id      INTEGER,
    f_corset_id         INTEGER,
    f_skirt_id          INTEGER,
    f_belt_id           INTEGER,
    f_shirt_id          INTEGER,
    f_pants_id          INTEGER,
    f_boots_id          INTEGER,
    f_neck_accessory_id INTEGER,
    f_head_accessory_id INTEGER
)
RETURNS BOOLEAN AS $$
DECLARE
    inconsistency_found BOOLEAN := FALSE;
BEGIN
    IF f_apron_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_apron_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Apron does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_apron_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Apron does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_belt_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_belt_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Belt does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_belt_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Belt does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_boots_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_boots_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Boots do not match collection % or are not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_boots_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Boots do not match gender % or are not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_caftan_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_caftan_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Caftan does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_caftan_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Caftan does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF f_corset_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_corset_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Corset does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_corset_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Corset does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_petticoat_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_petticoat_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Petticoat does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_petticoat_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Petticoat does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_skirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_skirt_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Skirt does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_skirt_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Skirt does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_shirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_shirt_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Shirt does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_shirt_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Shirts does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_pants_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_pants_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Pants does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_pants_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Pants does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_neck_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_neck_accessory_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Neck accessory does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_neck_accessory_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Neck accessory does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

	IF f_head_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Costumes_items
        WHERE id = f_head_accessory_id AND (collection_id = f_collection_id OR collection_id = 1);

        IF NOT FOUND THEN
            RAISE NOTICE 'Head accessory does not match collection % or is not universal', f_collection_id;
            inconsistency_found := TRUE;
        END IF;

        PERFORM 1
        FROM Costumes_items
        WHERE id = f_head_accessory_id AND (gender_id = f_gender_id OR gender_id = 3);

        IF NOT FOUND THEN
            RAISE NOTICE 'Head accessory does not match gender % or is not bigender', f_gender_id;
            inconsistency_found := TRUE;
        END IF;
    END IF;

    IF inconsistency_found THEN
        RETURN TRUE;
    END IF;

    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;



CREATE FUNCTION check_rental_inconsistency(
    f_user_id                INTEGER,
    f_costume_item_id        INTEGER,
    f_done_due_request_id    INTEGER
)
RETURNS BOOLEAN AS $$
DECLARE
    r_user_id INT;
    r_costume_item_id INT;
    inconsistency_found BOOLEAN := FALSE;
BEGIN
	SELECT r.requester_user_id, COALESCE(ren_r.costume_item_id, ret_r.costume_item_id, b_r.costume_item_id) INTO r_user_id, r_costume_item_id
	FROM Requests r
    LEFT JOIN Rental_costume_item_requests ren_r
        ON r.id=ren_r.request_id
    LEFT JOIN Return_costume_item_requests ret_r
        ON r.id=ret_r.request_id
    LEFT JOIN Borrow_costume_item_requests b_r
        ON r.id=b_r.request_id
	WHERE r.id = f_done_due_request_id;

    IF f_user_id <> r_user_id THEN
        RAISE NOTICE 'user_id are not consistency with request %', f_done_due_request_id;
        inconsistency_found := TRUE;
    END IF;

    IF f_costume_item_id <> r_costume_item_id THEN
        RAISE NOTICE 'costume_item_id are not consistency with request %', f_done_due_request_id;
        inconsistency_found := TRUE;
    END IF;

    IF inconsistency_found THEN
        RETURN TRUE;
    END IF;

    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;



CREATE FUNCTION check_if_error_in_costume_item_common_part(
    f_collection_id                SMALLINT,
    f_gender_id        SMALLINT,
    f_color_id    SMALLINT,
    f_location_id    SMALLINT
)
RETURNS BOOLEAN AS $$
DECLARE
    error_found BOOLEAN := FALSE;
BEGIN
	PERFORM 1
	FROM Collections
	WHERE
		id = f_collection_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Collection with id % does not exist', f_collection_id;
        error_found := TRUE;
	END IF;

    IF f_gender_id NOT IN (1, 2, 3) THEN
        RAISE NOTICE 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
        error_found := TRUE;
    END IF;

    PERFORM 1
	FROM Genders
	WHERE
		id = f_gender_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Gender with id % does not exist', f_gender_id;
        error_found := TRUE;
	END IF;

    PERFORM 1
	FROM Colors
	WHERE
		id = f_color_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Color with id % does not exist', f_color_id;
        error_found := TRUE;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = f_location_id;

	IF NOT FOUND THEN
		RAISE NOTICE 'Location with id % does not exist', f_location_id;
        error_found := TRUE;
	END IF;

    IF error_found THEN
        RETURN TRUE;
    END IF;

    RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION check_costume_item_has_class_extenction() RETURNS TRIGGER AS $$
    BEGIN
      	IF NOT EXISTS (
			SELECT 1
			FROM ((SELECT 1 AS "is_in" FROM Neck_accessories WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Boots WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Pants WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Shirts WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Belts WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Skirts WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Corsets WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Petticoats WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Caftans WHERE costume_item_id = NEW.costume_item_id)
			      UNION
			      (SELECT 1 AS "is_in" FROM Aprons WHERE costume_item_id = NEW.costume_item_id)
				  UNION
			      (SELECT 1 AS "is_in" FROM Head_accessories WHERE costume_item_id = NEW.costume_item_id)) t
			GROUP BY
			    t.is_in
			HAVING
    			SUM(t.is_in) > 0
		) THEN
			RETURN NEW;
        END IF;

		RETURN NULL;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Head_accessories
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Aprons
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Caftans
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Petticoats
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Corsets
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Skirts
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Belts
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Shirts
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Pants
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Boots
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();

CREATE TRIGGER prevent_invalid_costume_item_insert BEFORE INSERT ON Neck_accessories
    FOR EACH ROW EXECUTE FUNCTION check_costume_item_has_class_extenction();


CREATE FUNCTION check_costume_consistency()
RETURNS TRIGGER AS $$
BEGIN
    IF check_costume_inconsistency(
    NEW.collection_id, NEW.gender_id, NEW.apron_id, NEW.caftan_id, NEW.petticoat_id, NEW.corset_id,
    NEW.skirt_id, NEW.belt_id, NEW.shirt_id, NEW.pants_id, NEW.boots_id, NEW.neck_accessory_id,
    NEW.head_accessory_id) THEN
        RAISE EXCEPTION 'Costume is inconsistancy';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_costume_insert_update BEFORE INSERT OR UPDATE ON Costumes
FOR EACH ROW EXECUTE FUNCTION check_costume_consistency();

CREATE FUNCTION check_request_state()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.state_id = 1 THEN
        RETURN OLD;
    END IF;
    RAISE NOTICE 'Cannot delete closed request';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_request_delete BEFORE DELETE ON Requests
FOR EACH ROW EXECUTE FUNCTION check_request_state();


CREATE FUNCTION check_request_has_type_extenction()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM ((SELECT 1 AS "is_in" FROM Return_costume_item_requests WHERE request_id = NEW.request_id)
                UNION
                (SELECT 1 AS "is_in" FROM Rental_costume_item_requests WHERE request_id = NEW.request_id)
                UNION
                (SELECT 1 AS "is_in" FROM Borrow_costume_item_requests WHERE request_id = NEW.request_id)) t
        GROUP BY
            t.is_in
        HAVING
            SUM(t.is_in) > 0
    ) THEN
        RETURN NEW;
    END IF;

    RAISE NOTICE 'Request has already extenction';
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_request_insert BEFORE INSERT ON Rental_costume_item_requests
    FOR EACH ROW EXECUTE FUNCTION check_request_has_type_extenction();

CREATE TRIGGER prevent_invalid_request_insert BEFORE INSERT ON Return_costume_item_requests
    FOR EACH ROW EXECUTE FUNCTION check_request_has_type_extenction();

CREATE TRIGGER prevent_invalid_request_insert BEFORE INSERT ON Borrow_costume_item_requests
    FOR EACH ROW EXECUTE FUNCTION check_request_has_type_extenction();


CREATE FUNCTION check_rental_costume_item_request_costume_item()
RETURNS TRIGGER AS $$
BEGIN
	PERFORM 1
    FROM Rentals
    WHERE costume_item_id = NEW.costume_item_id AND date_of_return IS NULL;

    IF FOUND THEN
        RAISE EXCEPTION 'Cannot create request to rent costume item with id % because it is already rented', NEW.costume_item_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_rental_costume_item_request_insert BEFORE INSERT ON Rental_costume_item_requests
FOR EACH ROW EXECUTE FUNCTION check_rental_costume_item_request_costume_item();


CREATE FUNCTION check_return_costume_item_request_costume_item()
RETURNS TRIGGER AS $$
DECLARE
    r_user_id INT;
BEGIN
    SELECT requester_user_id INTO r_user_id
	FROM Requests
	WHERE id = NEW.request_id;

	PERFORM 1
    FROM Rentals
    WHERE user_id = r_user_id AND costume_item_id = NEW.costume_item_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Cannot create request to return costume item which you do not rent';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_return_costume_item_request_insert BEFORE INSERT ON Return_costume_item_requests
FOR EACH ROW EXECUTE FUNCTION check_return_costume_item_request_costume_item();


CREATE FUNCTION check_borrow_costume_item_request_approver_and_costume_item()
RETURNS TRIGGER AS $$
DECLARE
    r_user_id INT;
BEGIN
	PERFORM 1
    FROM Rentals
    WHERE costume_item_id = NEW.costume_item_id AND user_id = NEW.approver_user_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User % does not have requested costume item', NEW.approver_user_id;
    END IF;

	SELECT requester_user_id INTO r_user_id
	FROM Requests
	WHERE id = NEW.request_id;

    IF NEW.approver_user_id = r_user_id THEN
        RAISE EXCEPTION 'You cannot borrow costume item to yourself';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_borrow_costume_item_request_insert BEFORE INSERT ON Borrow_costume_item_requests
FOR EACH ROW EXECUTE FUNCTION check_borrow_costume_item_request_approver_and_costume_item();


CREATE FUNCTION check_notification_due_to_request()
RETURNS TRIGGER AS $$
DECLARE
    r_user_id INT;
BEGIN
    IF NEW.due_to_request_id IS NOT NULL THEN
        SELECT requester_user_id INTO r_user_id
        FROM Requests
        WHERE id = NEW.due_to_request_id;

        IF NEW.user_id <> r_user_id THEN
            RAISE EXCEPTION 'User id and requester id from request are not the same';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_notification_insert BEFORE INSERT ON Notifications
FOR EACH ROW EXECUTE FUNCTION check_notification_due_to_request();


CREATE FUNCTION check_rental_consistency()
RETURNS TRIGGER AS $$
BEGIN
    IF check_rental_inconsistency(NEW.user_id, NEW.costume_item_id, NEW.done_due_request_id) THEN
        RAISE EXCEPTION 'Rental is inconsistancy';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_invalid_rental_insert BEFORE INSERT ON Rentals
FOR EACH ROW EXECUTE FUNCTION check_rental_consistency();

CREATE OR REPLACE VIEW Locations_with_settlements_regions_countries ( id, street, building_number, postal_code, settlement, region, country ) AS
SELECT l.id, l.street, l.building_number, l.postal_code, s.name AS "settlement", r.name AS "region", c.name AS "country"
FROM Locations l
INNER JOIN Settlements s
	ON l.settlement_id=s.id
INNER JOIN Regions r
	ON s.region_id=r.id
INNER JOIN Countries c
	ON r.country_id=c.id
;


CREATE OR REPLACE VIEW  User_count_by_settlement ( settlement, number_of_users ) AS
SELECT s.name AS "settlement", COUNT(*) AS "number_of_users"
FROM Users u
INNER JOIN Locations l
	ON u.home_location_id=l.id
INNER JOIN Settlements s
	ON l.settlement_id=s.id
GROUP BY
s.name
ORDER BY
s.name
ASC
;


CREATE OR REPLACE VIEW User_function_counts ( user_function, number_of_users_with_this_function ) AS
SELECT 'Costumiers' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Costumiers
UNION
SELECT 'Singers' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Singers
UNION
SELECT 'Musicians' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Musicians
UNION
SELECT 'Dancers' AS "function", COUNT(*) AS "number_of_users_with_this_function"
FROM Dancers
;

CREATE OR REPLACE VIEW Detailed_users ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, singer_role, musician_role, dancer_role, costumier_role, costumier_work_address_street, costumier_work_address_building_number, costumier_work_address_postal_code, costumier_work_address_settlement, costumier_work_address_region, costumier_work_address_country ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, sr.name AS "singer_role", mr.name AS "musician_role", dr.name AS "dancer_role", cr.name AS "costumier_role", w.street AS "costumier_work_address_street", w.building_number AS "costumier_work_address_building_number", w.postal_code AS "costumier_work_address_postal_code", w.settlement AS "costumier_work_address_settlement", w.region AS "costumier_work_address_region", w.country AS "costumier_work_address_country"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
LEFT JOIN Singers s
	ON u.id=s.user_id
LEFT JOIN Roles sr
	ON s.role_id=sr.id
LEFT JOIN Musicians m
	ON u.id=m.user_id
LEFT JOIN Roles mr
	ON m.role_id=mr.id
LEFT JOIN Dancers d
	ON u.id=d.user_id
LEFT JOIN Roles dr
	ON d.role_id=dr.id
LEFT JOIN Costumiers c
	ON u.id=c.user_id
LEFT JOIN Roles cr
	ON c.role_id=cr.id
LEFT JOIN Locations_with_settlements_regions_countries w
	ON c.work_location_id=w.id
;


CREATE OR REPLACE VIEW Detailed_singers ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, role, voices ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, sr.name AS "role", STRING_AGG(tov.name, ', ') AS "voices"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
INNER JOIN Singers s
	ON u.id=s.user_id
INNER JOIN Roles sr
	ON s.role_id=sr.id
INNER JOIN Singer_voices sv
	ON s.user_id=sv.singer_id
INNER JOIN Types_of_voices tov
	ON sv.type_of_voice_id=tov.id
GROUP BY
	u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name, l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, sr.name
ORDER BY
	u.last_name, u.first_name
ASC
;


CREATE OR REPLACE VIEW Detailed_musicians ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, role, instruments ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, mr.name AS "role", STRING_AGG(toi.name, ', ') AS "instruments"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
INNER JOIN Musicians m
	ON u.id=m.user_id
INNER JOIN Roles mr
	ON m.role_id=mr.id
INNER JOIN Musician_instrument mi
	ON m.user_id=mi.musician_id
INNER JOIN Types_of_instruments toi
	ON mi.type_of_instrument_id=toi.id
GROUP BY
	u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name, l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, mr.name
ORDER BY
	u.last_name, u.first_name
ASC
;


CREATE OR REPLACE VIEW Detailed_dancers ( id, first_name, last_name, date_of_birth, email, phone_number, gender, home_address_street, home_address_building_number, home_address_postal_code, home_address_settlement, home_address_region, home_address_country, height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length, torso_length, shoe_size, role, dances ) AS
SELECT u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name AS "gender", l.street AS "home_address_street", l.building_number AS "home_address_building_number", l.postal_code AS "home_address_postal_code", l.settlement AS "home_address_settlement", l.region AS "home_address_region", l.country AS "home_address_country", u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, dr.name AS "role", STRING_AGG(dan.name, ', ') AS "dances"
FROM Users u
INNER JOIN Genders g
	ON u.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON u.home_location_id=l.id
INNER JOIN Dancers d
	ON u.id=d.user_id
INNER JOIN Roles dr
	ON d.role_id=dr.id
INNER JOIN Dancer_dance dd
	ON d.user_id=dd.dancer_id
INNER JOIN Dances dan
	ON dd.dance_id=dan.id
GROUP BY
	u.id, u.first_name, u.last_name, u.date_of_birth, u.email, u.phone_number, g.name, l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, u.height, u.waist_circumference, u.chest_circumference, u.head_circumference, u.neck_circumference, u.leg_length, u.arm_length, u.torso_length, u.shoe_size, dr.name
ORDER BY
	u.last_name, u.first_name
ASC
;


CREATE OR REPLACE VIEW Singer_count_by_voice_type ( type_of_voice, number_of_singers ) AS
SELECT tov.name AS "type_of_voice", COUNT(*) AS "number_of_singers"
FROM Singer_voices sv
INNER JOIN Types_of_voices tov
	ON sv.type_of_voice_id=tov.id
GROUP BY
	tov.name
ORDER BY
	tov.name
ASC
;


CREATE OR REPLACE VIEW Musician_count_by_instrument_type ( type_of_instrument, number_of_musicians ) AS
SELECT toi.name AS "type_of_instrument", COUNT(*) AS "number_of_musicians"
FROM Musician_instrument mi
INNER JOIN Types_of_instruments toi
	ON mi.type_of_instrument_id=toi.id
GROUP BY
	toi.name
ORDER BY
	toi.name
ASC
;


CREATE OR REPLACE VIEW Dancer_count_by_dance_type ( type_of_dance, number_of_dancers ) AS
SELECT d.name AS "type_of_dance", COUNT(*) AS "number_of_dancers"
FROM Dancer_dance dd
INNER JOIN Dances d
	ON dd.dance_id=d.id
GROUP BY
	d.name
ORDER BY
	d.name
ASC
;


CREATE OR REPLACE VIEW Costume_item_count_by_collection_and_class ( costume_item_class, collection, number_of_items) AS
(SELECT 'apron' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Aprons type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'caftan' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Caftans type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'petticoat' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Petticoats type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'corset' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Corsets type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'skirt' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Skirts type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'belt' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Belts type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'shirt' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Shirts type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'pants' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Pants type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'boots' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Boots type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'neck_accessory' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Neck_accessories type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
UNION
(SELECT 'head_accessory' AS "costume_item_class", c.name AS "collection",  COUNT(*) AS "number_of_items"
FROM Head_accessories type
INNER JOIN Costumes_items ci
	ON type.costume_item_id=ci.id
INNER JOIN Collections c
	ON ci.collection_id=c.id
GROUP BY
	c.name
ORDER BY
	c.name
ASC)
;


CREATE OR REPLACE VIEW Costume_item_count_by_class ( costume_item_class, number_of_items) AS
(SELECT 'apron' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Aprons)
UNION
(SELECT 'caftan' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Caftans)
UNION
(SELECT 'petticoat' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Petticoats)
UNION
(SELECT 'corset' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Corsets)
UNION
(SELECT 'skirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Skirts)
UNION
(SELECT 'belt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Belts)
UNION
(SELECT 'shirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Shirts)
UNION
(SELECT 'pants' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Pants)
UNION
(SELECT 'boots' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Boots)
UNION
(SELECT 'neck_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Neck_accessories)
UNION
(SELECT 'head_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Head_accessories)
;


CREATE OR REPLACE VIEW Detailed_aprons ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, pattern ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, a.length, p.name AS "pattern"
FROM Aprons a
INNER JOIN Costumes_items ci
	ON a.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
INNER JOIN Patterns p
	ON a.pattern_id=p.id
;




CREATE OR REPLACE VIEW Detailed_boots ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, shoe_size ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, b.shoe_size
FROM Boots b
INNER JOIN Costumes_items ci
	ON b.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;



CREATE OR REPLACE VIEW Detailed_petticoats ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, p.length, p.min_waist_circumference, p.max_waist_circumference
FROM Petticoats p
INNER JOIN Costumes_items ci
	ON p.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;




CREATE OR REPLACE VIEW Detailed_skirts ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, s.length, s.min_waist_circumference, s.max_waist_circumference
FROM Skirts s
INNER JOIN Costumes_items ci
	ON s.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;




CREATE OR REPLACE VIEW Detailed_caftans ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference, min_chest_circumference, max_chest_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, c.length, c.min_waist_circumference, c.max_waist_circumference, c.min_chest_circumference, c.max_chest_circumference
FROM Caftans c
INNER JOIN Costumes_items ci
	ON c.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;


CREATE OR REPLACE VIEW Detailed_corsets ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference, min_chest_circumference, max_chest_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, c.length, c.min_waist_circumference, c.max_waist_circumference, c.min_chest_circumference, c.max_chest_circumference
FROM Corsets c
INNER JOIN Costumes_items ci
	ON c.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;


CREATE OR REPLACE VIEW Detailed_neck_accessories ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, min_neck_circumference, max_neck_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, na.min_neck_circumference, na.max_neck_circumference
FROM Neck_accessories na
INNER JOIN Costumes_items ci
	ON na.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;



CREATE OR REPLACE VIEW Detailed_head_accessories ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, head_circumference, category ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, ha.head_circumference, hac.name AS "category"
FROM Head_accessories ha
INNER JOIN Costumes_items ci
	ON ha.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
INNER JOIN Head_accessory_categories hac
	ON ha.category_id=hac.id
;



CREATE OR REPLACE VIEW Detailed_belts ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, b.min_waist_circumference, b.max_waist_circumference
FROM Belts b
INNER JOIN Costumes_items ci
	ON b.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;



CREATE OR REPLACE VIEW Detailed_pants ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, p.length, p.min_waist_circumference, p.max_waist_circumference
FROM Pants p
INNER JOIN Costumes_items ci
	ON p.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;



CREATE OR REPLACE VIEW Detailed_shirts ( id, name, collection, color, gender, street, building_number, postal_code, settlement, region, country, length, min_waist_circumference, max_waist_circumference, min_chest_circumference, max_chest_circumference, min_neck_circumference, max_neck_circumference, arm_length ) AS
SELECT ci.id, ci.name, collec.name AS "collection", color.name AS "color", g.name AS "gender", l.street, l.building_number, l.postal_code, l.settlement, l.region, l.country, s.length, s.min_waist_circumference, s.max_waist_circumference, s.min_chest_circumference, s.max_chest_circumference, s.min_neck_circumference, s.max_neck_circumference, s.arm_length
FROM Shirts s
INNER JOIN Costumes_items ci
	ON s.costume_item_id=ci.id
INNER JOIN Collections collec
	ON ci.collection_id=collec.id
INNER JOIN Colors color
	ON ci.color_id=color.id
INNER JOIN Genders g
	ON ci.gender_id=g.id
INNER JOIN Locations_with_settlements_regions_countries l
	ON ci.location_id=l.id
;



CREATE OR REPLACE VIEW Costume_with_costume_items_name ( id, name, collection, gender, apron, caftan, petticoate, corset, skirt, belt, shirt, pants, boots, neck_accessory, head_accessory ) AS
SELECT c.id, c.name, col.name AS "collection", g.name AS "gender", COALESCE(a.name, 'N/A') AS "apron", COALESCE(ca.name, 'N/A') AS "caftan", COALESCE(p.name, 'N/A') AS "petticoate", COALESCE(co.name, 'N/A') AS "corset", COALESCE(sk.name, 'N/A') AS "skirt", COALESCE(b.name, 'N/A') AS "belt", COALESCE(sh.name, 'N/A') AS "shirt", COALESCE(pa.name, 'N/A') AS "pants", COALESCE(bo.name, 'N/A') AS "boots", COALESCE(ne.name, 'N/A') AS "neck_accessory", COALESCE(h.name, 'N/A') AS "head_accessory"
FROM Costumes c
INNER JOIN Collections col
	ON c.collection_id=col.id
INNER JOIN Genders g
	ON c.gender_id=g.id
LEFT JOIN Aprons ia
	ON c.apron_id=ia.costume_item_id
LEFT JOIN Costumes_items a
	ON ia.costume_item_id=a.id
LEFT JOIN Caftans ica
	ON c.caftan_id=ica.costume_item_id
LEFT JOIN Costumes_items ca
	ON ica.costume_item_id=ca.id
LEFT JOIN Petticoats ip
	ON c.petticoat_id=ip.costume_item_id
LEFT JOIN Costumes_items p
	ON ip.costume_item_id=p.id
LEFT JOIN Corsets ico
	ON c.corset_id=ico.costume_item_id
LEFT JOIN Costumes_items co
	ON ico.costume_item_id=co.id
LEFT JOIN Skirts isk
	ON c.skirt_id=isk.costume_item_id
LEFT JOIN Costumes_items sk
	ON isk.costume_item_id=sk.id
LEFT JOIN Belts ib
	ON c.belt_id=ib.costume_item_id
LEFT JOIN Costumes_items b
	ON ib.costume_item_id=b.id
LEFT JOIN Shirts ish
	ON c.shirt_id=ish.costume_item_id
LEFT JOIN Costumes_items sh
	ON ish.costume_item_id=sh.id
LEFT JOIN Pants ipa
	ON c.pants_id=ipa.costume_item_id
LEFT JOIN Costumes_items pa
	ON ipa.costume_item_id=pa.id
LEFT JOIN Boots ibo
	ON c.boots_id=ibo.costume_item_id
LEFT JOIN Costumes_items bo
	ON ibo.costume_item_id=bo.id
LEFT JOIN Neck_accessories ine
	ON c.neck_accessory_id=ine.costume_item_id
LEFT JOIN Costumes_items ne
	ON ine.costume_item_id=ne.id
LEFT JOIN Head_accessories ih
	ON c.head_accessory_id=ih.costume_item_id
LEFT JOIN Costumes_items h
	ON ih.costume_item_id=h.id
;


CREATE OR REPLACE VIEW Not_read_notifications ( id, user_id, content, datetime, due_to_request_id ) AS
SELECT id, user_id, content, datetime, due_to_request_id
FROM Notifications
WHERE marked_as_read = 'F'
;


CREATE OR REPLACE VIEW Detailed_rental_costume_item_requests ( id, datetime, requester_user_id, state, costume_item_id, approver_costumier_id ) AS
SELECT r.id, r.datetime, r.requester_user_id, s.name AS "state", rr.costume_item_id, rr.approver_costumier_id
FROM Rental_costume_item_requests rr
INNER JOIN Requests r
	ON rr.request_id=r.id
INNER JOIN States_of_requests s
	ON r.state_id=s.id
;


CREATE OR REPLACE VIEW Detailed_return_costume_item_requests ( id, datetime, requester_user_id, state, costume_item_id, approver_costumier_id ) AS
SELECT r.id, r.datetime, r.requester_user_id, s.name AS "state", rr.costume_item_id, rr.approver_costumier_id
FROM Return_costume_item_requests rr
INNER JOIN Requests r
	ON rr.request_id=r.id
INNER JOIN States_of_requests s
	ON r.state_id=s.id
;


CREATE OR REPLACE VIEW Detailed_borrow_costume_item_requests ( id, datetime, requester_user_id, state, costume_item_id, approver_user_id ) AS
SELECT r.id, r.datetime, r.requester_user_id, s.name AS "state", rr.costume_item_id, rr.approver_user_id
FROM Borrow_costume_item_requests rr
INNER JOIN Requests r
	ON rr.request_id=r.id
INNER JOIN States_of_requests s
	ON r.state_id=s.id
;


CREATE OR REPLACE VIEW Detailed_costume_item_requests ( id, datetime, type, requester_user_id, state, costume_item_id, approver_id ) AS
(SELECT d.id, d.datetime, 'RENTAL' AS "type", d.requester_user_id, d.state, d.costume_item_id, d.approver_costumier_id
FROM Detailed_rental_costume_item_requests d)
UNION
(SELECT d.id, d.datetime, 'RETURN' AS "type", d.requester_user_id, d.state, d.costume_item_id, d.approver_costumier_id
FROM Detailed_return_costume_item_requests d)
UNION
(SELECT d.id, d.datetime, 'BORROW' AS "type", d.requester_user_id, d.state, d.costume_item_id, d.approver_user_id
FROM Detailed_borrow_costume_item_requests d)
;


CREATE OR REPLACE VIEW Current_rentals_count_by_costume_item_class ( costume_item_class, number_of_rent_items ) AS
SELECT *
FROM ((SELECT 'apron' AS "costume_item_class", COUNT(*) AS "number_of_rent_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Aprons))
UNION
(SELECT 'caftan' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Caftans))
UNION
(SELECT 'petticoat' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Petticoats))
UNION
(SELECT 'corset' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Corsets))
UNION
(SELECT 'skirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Skirts))
UNION
(SELECT 'belt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Belts))
UNION
(SELECT 'shirt' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Shirts))
UNION
(SELECT 'pants' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Pants))
UNION
(SELECT 'boots' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Boots))
UNION
(SELECT 'neck_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Neck_accessories))
UNION
(SELECT 'head_accessory' AS "costume_item_class", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND costume_item_id IN (SELECT costume_item_id FROM Head_accessories))) t
ORDER BY
    t.costume_item_class
ASC
;



CREATE OR REPLACE VIEW Current_rentals_count_by_user_function ( costume_item_class, number_of_rent_items ) AS
SELECT *
FROM ((SELECT 'costumier' AS "user_function", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Costumiers))
UNION
(SELECT 'singer' AS "user_function", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Singers))
UNION
(SELECT 'musician' AS "user_function", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Musicians))
UNION
(SELECT 'dancer' AS "user_function", COUNT(*) AS "number_of_items"
FROM Rentals
WHERE date_of_return IS NULL AND user_id IN (SELECT user_id FROM Dancers))) t
ORDER BY
	t.user_function
ASC
;


CREATE OR REPLACE VIEW Detailed_rentals ( id, user_id, user_first_name, user_last_name, costume_item_id, costume_item_name, done_due_request_id, date_of_rental, date_of_return ) AS
SELECT r.id, r.user_id, u.first_name AS "user_first_name", u.last_name AS "user_last_name", r.costume_item_id, ci.name AS "costume_item_name", r.done_due_request_id, r.date_of_rental, r.date_of_return
FROM Rentals r
INNER JOIN Users u
	ON r.user_id = u.id
INNER JOIN Costumes_items ci
	ON r.costume_item_id = ci.id
;


CREATE OR REPLACE VIEW Detailed_current_rentals ( id, user_id, user_first_name, user_last_name, costume_item_id, costume_item_name, done_due_request_id, date_of_rental, date_of_return ) AS
SELECT d.id, d.user_id, d.user_first_name, d.user_last_name, d.costume_item_id, d.costume_item_name, d.done_due_request_id, d.date_of_rental, d.date_of_return
FROM Detailed_rentals d
WHERE d.date_of_return IS NULL
ORDER BY
	d.date_of_rental
ASC
;

CREATE OR REPLACE FUNCTION get_costume_item_rental_history(
    f_costume_item_id INT
)
RETURNS TABLE (
    costume_item_name VARCHAR,
    user_id INT,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    date_of_rental TIMESTAMP,
    date_of_return TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.costume_item_name,
        d.user_id,
        d.user_first_name,
        d.user_last_name,
        d.date_of_rental,
        d.date_of_return
    FROM
        Detailed_rentals d
    WHERE
        d.costume_item_id = f_costume_item_id
    ORDER BY
        d.date_of_rental
    ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_rental_history(
    f_user_id INT
)
RETURNS TABLE (
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR,
    date_of_rental TIMESTAMP,
    date_of_return TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.user_first_name,
        d.user_last_name,
        d.costume_item_id,
        d.costume_item_name,
        d.date_of_rental,
        d.date_of_return
    FROM
        Detailed_rentals d
    WHERE
        d.user_id = f_user_id
    ORDER BY
        d.date_of_rental
    ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_costumier_unresolved_requests()
RETURNS TABLE (
    request_id INT,
    request_state VARCHAR,
    request_datetie TIMESTAMP,
    user_id INT,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM ((SELECT r.id, r.state, r.datetime, r.requester_user_id, u.first_name, u.last_name, r.costume_item_id, ci.name
    FROM
        Detailed_rental_costume_item_requests r
    INNER JOIN
        Users u
        ON r.requester_user_id = u.id
    INNER JOIN
        Costumes_items ci
        ON r.costume_item_id = ci.id
    WHERE
        r.approver_costumier_id IS NULL)
    UNION
    (SELECT r.id, r.state, r.datetime, r.requester_user_id, u.first_name, u.last_name, r.costume_item_id, ci.name
    FROM
        Detailed_return_costume_item_requests r
    INNER JOIN
        Users u
        ON r.requester_user_id = u.id
    INNER JOIN
        Costumes_items ci
        ON r.costume_item_id = ci.id
    WHERE
        r.approver_costumier_id IS NULL)) t
    ORDER BY
        t.datetime
    ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_unresolved_borrow_requests(
    f_user_id INT
)
RETURNS TABLE (
    request_id INT,
    request_state TEXT,
    request_datetie TIMESTAMP,
    user_id INT,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        r.id,
        r.state,
        r.datetime,
        r.requester_user_id,
        u.first_name,
        u.last_name,
        r.costume_item_id,
        ci.name
    FROM
        Detailed_borrow_costume_item_requests r
    INNER JOIN
        Users u
        ON r.requester_user_id = u.id
    INNER JOIN
        Costumes_items ci
        ON r.costume_item_id = ci.id
    WHERE
        r.approver_costumier_id = f_user_id
        AND
        (r.state <> 'ACCEPT' AND r.state <> 'DENY')
    ORDER BY
        r.datetime
    ASC;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_current_rentals(
    f_user_id INT
)
RETURNS TABLE (
    rental_id INT,
    date_of_rental TIMESTAMP,
    user_first_name VARCHAR,
    user_last_name VARCHAR,
    costume_item_id INT,
    costume_item_name VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.date_of_rental,
        d.user_first_name,
        d.user_last_name,
        d.costume_item_id,
        d.costume_item_name
    FROM
        Detailed_current_rentals d
    WHERE
        d.user_id = f_user_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_function_percentage()
RETURNS TABLE (
    user_function TEXT,
    percentage_of_users_with_this_function TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        ufc.user_function,
        CONCAT(((ufc.number_of_users_with_this_function/(SELECT COUNT(*) FROM Users))*100), '%')
    FROM
        User_function_counts ufc;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_aprons(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    length SMALLINT,
    pattern VARCHAR
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.length,
        d.pattern
    FROM
        Detailed_aprons d
    WHERE
        d.length >= 0.76*user_leg_length - 5
        AND
        d.length <= 0.76*user_leg_length + 5;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_boots(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    shoe_size FLOAT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.shoe_size
    FROM
        Detailed_boots d
    WHERE
        d.shoe_size = (SELECT u.shoe_size FROM Users u WHERE u.id = f_user_id);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_petticoats(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    length SMALLINT,
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.length,
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM
        Detailed_petticoats d
    WHERE
        d.length >= 0.76*user_leg_length - 5
        AND
        d.length <= 0.76*user_leg_length + 5
        AND
        user_waist_circumference >= d.min_waist_circumference
        AND
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_skirts(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    length SMALLINT,
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.length,
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM
        Detailed_skirts d
    WHERE
        d.length >= 0.76*user_leg_length - 5
        AND
        d.length <= 0.76*user_leg_length + 5
        AND
        user_waist_circumference >= d.min_waist_circumference
        AND
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_caftans(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    length SMALLINT,
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT,
    min_chest_circumference SMALLINT,
    max_chest_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
    user_chest_circumference SMALLINT := (SELECT u.chest_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.length,
        d.min_waist_circumference,
        d.max_waist_circumference,
        d.min_chest_circumference,
        d.max_chest_circumference
    FROM
        Detailed_caftans d
    WHERE
        d.length >= 0.60*user_leg_length
        AND
        user_waist_circumference >= d.min_waist_circumference
        AND
        user_waist_circumference <= d.max_waist_circumference
        AND
        user_chest_circumference >= d.min_chest_circumference
        AND
        user_chest_circumference <= d.max_chest_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_corsets(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    length SMALLINT,
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT,
    min_chest_circumference SMALLINT,
    max_chest_circumference SMALLINT
) AS $$
DECLARE
    user_torso_length SMALLINT := (SELECT u.torso_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
    user_chest_circumference SMALLINT := (SELECT u.chest_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.length,
        d.min_waist_circumference,
        d.max_waist_circumference,
        d.min_chest_circumference,
        d.max_chest_circumference
    FROM
        Detailed_corsets d
    WHERE
        d.length >= user_torso_length
        AND
        user_waist_circumference >= d.min_waist_circumference
        AND
        user_waist_circumference <= d.max_waist_circumference
        AND
        user_chest_circumference >= d.min_chest_circumference
        AND
        user_chest_circumference <= d.max_chest_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_neck_accessories(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    min_neck_circumference SMALLINT,
    max_neck_circumference SMALLINT
) AS $$
DECLARE
    user_neck_circumference SMALLINT := (SELECT u.neck_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.min_neck_circumference,
        d.max_neck_circumference
    FROM
        Detailed_neck_accessories d
    WHERE
        user_neck_circumference >= d.min_neck_circumference
        AND
        user_neck_circumference <= d.max_neck_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_head_accessories(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    head_circumference SMALLINT,
    category VARCHAR
) AS $$
DECLARE
    user_head_circumference SMALLINT := (SELECT u.head_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.head_circumference,
        d.category
    FROM
        Detailed_head_accessories d
    WHERE
        d.head_circumference IS NULL
        OR
        (user_head_circumference - 2 >= d.head_circumference
        AND
        user_head_circumference + 2 <= d.head_circumference);
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_belts(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM
        Detailed_belts d
    WHERE
        user_waist_circumference >= d.min_waist_circumference
        AND
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_pants(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    length SMALLINT,
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT
) AS $$
DECLARE
    user_leg_length SMALLINT := (SELECT u.leg_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.length,
        d.min_waist_circumference,
        d.max_waist_circumference
    FROM
        Detailed_pants d
    WHERE
        d.length >= user_leg_length - 3
        AND
        d.length <= user_leg_length + 3
        AND
        user_waist_circumference >= d.min_waist_circumference
        AND
        user_waist_circumference <= d.max_waist_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_fits_shirts(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    name VARCHAR,
    collection VARCHAR,
    color VARCHAR,
    gender VARCHAR,
    length SMALLINT,
    arm_length SMALLINT,
    min_waist_circumference SMALLINT,
    max_waist_circumference SMALLINT,
    min_chest_circumference SMALLINT,
    max_chest_circumference SMALLINT,
    min_neck_circumference SMALLINT,
    max_neck_circumference SMALLINT
) AS $$
DECLARE
    user_torso_length SMALLINT := (SELECT u.torso_length FROM Users u WHERE u.id = f_user_id);
    user_arm_length SMALLINT := (SELECT u.arm_length FROM Users u WHERE u.id = f_user_id);
    user_waist_circumference SMALLINT := (SELECT u.waist_circumference FROM Users u WHERE u.id = f_user_id);
    user_chest_circumference SMALLINT := (SELECT u.chest_circumference FROM Users u WHERE u.id = f_user_id);
    user_neck_circumference SMALLINT := (SELECT u.neck_circumference FROM Users u WHERE u.id = f_user_id);
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.name,
        d.collection,
        d.color,
        d.gender,
        d.length,
        d.arm_length,
        d.min_waist_circumference,
        d.max_waist_circumference,
        d.min_chest_circumference,
        d.max_chest_circumference,
        d.min_neck_circumference,
        d.max_neck_circumference
    FROM
        Detailed_shirts d
    WHERE
        d.length >= user_torso_length
        AND
        d.arm_length >= user_arm_length
        AND
        user_waist_circumference >= d.min_waist_circumference
        AND
        user_waist_circumference <= d.max_waist_circumference
        AND
        user_chest_circumference >= d.min_chest_circumference
        AND
        user_chest_circumference <= d.max_chest_circumference
        AND
        user_neck_circumference >= d.min_neck_circumference
        AND
        user_neck_circumference <= d.max_neck_circumference;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_unread_notifications(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    content TEXT,
    datetime TIMESTAMP,
    due_to_request_id INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.content,
        d.datetime,
        d.due_to_request_id
    FROM
        Not_read_notifications d
    WHERE
        d.user_id = f_user_id;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE FUNCTION get_user_unclosed_costume_item_requests(
    f_user_id INT
)
RETURNS TABLE (
    id INT,
    datetime TIMESTAMP,
    type TEXT,
    state VARCHAR,
    costume_item_id INT,
    approver_id INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.id,
        d.datetime,
        d.type,
        d.state,
        d.costume_item_id,
        d.approver_id
    FROM
        Detailed_costume_item_requests d
    WHERE
        d.requester_user_id = f_user_id;
END;
$$ LANGUAGE plpgsql;

   CREATE OR REPLACE PROCEDURE add_country(
    p_country_name VARCHAR(30)
) AS $$
BEGIN
    IF p_country_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_country_name) > 30 OR LENGTH(p_country_name) < 1 THEN
		RAISE EXCEPTION 'Country name can have between 1 and 30 characters';
	END IF;

	PERFORM 1
	FROM Countries
	WHERE
		name = p_country_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Country already exist';
	END IF;

	BEGIN
		INSERT INTO Countries (name)
		VALUES (p_country_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_region(
    p_region_name VARCHAR(30),
	p_country_id SMALLINT
) AS $$
BEGIN
    IF p_region_name IS NULL OR p_country_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_region_name) > 30 OR LENGTH(p_region_name) < 1 THEN
		RAISE EXCEPTION 'Region name can have between 1 and 30 characters';
	END IF;

	PERFORM 1
	FROM Countries
	WHERE
		id = p_country_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Country with id % does not exist', p_country_id;
	END IF;

	PERFORM 1
	FROM Regions
	WHERE
		name = p_region_name AND country_id = p_country_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Region % in country with id % already exist', p_region_name, p_country_id;
	END IF;

	BEGIN
		INSERT INTO Regions (name, country_id)
		VALUES (p_region_name, p_country_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_settlement(
    p_settlement_name VARCHAR(30),
	p_region_id SMALLINT
) AS $$
BEGIN
    IF p_settlement_name IS NULL OR p_region_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_settlement_name) > 30 OR LENGTH(p_settlement_name) < 1 THEN
		RAISE EXCEPTION 'Settlement name can have between 1 and 30 characters';
	END IF;

	PERFORM 1
	FROM Regions
	WHERE
		id = p_region_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Region with id % does not exist', p_region_id;
	END IF;

	PERFORM 1
	FROM Settlements
	WHERE
		name = p_settlement_name AND region_id = p_region_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Settlement % in region with id % already exist', p_settlement_name, p_region_id;
	END IF;

	BEGIN
		INSERT INTO Settlements (name, region_id)
		VALUES (p_settlement_name, p_region_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_location(
    p_location_street VARCHAR(30),
	p_location_building_number SMALLINT,
    p_location_postal_code VARCHAR(10),
    p_settlement_id SMALLINT
) AS $$
BEGIN
    IF p_location_street IS NULL OR
    p_location_building_number IS NULL OR
    p_location_postal_code IS NULL OR
    p_settlement_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_location_street) > 30 OR LENGTH(p_location_street) < 1 THEN
		RAISE EXCEPTION 'Street name can have between 1 and 30 characters';
	END IF;

    IF LENGTH(p_location_postal_code) > 10 OR LENGTH(p_location_postal_code) < 1 THEN
		RAISE EXCEPTION 'Postal code can have between 1 and 10 characters';
	END IF;

	PERFORM 1
	FROM Settlements
	WHERE
		id = p_settlement_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Settlement with id % does not exist', p_settlement_id;
	END IF;

	PERFORM 1
	FROM Locations
	WHERE
		street = p_location_street AND building_number = p_location_building_number AND postal_code = p_location_postal_code AND settlement_id = p_settlement_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Location: %, %, %, in sattlement with id % already exist', p_location_street, p_location_building_number, p_location_postal_code, p_settlement_id;
	END IF;

	BEGIN
		INSERT INTO Locations (street, building_number, postal_code, settlement_id)
		VALUES (p_location_street, p_location_building_number, p_location_postal_code, p_settlement_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_gender(
    p_gender_name VARCHAR(25)
) AS $$
BEGIN
    IF p_gender_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_gender_name) > 25 OR LENGTH(p_gender_name) < 1 THEN
		RAISE EXCEPTION 'Gender name can have between 1 and 25 characters';
	END IF;

	PERFORM 1
	FROM Genders
	WHERE
		name = p_gender_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Gender already exist';
	END IF;

	BEGIN
		INSERT INTO Genders (name)
		VALUES (p_gender_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_role(
    p_role_name VARCHAR(20)
) AS $$
BEGIN
    IF p_role_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF LENGTH(p_role_name) > 20 OR LENGTH(p_role_name) < 1 THEN
        RAISE EXCEPTION 'Role name can have between 1 and 20 characters';
    END IF;

    PERFORM 1
    FROM Roles
    WHERE
        name = p_role_name;

    IF FOUND THEN
        RAISE EXCEPTION 'Role already exist';
    END IF;

    BEGIN
        INSERT INTO Roles (name)
        VALUES (p_role_name);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_type_of_voice(
    p_type_of_voice_name VARCHAR(10)
) AS $$
BEGIN
    IF p_type_of_voice_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_type_of_voice_name) > 10 OR LENGTH(p_type_of_voice_name) < 1 THEN
		RAISE EXCEPTION 'Type of voice name can have between 1 and 10 characters';
	END IF;

	PERFORM 1
	FROM Types_of_voices
	WHERE
		name = p_type_of_voice_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Type of voice already exist';
	END IF;

	BEGIN
		INSERT INTO Types_of_voices (name)
		VALUES (p_type_of_voice_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE add_type_of_instrument(
    p_type_of_instrument_name VARCHAR(20)
) AS $$
BEGIN
    IF p_type_of_instrument_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_type_of_instrument_name) > 20 OR LENGTH(p_type_of_instrument_name) < 1 THEN
		RAISE EXCEPTION 'Type of instrument name can have between 1 and 20 characters';
	END IF;

	PERFORM 1
	FROM Types_of_instruments
	WHERE
		name = p_type_of_instrument_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Type of instrument already exist';
	END IF;

	BEGIN
		INSERT INTO Types_of_instruments (name)
		VALUES (p_type_of_instrument_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_dance(
    p_dance_name VARCHAR(20)
) AS $$
BEGIN
    IF p_dance_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_dance_name) > 20 OR LENGTH(p_dance_name) < 1 THEN
		RAISE EXCEPTION 'Dance name can have between 1 and 20 characters';
	END IF;

	PERFORM 1
	FROM Dances
	WHERE
		name = p_dance_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Dance already exist';
	END IF;

	BEGIN
		INSERT INTO Dances (name)
		VALUES (p_dance_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_color(
    p_color_name VARCHAR(25)
) AS $$
BEGIN
    IF p_color_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_color_name) > 25 OR LENGTH(p_color_name) < 1 THEN
		RAISE EXCEPTION 'Color name can have between 1 and 25 characters';
	END IF;

	PERFORM 1
	FROM Colors
	WHERE
		name = p_color_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Color already exist';
	END IF;

	BEGIN
		INSERT INTO Colors (name)
		VALUES (p_color_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_collection(
    p_collection_name VARCHAR(20)
) AS $$
BEGIN
    IF p_collection_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_collection_name) > 20 OR LENGTH(p_collection_name) < 1 THEN
		RAISE EXCEPTION 'Collection name can have between 1 and 20 characters';
	END IF;

	PERFORM 1
	FROM Collections
	WHERE
		name = p_collection_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Collection already exist';
	END IF;

	BEGIN
		INSERT INTO Collections (name)
		VALUES (p_collection_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_pattern(
    p_pattern_name VARCHAR(20)
) AS $$
BEGIN
    IF p_pattern_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_pattern_name) > 20 OR LENGTH(p_pattern_name) < 1 THEN
		RAISE EXCEPTION 'Pattern name can have between 1 and 20characters';
	END IF;

	PERFORM 1
	FROM Patterns
	WHERE
		name = p_pattern_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Pattern already exist';
	END IF;

	BEGIN
		INSERT INTO Patterns (name)
		VALUES (p_pattern_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_head_accessory_category(
    p_head_accessory_category_name VARCHAR(20)
) AS $$
BEGIN
    IF p_head_accessory_category_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF LENGTH(p_head_accessory_category_name) > 20 OR LENGTH(p_head_accessory_category_name) > 20 THEN
        RAISE EXCEPTION 'Head accessory category name can have between 1 and 20 characters';
    END IF;

    PERFORM 1
    FROM Head_accessory_categories
    WHERE
        name = p_head_accessory_category_name;

    IF FOUND THEN
        RAISE EXCEPTION 'Head accessory category already exist';
    END IF;

    BEGIN
        INSERT INTO Head_accessory_categories (name)
        VALUES (p_head_accessory_category_name);
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_state_of_request(
    p_state_of_request_name VARCHAR(15)
) AS $$
BEGIN
    IF p_state_of_request_name IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_state_of_request_name) > 15 OR LENGTH(p_state_of_request_name) < 1 THEN
		RAISE EXCEPTION 'State of request name can have between 1 and 15 characters';
	END IF;

	PERFORM 1
	FROM States_of_requests
	WHERE
		name = p_state_of_request_name;

	IF FOUND THEN
		RAISE EXCEPTION 'State of request already exist';
	END IF;

	BEGIN
		INSERT INTO States_of_requests (name)
		VALUES (p_state_of_request_name);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE add_user(
    p_user_first_name          VARCHAR (25),
    p_user_last_name           VARCHAR (30),
    p_user_date_of_birth       DATE,
    p_user_email               VARCHAR (50),
    p_user_phone_number        VARCHAR (12),
    p_gender_id           SMALLINT,
    p_home_location_id    SMALLINT,
    p_user_height              SMALLINT,
    p_user_waist_circumference SMALLINT,
    p_user_chest_circumference SMALLINT,
    p_user_head_circumference  SMALLINT,
    p_user_neck_circumference  SMALLINT,
    p_user_leg_length          SMALLINT,
    p_user_arm_length          SMALLINT,
    p_user_torso_length        SMALLINT,
    p_user_shoe_size           FLOAT
) AS $$
BEGIN
    IF p_user_first_name IS NULL OR
    p_user_last_name IS NULL OR
    p_user_date_of_birth IS NULL OR
    p_user_email IS NULL OR
    p_user_phone_number IS NULL OR
    p_gender_id IS NULL OR
    p_home_location_id IS NULL OR
    p_user_height IS NULL OR
    p_user_waist_circumference IS NULL OR
    p_user_chest_circumference IS NULL OR
    p_user_head_circumference IS NULL OR
    p_user_neck_circumference IS NULL OR
    p_user_leg_length IS NULL OR
    p_user_arm_length IS NULL OR
    p_user_torso_length IS NULL OR
    p_user_shoe_size IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF LENGTH(p_user_first_name) > 25 OR LENGTH(p_user_first_name) < 1 THEN
		RAISE EXCEPTION 'First name can have between 1 and 25 characters';
	END IF;

    IF LENGTH(p_user_last_name) > 30 OR LENGTH(p_user_last_name) < 1 THEN
		RAISE EXCEPTION 'Last name can have between 1 and 30 characters';
	END IF;

    IF LENGTH(p_user_email) > 50 OR NOT (p_user_email ~* '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$') THEN
        RAISE EXCEPTION 'Wrong email format. min characters - 5, max characters - 50';
    END IF;

    IF NOT (p_user_phone_number ~* '^\+\d{2}\d{9}$') THEN
        RAISE EXCEPTION 'Wrong phone number format';
    END IF;

     IF p_user_height <= 0 THEN
		RAISE EXCEPTION 'Height must be greater than 0';
    END IF;

    IF p_user_waist_circumference <= 0 THEN
		RAISE EXCEPTION 'Waist circumference must be greater than 0';
    END IF;

    IF p_user_chest_circumference <= 0 THEN
		RAISE EXCEPTION 'Chest circumference must be greater than 0';
    END IF;

    IF p_user_head_circumference <= 0 THEN
		RAISE EXCEPTION 'Head circumference must be greater than 0';
    END IF;

    IF p_user_neck_circumference <= 0 THEN
		RAISE EXCEPTION 'Neck circumference must be greater than 0';
    END IF;

    IF p_user_leg_length <= 0 THEN
		RAISE EXCEPTION 'Leg length must be greater than 0';
    END IF;

    IF p_user_arm_length <= 0 THEN
		RAISE EXCEPTION 'Arm length must be greater than 0';
    END IF;

    IF p_user_torso_length <= 0 THEN
		RAISE EXCEPTION 'Torso length must be greater than 0';
    END IF;

    IF p_user_leg_length >= p_user_height THEN
		RAISE EXCEPTION 'Leg length cannot be greater than height';
    END IF;

    IF p_user_arm_length >= p_user_height THEN
		RAISE EXCEPTION 'Arm length cannot be greater than height';
    END IF;

    IF p_user_torso_length >= p_user_height THEN
		RAISE EXCEPTION 'Torso length cannot be greater than height';
    END IF;

    IF p_user_shoe_size <= 0 THEN
		RAISE EXCEPTION 'Shoe size must be greater than 0';
    END IF;

    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_home_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_home_location_id;
	END IF;

	PERFORM 1
	FROM Users
	WHERE
		email = p_user_email;

	IF FOUND THEN
		RAISE EXCEPTION 'User with email % already exist', p_user_email;
	END IF;

	BEGIN
		INSERT INTO Users (first_name, last_name, date_of_birth, email, phone_number, gender_id, home_location_id,
        height, waist_circumference, chest_circumference, head_circumference, neck_circumference, leg_length, arm_length,
        torso_length, shoe_size)
		VALUES (p_user_first_name, p_user_last_name, p_user_date_of_birth, p_user_email, p_user_phone_number,
        p_gender_id, p_home_location_id, p_user_height, p_user_waist_circumference, p_user_chest_circumference,
        p_user_head_circumference, p_user_neck_circumference, p_user_leg_length, p_user_arm_length,
        p_user_torso_length, p_user_shoe_size);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_costumier(
    p_user_id INT,
    p_role_id SMALLINT,
    p_work_location_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR
    p_role_id IS NULL OR
    p_work_location_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_role_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_work_location_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Location with id % does not exist', p_work_location_id;
	END IF;

    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is costumier', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Costumiers (user_id, role_id, work_location_id)
		VALUES (p_user_id, p_role_id, p_work_location_id);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_singer(
    p_user_id INT,
    p_role_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR
    p_role_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_role_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;

    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Singers
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is singer', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Singers (user_id, role_id)
		VALUES (p_user_id, p_role_id);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_musician(
    p_user_id INT,
    p_role_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR
    p_role_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_role_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;

    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Musicians
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is musician', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Musicians (user_id, role_id)
		VALUES (p_user_id, p_role_id);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE make_user_dancer(
    p_user_id INT,
    p_role_id SMALLINT
) AS $$
BEGIN
    IF p_user_id IS NULL OR
    p_role_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Roles
	WHERE
		id = p_role_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Role with id % does not exist', p_role_id;
	END IF;

    PERFORM 1
	FROM Users
	WHERE
		id = p_user_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'User with id % does not exist', p_user_id;
	END IF;

    PERFORM 1
	FROM Dancers
	WHERE
		user_id = p_user_id;

	IF FOUND THEN
		RAISE EXCEPTION 'User with id % is dancer', p_user_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Users WHERE id = p_user_id FOR UPDATE;

		INSERT INTO Dancers (user_id, role_id)
		VALUES (p_user_id, p_role_id);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_voice_to_singer(
    p_singer_id INT,
    p_type_of_voice_id SMALLINT
) AS $$
BEGIN
    IF p_singer_id IS NULL OR
    p_type_of_voice_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Types_of_voices
	WHERE
		id = p_type_of_voice_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Type of voice with id % does not exist', p_type_of_voice_id;
	END IF;

    PERFORM 1
	FROM Singers
	WHERE
		user_id = p_singer_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Singer with id % does not exist', p_singer_id;
	END IF;

    PERFORM 1
	FROM Singer_voices
	WHERE
		singer_id = p_singer_id AND type_of_voice_id = p_type_of_voice_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Singer with id % can sing with voice of id %', p_singer_id, p_type_of_voice_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Singers WHERE user_id = p_singer_id FOR UPDATE;

		INSERT INTO Singer_voices (singer_id, type_of_voice_id)
		VALUES (p_singer_id, p_type_of_voice_id);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_instrument_to_musician(
    p_musician_id INT,
    p_type_of_instrument_id SMALLINT
) AS $$
BEGIN
    IF p_musician_id IS NULL OR
    p_type_of_instrument_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Types_of_instruments
	WHERE
		id = p_type_of_instrument_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Type of instrument with id % does not exist', p_type_of_instrument_id;
	END IF;

    PERFORM 1
	FROM Musicians
	WHERE
		user_id = p_musician_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Musician with id % does not exist', p_musician_id;
	END IF;

    PERFORM 1
	FROM Musician_instrument
	WHERE
		musician_id = p_musician_id AND type_of_instrument_id = p_type_of_instrument_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Musician with id % can paly on instrument with id %', p_musician_id, p_type_of_instrument_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Musicians WHERE user_id = p_musician_id FOR UPDATE;

		INSERT INTO Musician_instrument (musician_id, type_of_instrument_id)
		VALUES (p_musician_id, p_type_of_instrument_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_dance_to_dancer(
    p_dancer_id INT,
    p_dance_id SMALLINT
) AS $$
BEGIN
    IF p_dancer_id IS NULL OR
    p_dance_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Dances
	WHERE
		id = p_dance_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Dance with id % does not exist', p_dance_id;
	END IF;

    PERFORM 1
	FROM Dancers
	WHERE
		user_id = p_dancer_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Dancer with id % does not exist', p_dancer_id;
	END IF;

    PERFORM 1
	FROM Dancer_dance
	WHERE
		dancer_id = p_dancer_id AND dance_id = p_dance_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Dancer with id % can dance dance with id %', p_dancer_id, p_dance_id;
	END IF;

	BEGIN
        PERFORM 1 FROM Dancers WHERE user_id = p_dancer_id FOR UPDATE;

		INSERT INTO Dancer_dance (dancer_id, dance_id)
		VALUES (p_dancer_id, p_dance_id);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_apron(
    p_apron_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_apron_length SMALLINT,
    p_pattern_id SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_apron_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_apron_length IS NULL OR
    p_pattern_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
		RAISE EXCEPTION 'Something wrong in costume item common part';
	END IF;

    IF p_apron_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF LENGTH(p_apron_name) > 30 OR LENGTH(p_apron_name) < 1 THEN
        RAISE EXCEPTION 'Apron name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_apron_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Apron with name % already exist', p_apron_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_apron_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Aprons (costume_item_id, length, pattern_id)
		VALUES (i_id, p_apron_length, p_pattern_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_head_accessory(
    p_head_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_head_accessory_head_circumference SMALLINT,
    p_category_id SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_head_accessory_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_category_id IS NULL THEN
        RAISE EXCEPTION 'Only head circumference parameter can be NULL';
    END IF;

	IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
		RAISE EXCEPTION 'Something wrong in costume item common part';
	END IF;

    PERFORM 1
	FROM Head_accessory_categories
	WHERE
		id = p_category_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Head accessory category with id % does not exist', p_category_id;
	END IF;

    IF p_head_accessory_head_circumference IS NOT NULL AND p_head_accessory_head_circumference <= 0 THEN
        RAISE EXCEPTION 'Head circumference must be greater than 0';
    END IF;

    IF LENGTH(p_head_accessory_name) > 30 OR LENGTH(p_head_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Head accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_head_accessory_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Head accessory with name % already exist', p_head_accessory_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_head_accessory_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Head_accessories (costume_item_id, category_id, head_circumference)
		VALUES (i_id, p_category_id, p_head_accessory_head_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_caftan(
    p_caftan_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_caftan_length SMALLINT,
    p_caftan_min_waist_circumference SMALLINT,
    p_caftan_max_waist_circumference SMALLINT,
    p_caftan_min_chest_circumference SMALLINT,
    p_caftan_max_chest_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_caftan_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_caftan_length IS NULL OR
    p_caftan_min_waist_circumference IS NULL OR
    p_caftan_max_waist_circumference IS NULL OR
    p_caftan_min_chest_circumference IS NULL OR
    p_caftan_max_chest_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
		RAISE EXCEPTION 'Something wrong in costume item common part';
	END IF;

    IF p_caftan_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_caftan_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_caftan_max_waist_circumference < p_caftan_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_caftan_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_caftan_max_chest_circumference < p_caftan_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_caftan_name) > 30 OR LENGTH(p_caftan_name) < 1 THEN
        RAISE EXCEPTION 'Caftan name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_caftan_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Caftan with name % already exist', p_caftan_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_caftan_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Caftans (costume_item_id, length, min_waist_circumference, max_waist_circumference,
        min_chest_circumference, max_chest_circumference)
		VALUES (i_id, p_caftan_length, p_caftan_min_waist_circumference, p_caftan_max_waist_circumference,
        p_caftan_min_chest_circumference, p_caftan_max_chest_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;




CREATE OR REPLACE PROCEDURE add_petticoat(
    p_petticoat_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_petticoat_length SMALLINT,
    p_petticoat_min_waist_circumference SMALLINT,
    p_petticoat_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_petticoat_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_petticoat_length IS NULL OR
    p_petticoat_min_waist_circumference IS NULL OR
    p_petticoat_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_petticoat_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_petticoat_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_petticoat_max_waist_circumference < p_petticoat_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_petticoat_name) > 30 OR LENGTH(p_petticoat_name) < 1 THEN
        RAISE EXCEPTION 'Petticoat name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_petticoat_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Petticoat with name % already exist', p_petticoat_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_petticoat_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Petticoats (costume_item_id, length, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_petticoat_length, p_petticoat_min_waist_circumference, p_petticoat_max_waist_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_corset(
    p_corset_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_corset_length SMALLINT,
    p_corset_min_waist_circumference SMALLINT,
    p_corset_max_waist_circumference SMALLINT,
    p_corset_min_chest_circumference SMALLINT,
    p_corset_max_chest_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_corset_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_corset_length IS NULL OR
    p_corset_min_waist_circumference IS NULL OR
    p_corset_max_waist_circumference IS NULL OR
    p_corset_min_chest_circumference IS NULL OR
    p_corset_max_chest_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_corset_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_corset_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_corset_max_waist_circumference < p_corset_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_corset_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_corset_max_chest_circumference < p_corset_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_corset_name) > 30 OR LENGTH(p_corset_name) < 1 THEN
        RAISE EXCEPTION 'Corset name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_corset_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Corset with name % already exist', p_corset_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_corset_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Corsets (costume_item_id, length, min_waist_circumference, max_waist_circumference,
        min_chest_circumference, max_chest_circumference)
		VALUES (i_id, p_corset_length, p_corset_min_waist_circumference, p_corset_max_waist_circumference,
        p_corset_min_chest_circumference, p_corset_max_chest_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_skirt(
    p_skirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_skirt_length SMALLINT,
    p_skirt_min_waist_circumference SMALLINT,
    p_skirt_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_skirt_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_skirt_length IS NULL OR
    p_skirt_min_waist_circumference IS NULL OR
    p_skirt_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_skirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_skirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_skirt_max_waist_circumference < p_skirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_skirt_name) > 30 OR LENGTH(p_skirt_name) < 1 THEN
        RAISE EXCEPTION 'Skirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_skirt_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Skirt with name % already exist', p_skirt_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_skirt_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Skirts (costume_item_id, length, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_skirt_length, p_skirt_min_waist_circumference, p_skirt_max_waist_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_belt(
    p_belt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_belt_min_waist_circumference SMALLINT,
    p_belt_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_belt_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_belt_min_waist_circumference IS NULL OR
    p_belt_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_belt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_belt_max_waist_circumference < p_belt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_belt_name) > 30 OR LENGTH(p_belt_name) < 1 THEN
        RAISE EXCEPTION 'Belt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_belt_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Belt with name % already exist', p_belt_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_belt_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Belts (costume_item_id, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_belt_min_waist_circumference, p_belt_max_waist_circumference);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_shirt(
    p_shirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_shirt_length SMALLINT,
    p_shirt_arm_length SMALLINT,
    p_shirt_min_waist_circumference SMALLINT,
    p_shirt_max_waist_circumference SMALLINT,
    p_shirt_min_chest_circumference SMALLINT,
    p_shirt_max_chest_circumference SMALLINT,
    p_shirt_min_neck_circumference SMALLINT,
    p_shirt_max_neck_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_shirt_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_shirt_length IS NULL OR
    p_shirt_arm_length IS NULL OR
    p_shirt_min_waist_circumference IS NULL OR
    p_shirt_max_waist_circumference IS NULL OR
    p_shirt_min_chest_circumference IS NULL OR
    p_shirt_max_chest_circumference IS NULL OR
    p_shirt_min_neck_circumference IS NULL OR
    p_shirt_max_neck_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_shirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_shirt_arm_length <= 0 THEN
        RAISE EXCEPTION 'Arm length must be greater than 0';
    END IF;

    IF p_shirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_shirt_max_waist_circumference < p_shirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_shirt_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_shirt_max_chest_circumference < p_shirt_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF p_shirt_min_neck_circumference <= 0 THEN
        RAISE EXCEPTION 'Min neck circumference must be greater than 0';
    END IF;

    IF p_shirt_max_neck_circumference < p_shirt_min_neck_circumference THEN
        RAISE EXCEPTION 'Max neck circumference must be greater or equal than min neck circumference';
    END IF;

    IF LENGTH(p_shirt_name) > 30 OR LENGTH(p_shirt_name) < 1 THEN
        RAISE EXCEPTION 'Shirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_shirt_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Shirt with name % already exist', p_shirt_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_shirt_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Shirts (costume_item_id, length, arm_length, min_waist_circumference, max_waist_circumference,
        min_chest_circumference, max_chest_circumference, min_neck_circumference, max_neck_circumference)
		VALUES (i_id, p_shirt_length, p_shirt_arm_length, p_shirt_min_waist_circumference, p_shirt_max_waist_circumference,
        p_shirt_min_chest_circumference, p_shirt_max_chest_circumference, p_shirt_min_neck_circumference, p_shirt_max_neck_circumference);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_pants(
    p_pants_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_pants_length SMALLINT,
    p_pants_min_waist_circumference SMALLINT,
    p_pants_max_waist_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_pants_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_pants_length IS NULL OR
    p_pants_min_waist_circumference IS NULL OR
    p_pants_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_pants_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_pants_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_pants_max_waist_circumference < p_pants_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_pants_name) > 30 OR LENGTH(p_pants_name) < 1 THEN
        RAISE EXCEPTION 'Pants name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_pants_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Pants with name % already exist', p_pants_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_pants_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Pants (costume_item_id, length, min_waist_circumference, max_waist_circumference)
		VALUES (i_id, p_pants_length, p_pants_min_waist_circumference, p_pants_max_waist_circumference);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_boots(
    p_boots_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_boots_shoe_size FLOAT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_boots_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_boots_shoe_size IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_boots_shoe_size <= 0 THEN
        RAISE EXCEPTION 'Shoe size must be greater than 0';
    END IF;

    IF LENGTH(p_boots_name) > 30 OR LENGTH(p_boots_name) < 1 THEN
        RAISE EXCEPTION 'Boots name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_boots_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Boots with name % already exist', p_boots_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_boots_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Boots (costume_item_id, shoe_size)
		VALUES (i_id, p_boots_shoe_size);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_neck_accessory(
    p_neck_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_neck_accessory_min_neck_circumference SMALLINT,
    p_neck_accessory_max_neck_circumference SMALLINT
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_neck_accessory_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL OR
    p_color_id IS NULL OR
    p_location_id IS NULL OR
    p_neck_accessory_min_neck_circumference IS NULL OR
    p_neck_accessory_max_neck_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_neck_accessory_min_neck_circumference <= 0 THEN
        RAISE EXCEPTION 'Min neck circumference must be greater than 0';
    END IF;

    IF p_neck_accessory_max_neck_circumference < p_neck_accessory_min_neck_circumference THEN
        RAISE EXCEPTION 'Max neck circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_neck_accessory_name) > 30 OR LENGTH(p_neck_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Neck accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE
		name = p_neck_accessory_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Neck accessory with name % already exist', p_neck_accessory_name;
	END IF;

	BEGIN
        INSERT INTO Costumes_items (name, collection_id, gender_id, color_id, location_id)
        VALUES (p_neck_accessory_name, p_collection_id, p_gender_id, p_color_id, p_location_id) RETURNING id INTO i_id;

		INSERT INTO Neck_accessories (costume_item_id, min_neck_circumference, max_neck_circumference)
		VALUES (i_id, p_neck_accessory_min_neck_circumference, p_neck_accessory_max_neck_circumference);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_costume(
    p_costume_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_apron_id          INTEGER,
    p_caftan_id         INTEGER,
    p_petticoat_id      INTEGER,
    p_corset_id         INTEGER,
    p_skirt_id          INTEGER,
    p_belt_id           INTEGER,
    p_shirt_id          INTEGER,
    p_pants_id          INTEGER,
    p_boots_id          INTEGER,
    p_neck_accessory_id INTEGER,
    p_head_accessory_id INTEGER
) AS $$
BEGIN
    IF p_costume_name IS NULL OR
    p_collection_id IS NULL OR
    p_gender_id IS NULL THEN
        RAISE EXCEPTION 'Costume name, collection id and gender id cannot be NULL';
    END IF;

	PERFORM 1
	FROM Collections
	WHERE
		id = p_collection_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Collection with id % does not exist', p_collection_id;
	END IF;

    IF p_gender_id NOT IN (1, 2, 3) THEN
        RAISE EXCEPTION 'Gender with id 1 (male) or 2 (female) or 3 (bigender) can be selected';
    END IF;

    PERFORM 1
	FROM Genders
	WHERE
		id = p_gender_id;

	IF NOT FOUND THEN
		RAISE EXCEPTION 'Gender with id % does not exist', p_gender_id;
	END IF;

    IF p_apron_id IS NOT NULL THEN
        PERFORM 1
        FROM Aprons
        WHERE
            costume_item_id = p_apron_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Apron with id % does not exist', p_apron_id;
        END IF;
    END IF;

    IF p_caftan_id IS NOT NULL THEN
        PERFORM 1
        FROM Caftans
        WHERE
            costume_item_id = p_caftan_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Caftan with id % does not exist', p_caftan_id;
        END IF;
    END IF;

    IF p_petticoat_id IS NOT NULL THEN
        PERFORM 1
        FROM Petticoats
        WHERE
            costume_item_id = p_petticoat_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Peticoat with id % does not exist', p_petticoat_id;
        END IF;
    END IF;

    IF p_corset_id IS NOT NULL THEN
        PERFORM 1
        FROM Corsets
        WHERE
            costume_item_id = p_corset_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Corset with id % does not exist', p_corset_id;
        END IF;
    END IF;

    IF p_skirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Skirts
        WHERE
            costume_item_id = p_skirt_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Skirt with id % does not exist', p_skirt_id;
        END IF;
    END IF;

    IF p_belt_id IS NOT NULL THEN
        PERFORM 1
        FROM Belts
        WHERE
            costume_item_id = p_belt_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Belt with id % does not exist', p_belt_id;
        END IF;
    END IF;

    IF p_shirt_id IS NOT NULL THEN
        PERFORM 1
        FROM Shirts
        WHERE
            costume_item_id = p_shirt_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Shirt with id % does not exist', p_shirt_id;
        END IF;
    END IF;

    IF p_pants_id IS NOT NULL THEN
        PERFORM 1
        FROM Pants
        WHERE
            costume_item_id = p_pants_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Pants with id % does not exist', p_pants_id;
        END IF;
    END IF;

    IF p_boots_id IS NOT NULL THEN
        PERFORM 1
        FROM Boots
        WHERE
            costume_item_id = p_boots_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Boots with id % does not exist', p_boots_id;
        END IF;
    END IF;

    IF p_neck_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Neck_accessories
        WHERE
            costume_item_id = p_neck_accessory_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Neck accessory with id % does not exist', p_neck_accessory_id;
        END IF;
    END IF;

    IF p_head_accessory_id IS NOT NULL THEN
        PERFORM 1
        FROM Head_accessories
        WHERE
            costume_item_id = p_head_accessory_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Head accessory with id % does not exist', p_head_accessory_id;
        END IF;
    END IF;

    IF LENGTH(p_costume_name) > 30 THEN
        RAISE EXCEPTION 'Costume name exceeded 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes
	WHERE
		name = p_costume_name;

	IF FOUND THEN
		RAISE EXCEPTION 'Costume with name % already exist', p_costume_name;
	END IF;

    IF check_costume_inconsistency(p_collection_id, p_gender_id, p_apron_id, p_caftan_id, p_petticoat_id,
        p_corset_id, p_shirt_id, p_belt_id, p_shirt_id, p_pants_id, p_boots_id, p_neck_accessory_id,
        p_head_accessory_id) THEN

        RAISE EXCEPTION 'Costume is inconsistency';
    END IF;

	BEGIN
		INSERT INTO Costumes (name, collection_id, gender_id, apron_id, caftan_id, petticoat_id, corset_id, skirt_id,
        belt_id, shirt_id, pants_id, boots_id, neck_accessory_id, head_accessory_id)
		VALUES (p_costume_name, p_collection_id, p_gender_id, p_apron_id, p_caftan_id, p_petticoat_id, p_corset_id,
        p_skirt_id, p_belt_id, p_shirt_id, p_pants_id, p_boots_id, p_neck_accessory_id, p_head_accessory_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_rental_costume_item_request(
    p_requester_user_id INTEGER,
    p_costume_item_id INTEGER
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_requester_user_id IS NULL OR
    p_costume_item_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_requester_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_requester_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Rentals
    WHERE
        costume_item_id = p_costume_item_id AND date_of_return IS NULL;

    IF FOUND THEN
        RAISE EXCEPTION 'Costume item with id % is already rented', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Requests r
    INNER JOIN Rental_costume_item_requests rr
        ON rr.request_id = r.id
    WHERE
        (r.state_id <> 2 AND r.state_id <> 3)
        AND
        r.requester_user_id = p_requester_user_id
        AND
        rr.costume_item_id = p_costume_item_id;

    IF FOUND THEN
        RAISE EXCEPTION 'You have already submitted a request to rent a costume item with id %', p_costume_item_id;
    END IF;

	BEGIN
        -- 1-> PENDING
		INSERT INTO Requests (datetime, requester_user_id, state_id)
        VALUES (NOW(), p_requester_user_id, 1) RETURNING id INTO i_id;

		INSERT INTO Rental_costume_item_requests (request_id, costume_item_id, approver_costumier_id)
		VALUES (i_id, p_costume_item_id, NULL);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_return_costume_item_request(
    p_requester_user_id INTEGER,
    p_costume_item_id INTEGER
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_requester_user_id IS NULL OR
    p_costume_item_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_requester_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_requester_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Rentals
    WHERE
        user_id = p_requester_user_id AND costume_item_id = p_costume_item_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item is not rented';
    END IF;

    PERFORM 1
    FROM Requests r
    INNER JOIN Return_costume_item_requests rr
        ON rr.request_id = r.id
    WHERE
        (r.state_id <> 2 AND r.state_id <> 3)
        AND
        r.requester_user_id = p_requester_user_id
        AND
        rr.costume_item_id = p_costume_item_id;

    IF FOUND THEN
        RAISE EXCEPTION 'You have already submitted a request to return a costume item with id %', p_costume_item_id;
    END IF;

	BEGIN
        -- 1-> PENDING
		INSERT INTO Requests (datetime, requester_user_id, state_id)
        VALUES (NOW(), p_requester_user_id, 1) RETURNING id INTO i_id;

		INSERT INTO Return_costume_item_requests (request_id, costume_item_id, approver_costumier_id)
		VALUES (i_id, p_costume_item_id, NULL);

	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_borrow_costume_item_request(
    p_requester_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_approver_user_id INTEGER
) AS $$
DECLARE
    i_id INT;
BEGIN
    IF p_requester_user_id IS NULL OR
    p_costume_item_id IS NULL OR
    p_approver_user_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_requester_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_requester_user_id;
    END IF;

    PERFORM 1
    FROM Users
    WHERE
        id = p_approver_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_approver_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Rentals
    WHERE user_id = p_approver_user_id AND costume_item_id = p_costume_item_id AND date_of_return IS NULL;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % was not rented by user with id %', p_costume_item_id, p_approver_user_id;
    END IF;

    IF p_requester_user_id = p_approver_user_id THEN
        RAISE EXCEPTION 'Requester user id and approver user id are the same';
    END IF;

    PERFORM 1
    FROM Requests r
    INNER JOIN Borrow_costume_item_requests rr
        ON rr.request_id = r.id
    WHERE
        (r.state_id <> 2 AND r.state_id <> 3)
        AND
        r.requester_user_id = p_requester_user_id
        AND
        rr.costume_item_id = p_costume_item_id
        AND
        rr.approver_user_id = p_approver_user_id;

    IF FOUND THEN
        RAISE EXCEPTION 'You have already submitted a request to borrow a costume item with id % from user with id %', p_costume_item_id, p_approver_user_id;
    END IF;

	BEGIN
        -- 1-> PENDING
		INSERT INTO Requests (datetime, requester_user_id, state_id)
        VALUES (NOW(), p_requester_user_id, 1) RETURNING id INTO i_id;

		INSERT INTO Borrow_costume_item_requests (request_id, costume_item_id, approver_user_id)
		VALUES (i_id, p_costume_item_id, p_approver_user_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_notification(
    p_user_id INTEGER,
    p_notification_content TEXT,
    p_due_to_request_id INTEGER
) AS $$
DECLARE
    r_user_id INTEGER;
BEGIN
    IF p_user_id IS NULL OR
    p_notification_content IS NULL OR
    p_due_to_request_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_user_id;
    END IF;

    IF p_due_to_request_id IS NOT NULL THEN
        PERFORM 1
        FROM Requests
        WHERE
            id = p_due_to_request_id;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Request with id % does not exist', p_due_to_request_id;
        END IF;

        SELECT requester_user_id INTO r_user_id
        FROM Requests
        WHERE
            id = p_due_to_request_id;

        IF p_user_id <> r_user_id THEN
            RAISE EXCEPTION 'User id and requester user id from request with % are not the same', p_due_to_request_id;
        END IF;
    END IF;

    IF LENGTH(p_notification_content) < 1 THEN
        RAISE EXCEPTION 'Notification must be at least 1 character';
    END IF;

	BEGIN
		INSERT INTO Notifications (user_id, content, datetime, due_to_request_id)
        VALUES (p_user_id, p_notification_content, NOW(), p_due_to_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE add_rental(
    p_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_done_due_request_id INTEGER,
    p_rental_date_of_rental TIMESTAMP
) AS $$
BEGIN
    IF p_user_id IS NULL OR
    p_costume_item_id IS NULL OR
    p_done_due_request_id IS NULL OR
    p_rental_date_of_rental IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
    FROM Users
    WHERE
        id = p_user_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'User with id % does not exist', p_user_id;
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE
        id = p_costume_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
    END IF;

    PERFORM 1
    FROM Requests
    WHERE
        id = p_done_due_request_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_done_due_request_id;
    END IF;

    IF check_rental_inconsistency(p_user_id, p_costume_item_id, p_done_due_request_id) THEN
        RAISE EXCEPTION 'Rental is inconsistency';
    END IF;

    PERFORM 1
    FROM Rentals
    WHERE
        costume_item_id = p_costume_item_id
        AND
        date_of_return IS NULL;

    IF FOUND THEN
        RAISE EXCEPTION 'Costume item with id % is already rented', p_costume_item_id;
    END IF;

	BEGIN
		INSERT INTO Rentals (user_id, costume_item_id, done_due_request_id, date_of_rental)
        VALUES (p_user_id, p_costume_item_id, p_done_due_request_id, p_rental_date_of_rental);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to insert: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_costume_item_location(
    p_costume_item_id INTEGER,
    p_location_id SMALLINT
) AS $$
BEGIN
    IF p_costume_item_id IS NULL OR
    p_location_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Costumes_items
	WHERE
		id = p_costume_item_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costume item with id % does not exist', p_costume_item_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

	BEGIN
		PERFORM 1
	    FROM Costumes_items
	    WHERE
		    id = p_costume_item_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET
            location_id = p_location_id
        WHERE
		    id = p_costume_item_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE delete_request(
    p_request_id INTEGER
) AS $$
DECLARE
    r_state_id INT;
BEGIN
    IF p_request_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    SELECT state_id INTO r_state_id
    FROM Requests
    WHERE
		id = p_request_id;

    IF r_state_id <> 1 THEN
        RAISE EXCEPTION 'Request closed - cannot delete';
    END IF;

	BEGIN
        DELETE FROM Requests WHERE id = p_request_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to delete: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE accept_rental_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    r_costume_item_id INT;
    notification_content TEXT;
BEGIN
    IF p_request_id IS NULL OR
    p_approver_costumier_id IS NULL OR
    p_comment IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Rental_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not rental_costume_item_request', p_request_id;
	END IF;

    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        SELECT costume_item_id INTO r_costume_item_id
	    FROM Rental_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;

        -- 2-> ACCEPT
        UPDATE Requests
        SET
            state_id = 2
        WHERE
		    id = p_request_id;

        UPDATE Rental_costume_item_requests
        SET
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        notification_content := 'Request with id ' || p_request_id || ' has been accepted. You can rent costume item with id ' || r_costume_item_id || '. ' || p_comment;
        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE deny_rental_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT := 'Request with id ' || p_request_id || ' has been denied.' || p_comment;
BEGIN
    IF p_request_id IS NULL OR
    p_approver_costumier_id IS NULL OR
    p_comment IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Rental_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not rental_costume_item_request', p_request_id;
	END IF;

    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Rental_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;

        -- 3-> DENY
        UPDATE Requests
        SET
            state_id = 3
        WHERE
		    id = p_request_id;

        UPDATE Rental_costume_item_requests
        SET
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE accept_return_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    r_costume_item_id INT;
    notification_content TEXT;
BEGIN
    IF p_request_id IS NULL OR
    p_approver_costumier_id IS NULL OR
    p_comment IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Return_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not return_costume_item_request', p_request_id;
	END IF;

    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        SELECT costume_item_id INTO r_costume_item_id
	    FROM Return_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;

        -- 2-> ACCEPT
        UPDATE Requests
        SET
            state_id = 2
        WHERE
		    id = p_request_id;

        UPDATE Return_costume_item_requests
        SET
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        notification_content := 'Request with id ' || p_request_id || ' has been accepted. You can return costume item with id ' || r_costume_item_id || '. ' || p_comment;
        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE deny_return_costume_item_request(
    p_request_id INTEGER,
    p_approver_costumier_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT := 'Request with id ' || p_request_id || ' has been denied.' || p_comment;
BEGIN
    IF p_request_id IS NULL OR
    p_approver_costumier_id IS NULL OR
    p_comment IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Return_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not return_costume_item_request', p_request_id;
	END IF;

    PERFORM 1
	FROM Costumiers
	WHERE
		user_id = p_approver_costumier_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Costumier with id % does not exist', p_approver_costumier_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Return_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;

        -- 3-> DENY
        UPDATE Requests
        SET
            state_id = 3
        WHERE
		    id = p_request_id;

        UPDATE Return_costume_item_requests
        SET
            approver_costumier_id = p_approver_costumier_id
        WHERE
		    request_id = p_request_id;

        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE accept_borrow_costume_item_request(
    p_request_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT;
BEGIN
    IF p_request_id IS NULL OR
    p_comment IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Borrow_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not borrow_costume_item_request', p_request_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Borrow_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;

        -- 2-> ACCEPT
        UPDATE Requests
        SET
            state_id = 2
        WHERE
		    id = p_request_id;

        notification_content := 'Request with id ' || p_request_id || ' has been accepted. ' || p_comment;
        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE deny_borrow_costume_item_request(
    p_request_id INTEGER,
    p_comment TEXT
) AS $$
DECLARE
    r_requester_user_id INT;
    notification_content TEXT := 'Request with id ' || p_request_id || ' has been denied.' || p_comment;
BEGIN
    IF p_request_id IS NULL OR
    p_comment IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Requests
	WHERE
		id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % does not exist', p_request_id;
	END IF;

    PERFORM 1
	FROM Borrow_costume_item_requests
	WHERE
		request_id = p_request_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Request with id % is not borrow_costume_item_request', p_request_id;
	END IF;

    IF LENGTH(p_comment) < 1 THEN
        RAISE EXCEPTION 'Comment must be at least 1 character';
    END IF;

	BEGIN
        SELECT requester_user_id INTO r_requester_user_id
	    FROM Requests
	    WHERE
		    id = p_request_id
        FOR UPDATE;

        PERFORM 1
	    FROM Borrow_costume_item_requests
	    WHERE
		    request_id = p_request_id
        FOR UPDATE;

        -- 3-> DENY
        UPDATE Requests
        SET
            state_id = 3
        WHERE
		    id = p_request_id;

        CALL add_notification(r_requester_user_id, notification_content, p_request_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE mark_notification_as_read(
    p_notification_id INTEGER
) AS $$
BEGIN
    IF p_notification_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	PERFORM 1
	FROM Notifications
	WHERE
		id = p_notification_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Notification with id % does not exist', p_notification_id;
	END IF;

	BEGIN
		PERFORM 1
        FROM Notifications
        WHERE
            id = p_notification_id
        FOR UPDATE;

        UPDATE Notifications
        SET
            marked_as_read = 'T'
        WHERE
		    id = p_notification_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE rent_costume_item(
    p_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_done_due_request_id INTEGER
) AS $$
DECLARE
    r_location_id SMALLINT;
BEGIN
    IF p_user_id IS NULL OR
    p_costume_item_id IS NULL OR
    p_done_due_request_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

	BEGIN
		CALL add_rental(p_user_id, p_costume_item_id, p_done_due_request_id, date_trunc('minute', NOW()::TIMESTAMP));

        SELECT home_location_id INTO r_location_id
        FROM Users
        WHERE
            id = p_user_id;

        CALL update_costume_item_location(p_costume_item_id, r_location_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE return_costume_item(
    p_rental_id INTEGER,
    p_location_id SMALLINT
) AS $$
DECLARE
    r_costume_item_id INTEGER;
BEGIN
    IF p_rental_id IS NULL OR
    p_location_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
	FROM Rentals
	WHERE
		id = p_rental_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Rental with id % does not exist', p_rental_id;
	END IF;

    PERFORM 1
	FROM Locations
	WHERE
		id = p_location_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Location with id % does not exist', p_location_id;
	END IF;

	BEGIN
        SELECT costume_item_id INTO r_costume_item_id
        FROM Rentals
        WHERE
            id = p_rental_id
        FOR UPDATE;

        UPDATE Rentals
        SET
            date_of_return = date_trunc('minute', NOW()::TIMESTAMP)
        WHERE
            id = p_rental_id;

        CALL update_costume_item_location(r_costume_item_id, p_location_id);
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE borrow_costume_item(
    p_rental_id INTEGER,
    p_new_owner_user_id INTEGER,
    p_costume_item_id INTEGER,
    p_done_due_request_id INTEGER
) AS $$
DECLARE
    swap_datetime TIMESTAMP;
BEGIN
    IF p_rental_id IS NULL OR
    p_new_owner_user_id IS NULL OR
    p_costume_item_id IS NULL OR
    p_done_due_request_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    PERFORM 1
	FROM Rentals
	WHERE
		id = p_rental_id;

	IF NOT FOUND THEN
        RAISE EXCEPTION 'Rental with id % does not exist', p_rental_id;
	END IF;

	BEGIN
        PERFORM 1
        FROM Rentals
        WHERE
            id = p_rental_id
        FOR UPDATE;

        swap_datetime := date_trunc('minute', NOW()::TIMESTAMP);

		CALL add_rental(p_new_owner_user_id, p_costume_item_id, p_done_due_request_id, swap_datetime);

        UPDATE Rentals
        SET
            date_of_return = swap_datetime
        WHERE
            id = p_rental_id;
	EXCEPTION
		WHEN OTHERS THEN
			RAISE EXCEPTION 'Failed: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_apron(
    p_apron_id INT,
    p_apron_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_apron_length SMALLINT,
    p_pattern_id SMALLINT
) AS $$
BEGIN
    IF p_apron_id IS NULL OR
       p_apron_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_apron_length IS NULL OR
       p_pattern_id IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_apron_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF LENGTH(p_apron_name) > 30 OR LENGTH(p_apron_name) < 1 THEN
        RAISE EXCEPTION 'Apron name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
	FROM Costumes_items
	WHERE name = p_apron_name
      AND id <> p_apron_id;

	IF FOUND THEN
		RAISE EXCEPTION 'Apron with name % already exist', p_apron_name;
	END IF;

    BEGIN
        PERFORM 1
	    FROM Costumes_items
	    WHERE
		    id = p_apron_id
        FOR UPDATE;

        PERFORM 1
	    FROM Aprons
	    WHERE
		    costume_item_id = p_apron_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_apron_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_apron_id;

        UPDATE Aprons
        SET length = p_apron_length,
            pattern_id = p_pattern_id
        WHERE costume_item_id = p_apron_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_head_accessory(
    p_head_accessory_id INT,
    p_head_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_head_accessory_head_circumference SMALLINT,
    p_category_id SMALLINT
) AS $$
BEGIN
    IF p_head_accessory_id IS NULL OR
       p_head_accessory_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_category_id IS NULL THEN
        RAISE EXCEPTION 'Only head circumference parameter can be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    PERFORM 1
    FROM Head_accessory_categories
    WHERE id = p_category_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Head accessory category with id % does not exist', p_category_id;
    END IF;

    IF p_head_accessory_head_circumference IS NOT NULL AND p_head_accessory_head_circumference <= 0 THEN
        RAISE EXCEPTION 'Head circumference must be greater than 0';
    END IF;

    IF LENGTH(p_head_accessory_name) > 30 OR LENGTH(p_head_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Head accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_head_accessory_name
      AND id <> p_head_accessory_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Head accessory with name % already exists', p_head_accessory_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_head_accessory_id
        FOR UPDATE;

        PERFORM 1
        FROM Head_accessories
        WHERE costume_item_id = p_head_accessory_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_head_accessory_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_head_accessory_id;

        UPDATE Head_accessories
        SET category_id = p_category_id,
            head_circumference = p_head_accessory_head_circumference
        WHERE costume_item_id = p_head_accessory_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_caftan(
    p_caftan_id INT,
    p_caftan_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_caftan_length SMALLINT,
    p_caftan_min_waist_circumference SMALLINT,
    p_caftan_max_waist_circumference SMALLINT,
    p_caftan_min_chest_circumference SMALLINT,
    p_caftan_max_chest_circumference SMALLINT
) AS $$
BEGIN
    IF p_caftan_id IS NULL OR
       p_caftan_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_caftan_length IS NULL OR
       p_caftan_min_waist_circumference IS NULL OR
       p_caftan_max_waist_circumference IS NULL OR
       p_caftan_min_chest_circumference IS NULL OR
       p_caftan_max_chest_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_caftan_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_caftan_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_caftan_max_waist_circumference < p_caftan_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_caftan_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_caftan_max_chest_circumference < p_caftan_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_caftan_name) > 30 OR LENGTH(p_caftan_name) < 1 THEN
        RAISE EXCEPTION 'Caftan name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_caftan_name
      AND id <> p_caftan_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Caftan with name % already exists', p_caftan_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_caftan_id
        FOR UPDATE;

        PERFORM 1
        FROM Caftans
        WHERE costume_item_id = p_caftan_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_caftan_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_caftan_id;

        UPDATE Caftans
        SET length = p_caftan_length,
            min_waist_circumference = p_caftan_min_waist_circumference,
            max_waist_circumference = p_caftan_max_waist_circumference,
            min_chest_circumference = p_caftan_min_chest_circumference,
            max_chest_circumference = p_caftan_max_chest_circumference
        WHERE costume_item_id = p_caftan_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_petticoat(
    p_petticoat_id INT,
    p_petticoat_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_petticoat_length SMALLINT,
    p_petticoat_min_waist_circumference SMALLINT,
    p_petticoat_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_petticoat_id IS NULL OR
       p_petticoat_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_petticoat_length IS NULL OR
       p_petticoat_min_waist_circumference IS NULL OR
       p_petticoat_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_petticoat_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_petticoat_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_petticoat_max_waist_circumference < p_petticoat_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_petticoat_name) > 30 OR LENGTH(p_petticoat_name) < 1 THEN
        RAISE EXCEPTION 'Petticoat name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_petticoat_name
      AND id <> p_petticoat_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Petticoat with name % already exists', p_petticoat_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_petticoat_id
        FOR UPDATE;

        PERFORM 1
        FROM Petticoats
        WHERE costume_item_id = p_petticoat_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_petticoat_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_petticoat_id;

        UPDATE Petticoats
        SET length = p_petticoat_length,
            min_waist_circumference = p_petticoat_min_waist_circumference,
            max_waist_circumference = p_petticoat_max_waist_circumference
        WHERE costume_item_id = p_petticoat_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_corset(
    p_corset_id INT,
    p_corset_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_corset_length SMALLINT,
    p_corset_min_waist_circumference SMALLINT,
    p_corset_max_waist_circumference SMALLINT,
    p_corset_min_chest_circumference SMALLINT,
    p_corset_max_chest_circumference SMALLINT
) AS $$
BEGIN
    IF p_corset_id IS NULL OR
       p_corset_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_corset_length IS NULL OR
       p_corset_min_waist_circumference IS NULL OR
       p_corset_max_waist_circumference IS NULL OR
       p_corset_min_chest_circumference IS NULL OR
       p_corset_max_chest_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_corset_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_corset_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_corset_max_waist_circumference < p_corset_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_corset_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_corset_max_chest_circumference < p_corset_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF LENGTH(p_corset_name) > 30 OR LENGTH(p_corset_name) < 1 THEN
        RAISE EXCEPTION 'Corset name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_corset_name
      AND id <> p_corset_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Corset with name % already exists', p_corset_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_corset_id
        FOR UPDATE;

        PERFORM 1
        FROM Corsets
        WHERE costume_item_id = p_corset_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_corset_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_corset_id;

        UPDATE Corsets
        SET length = p_corset_length,
            min_waist_circumference = p_corset_min_waist_circumference,
            max_waist_circumference = p_corset_max_waist_circumference,
            min_chest_circumference = p_corset_min_chest_circumference,
            max_chest_circumference = p_corset_max_chest_circumference
        WHERE costume_item_id = p_corset_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_skirt(
    p_skirt_id INT,
    p_skirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_skirt_length SMALLINT,
    p_skirt_min_waist_circumference SMALLINT,
    p_skirt_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_skirt_id IS NULL OR
       p_skirt_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_skirt_length IS NULL OR
       p_skirt_min_waist_circumference IS NULL OR
       p_skirt_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_skirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_skirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_skirt_max_waist_circumference < p_skirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_skirt_name) > 30 OR LENGTH(p_skirt_name) < 1 THEN
        RAISE EXCEPTION 'Skirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_skirt_name
      AND id <> p_skirt_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Skirt with name % already exists', p_skirt_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_skirt_id
        FOR UPDATE;

        PERFORM 1
        FROM Skirts
        WHERE costume_item_id = p_skirt_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_skirt_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_skirt_id;

        UPDATE Skirts
        SET length = p_skirt_length,
            min_waist_circumference = p_skirt_min_waist_circumference,
            max_waist_circumference = p_skirt_max_waist_circumference
        WHERE costume_item_id = p_skirt_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_belt(
    p_belt_id INT,
    p_belt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_belt_min_waist_circumference SMALLINT,
    p_belt_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_belt_id IS NULL OR
       p_belt_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_belt_min_waist_circumference IS NULL OR
       p_belt_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_belt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_belt_max_waist_circumference < p_belt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_belt_name) > 30 OR LENGTH(p_belt_name) < 1 THEN
        RAISE EXCEPTION 'Belt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_belt_name
      AND id <> p_belt_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Belt with name % already exists', p_belt_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_belt_id
        FOR UPDATE;

        PERFORM 1
        FROM Belts
        WHERE costume_item_id = p_belt_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_belt_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_belt_id;

        UPDATE Belts
        SET min_waist_circumference = p_belt_min_waist_circumference,
            max_waist_circumference = p_belt_max_waist_circumference
        WHERE costume_item_id = p_belt_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_shirt(
    p_shirt_id INT,
    p_shirt_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_shirt_length SMALLINT,
    p_shirt_arm_length SMALLINT,
    p_shirt_min_waist_circumference SMALLINT,
    p_shirt_max_waist_circumference SMALLINT,
    p_shirt_min_chest_circumference SMALLINT,
    p_shirt_max_chest_circumference SMALLINT,
    p_shirt_min_neck_circumference SMALLINT,
    p_shirt_max_neck_circumference SMALLINT
) AS $$
BEGIN
    IF p_shirt_id IS NULL OR
       p_shirt_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_shirt_length IS NULL OR
       p_shirt_arm_length IS NULL OR
       p_shirt_min_waist_circumference IS NULL OR
       p_shirt_max_waist_circumference IS NULL OR
       p_shirt_min_chest_circumference IS NULL OR
       p_shirt_max_chest_circumference IS NULL OR
       p_shirt_min_neck_circumference IS NULL OR
       p_shirt_max_neck_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_shirt_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_shirt_arm_length <= 0 THEN
        RAISE EXCEPTION 'Arm length must be greater than 0';
    END IF;

    IF p_shirt_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_shirt_max_waist_circumference < p_shirt_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF p_shirt_min_chest_circumference <= 0 THEN
        RAISE EXCEPTION 'Min chest circumference must be greater than 0';
    END IF;

    IF p_shirt_max_chest_circumference < p_shirt_min_chest_circumference THEN
        RAISE EXCEPTION 'Max chest circumference must be greater or equal than min chest circumference';
    END IF;

    IF p_shirt_min_neck_circumference <= 0 THEN
        RAISE EXCEPTION 'Min neck circumference must be greater than 0';
    END IF;

    IF p_shirt_max_neck_circumference < p_shirt_min_neck_circumference THEN
        RAISE EXCEPTION 'Max neck circumference must be greater or equal than min neck circumference';
    END IF;

    IF LENGTH(p_shirt_name) > 30 OR LENGTH(p_shirt_name) < 1 THEN
        RAISE EXCEPTION 'Shirt name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_shirt_name
      AND id <> p_shirt_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Shirt with name % already exists', p_shirt_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_shirt_id
        FOR UPDATE;

        PERFORM 1
        FROM Shirts
        WHERE costume_item_id = p_shirt_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_shirt_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_shirt_id;

        UPDATE Shirts
        SET length = p_shirt_length,
	    arm_length = p_shirt_arm_length,
            min_waist_circumference = p_shirt_min_waist_circumference,
            max_waist_circumference = p_shirt_max_waist_circumference,
            min_chest_circumference = p_shirt_min_chest_circumference,
            max_chest_circumference = p_shirt_max_chest_circumference,
            min_neck_circumference = p_shirt_min_neck_circumference,
            max_neck_circumference = p_shirt_max_neck_circumference
        WHERE costume_item_id = p_shirt_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_pants(
    p_pants_id INT,
    p_pants_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_pants_length SMALLINT,
    p_pants_min_waist_circumference SMALLINT,
    p_pants_max_waist_circumference SMALLINT
) AS $$
BEGIN
    IF p_pants_id IS NULL OR
       p_pants_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_pants_length IS NULL OR
       p_pants_min_waist_circumference IS NULL OR
       p_pants_max_waist_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_pants_length <= 0 THEN
        RAISE EXCEPTION 'Length must be greater than 0';
    END IF;

    IF p_pants_min_waist_circumference <= 0 THEN
        RAISE EXCEPTION 'Min waist circumference must be greater than 0';
    END IF;

    IF p_pants_max_waist_circumference < p_pants_min_waist_circumference THEN
        RAISE EXCEPTION 'Max waist circumference must be greater or equal than min waist circumference';
    END IF;

    IF LENGTH(p_pants_name) > 30 OR LENGTH(p_pants_name) < 1 THEN
        RAISE EXCEPTION 'Pants name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_pants_name
      AND id <> p_pants_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Pants with name % already exists', p_pants_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_pants_id
        FOR UPDATE;

        PERFORM 1
        FROM Pants
        WHERE costume_item_id = p_pants_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_pants_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_pants_id;

        UPDATE Pants
        SET length = p_pants_length,
            min_waist_circumference = p_pants_min_waist_circumference,
            max_waist_circumference = p_pants_max_waist_circumference
        WHERE costume_item_id = p_pants_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_boots(
    p_boots_id INT,
    p_boots_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_boots_shoe_size FLOAT
) AS $$
BEGIN
    IF p_boots_id IS NULL OR
       p_boots_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_boots_shoe_size IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_boots_shoe_size <= 0 THEN
        RAISE EXCEPTION 'Shoe size must be greater than 0';
    END IF;
    IF LENGTH(p_boots_name) > 30 OR LENGTH(p_boots_name) < 1 THEN
        RAISE EXCEPTION 'Boots name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_boots_name
      AND id <> p_boots_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Boots with name % already exists', p_boots_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_boots_id
        FOR UPDATE;

        PERFORM 1
        FROM Boots
        WHERE costume_item_id = p_boots_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_boots_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_boots_id;

        UPDATE Boots
        SET shoe_size = p_boots_shoe_size
        WHERE costume_item_id = p_boots_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE update_neck_accessory(
    p_neck_accessory_id INT,
    p_neck_accessory_name VARCHAR(30),
    p_collection_id SMALLINT,
    p_gender_id SMALLINT,
    p_color_id SMALLINT,
    p_location_id SMALLINT,
    p_neck_accessory_min_neck_circumference SMALLINT,
    p_neck_accessory_max_neck_circumference SMALLINT
) AS $$
BEGIN
    IF p_neck_accessory_id IS NULL OR
       p_neck_accessory_name IS NULL OR
       p_collection_id IS NULL OR
       p_gender_id IS NULL OR
       p_color_id IS NULL OR
       p_location_id IS NULL OR
       p_neck_accessory_min_neck_circumference IS NULL OR
       p_neck_accessory_max_neck_circumference IS NULL THEN
        RAISE EXCEPTION 'All parameters cannot be NULL';
    END IF;

    IF check_if_error_in_costume_item_common_part(p_collection_id, p_gender_id, p_color_id, p_location_id) THEN
        RAISE EXCEPTION 'Something wrong in costume item common part';
    END IF;

    IF p_neck_accessory_min_neck_circumference <= 0 THEN
        RAISE EXCEPTION 'Min neck circumference must be greater than 0';
    END IF;

    IF p_neck_accessory_max_neck_circumference < p_neck_accessory_min_neck_circumference THEN
        RAISE EXCEPTION 'Max neck circumference must be greater or equal than min neck circumference';
    END IF;

    IF LENGTH(p_neck_accessory_name) > 30 OR LENGTH(p_neck_accessory_name) < 1 THEN
        RAISE EXCEPTION 'Neck accessory name can have between 1 and 30 characters';
    END IF;

    PERFORM 1
    FROM Costumes_items
    WHERE name = p_neck_accessory_name
      AND id <> p_neck_accessory_id;

    IF FOUND THEN
        RAISE EXCEPTION 'Neck accessory with name % already exists', p_neck_accessory_name;
    END IF;

    BEGIN
        PERFORM 1
        FROM Costumes_items
        WHERE id = p_neck_accessory_id
        FOR UPDATE;

        PERFORM 1
        FROM Neck_accessories
        WHERE costume_item_id = p_neck_accessory_id
        FOR UPDATE;

        UPDATE Costumes_items
        SET name = p_neck_accessory_name,
            collection_id = p_collection_id,
            gender_id = p_gender_id,
            color_id = p_color_id,
            location_id = p_location_id
        WHERE id = p_neck_accessory_id;

        UPDATE Neck_accessories
        SET min_neck_circumference = p_neck_accessory_min_neck_circumference,
            max_neck_circumference = p_neck_accessory_max_neck_circumference
        WHERE costume_item_id = p_neck_accessory_id;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to update: %', SQLERRM;
    END;
END;
$$ LANGUAGE plpgsql;

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





