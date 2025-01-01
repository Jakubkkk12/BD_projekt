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







