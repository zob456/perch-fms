#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL

\c perchfmsdb;

-- Client SCHEMA

CREATE SCHEMA IF NOT EXISTS "GloboGym";

SET SCHEMA 'GloboGym';

CREATE TABLE IF NOT EXISTS "FacilityData"
(
    "FacilityID"        SERIAL PRIMARY KEY NOT NULL,
    "FacilityName"      text               NOT NULL,
    "FacilityAddressID" integer            NOT NULL,
    "FacilityPhone"     integer            NOT NULL,
    "FacilityEmail"     text               NOT NULL,
    "FacilityLogo" text NOT NULL
);

INSERT INTO "FacilityData"("FacilityName", "FacilityAddressID", "FacilityPhone", "FacilityEmail", "FacilityLogo")
VALUES ('GloboGym', 1, 15551234, 'YouCanBeBetter@globogym.com', 'https://image.pngaaa.com/557/871557-middle.png');

CREATE TABLE IF NOT EXISTS "Members"
(
    "MemberID"                  SERIAL PRIMARY KEY NOT NULL,
    "MemberUsername"            text               NOT NULL,
    "MemberFirstName"           text               NOT NULL,
    "MemberLastName"            text               NOT NULL,
    "MemberEmail"               text               NOT NULL,
    "MemberMobilePhone"         integer            NOT NULL,
    "MemberEmergencyContact1ID" integer            NOT NULL,
    "MemberPaymentID"           integer            NOT NULL,
    "MemberUsageID"             integer            NOT NULL,
    "MemberAddressID"           integer            NOT NULL
);

INSERT INTO "Members"("MemberUsername", "MemberFirstName", "MemberLastName", "MemberEmail", "MemberMobilePhone",
                      "MemberEmergencyContact1ID", "MemberPaymentID", "MemberUsageID", "MemberAddressID")
VALUES ('nd$', 'Noah', 'Dreyer', 'noah@helloperch.com', 15553333, 2, 1, 1, 1),
       ('jeinstein', 'Jacob', 'Specht', 'jacob@helloperch.com', 15554444, 3, 2, 2, 2),
       ('zob', 'Zach', 'Bratkovich', 'zob@helloperch.com', 15557777, 1, 3, 3, 3);

CREATE TABLE IF NOT EXISTS "EmergencyContacts"
(
    "EmergencyContactID"        SERIAL PRIMARY KEY NOT NULL,
    "MemberInstructorID"        integer            NOT NULL,
    "EmergencyContactFirstName" text               NOT NULL,
    "EmergencyContactLastName"  text               NOT NULL,
    "MemberRelationship"        text               NOT NULL,
    "EmergencyContactPhone"     integer            NOT NULL,
    "EmergencyContactAddressId" integer            NOT NULL,
    "EmergencyContactEmail"     text               NOT NULL
);

INSERT INTO "EmergencyContacts"("MemberInstructorID", "EmergencyContactFirstName", "EmergencyContactLastName",
                                "MemberRelationship", "EmergencyContactPhone", "EmergencyContactAddressId",
                                "EmergencyContactEmail")
VALUES (1, 'Noah', 'Dreyer', 'Friend', 15553333, 1, 'noah@helloperch.com'),
       (2, 'Jacob', 'Specht', 'Friend', 15554444, 2, 'jacob@helloperch.com'),
       (3, 'Zach', 'Bratkovich', 'Friend', 15557777, 2, 'jacob@helloperch.com'),
       (4, 'Earl', 'Goodman', 'Father', 15557777, 2, 'eg@goodmanfinance.com');

CREATE TABLE IF NOT EXISTS "Address"
(
    "AddressID"    SERIAL PRIMARY KEY NOT NULL,
    "AddressLine1" text               NOT NULL,
    "AddressLine2" text,
    "City"         text               NOT NULL,
    "PostalCode"   integer            NOT NULL,
    "State"        CHAR(2)            NOT NULL,
    "Country"      text               NOT NULL
);

INSERT INTO "Address"("AddressLine1", "AddressLine2", "City", "PostalCode", "State", "Country")
VALUES ('123 Perch St.', 'Ste. 100', 'St. Pete', 33764, 'FL', 'USA'),
       ('123 Perch St.', 'Ste. 100', 'St. Pete', 33764, 'FL', 'USA'),
       ('Who even knows', null, 'Parts Unknown', 33764, 'FL', 'USA'),
       ('1 GloboGym Dr.', null, 'Las Vegas', 88901, 'NV', 'USA');

CREATE TABLE IF NOT EXISTS "Usage"
(
    "SessionID"           SERIAL PRIMARY KEY NOT NULL,
    "MemberID"            integer            NOT NULL,
    "SessionName"         text               NOT NULL,
    "InstructorID"        integer,
    "Date"                timestamp          NOT NULL,
    "IsInstructorLed"     boolean            NOT NULL,
    "IsIndividualSession" bool               NOT NULL DEFAULT false
        CONSTRAINT if_IsSession_then_SessionID_is_not_null
            CHECK ( (NOT "IsInstructorLed") OR ("InstructorID" IS NOT NULL) )
);

INSERT INTO "Usage"("MemberID", "SessionName", "InstructorID", "Date", "IsInstructorLed", "IsIndividualSession")
VALUES (3, 'Not Bleeding your own blood 101', 1, NOW() - INTERVAL '12 HOUR', true, false),
       (1, 'Standard usage', null, NOW() - INTERVAL '10 DAY', false, false),
       (1, 'Standard usage', null, NOW() - INTERVAL '11 DAY', false, false),
       (1, 'Standard usage', null, NOW() - INTERVAL '11 DAY', false, false),
       (1, 'Standard usage', null, NOW() - INTERVAL '15 DAY', false, false),
       (2, 'Standard usage', null, NOW() - INTERVAL '1 DAY', false, false),
       (2, 'Standard usage', 1, NOW() - INTERVAL '11 DAY', true, true),
       (2, 'Standard usage', 1, NOW() - INTERVAL '9 DAY', true, true),
       (2, 'Standard usage', 1, NOW() - INTERVAL '5 DAY', true, true),
       (2, 'Standard usage', null, NOW() - INTERVAL '11 DAY', false, false),
       (2, 'Standard usage', null, NOW() - INTERVAL '15 DAY', false, false),
       (2, 'Standard usage', null, NOW() - INTERVAL '1 DAY', false, false),
       (1, 'Standard usage', null, NOW() - INTERVAL '5 DAY', false, false);

CREATE TABLE IF NOT EXISTS "Instructors"
(
    "InstructorID"                  SERIAL PRIMARY KEY NOT NULL,
    "InstructorUsername"            text               NOT NULL,
    "InstructorFirstName"           text               NOT NULL,
    "InstructorLastName"            text               NOT NULL,
    "Phone"                         integer            not null,
    "Email"                         text,
    "InstructorAddressID"           integer            NOT NULL,
    "InstructorEmergencyContact1ID" integer            NOT NULL,
    "InstructorEmergencyContact2ID" integer,
    "CertificateIDs"                integer[]
);

INSERT INTO "Instructors"("InstructorUsername", "InstructorFirstName", "InstructorLastName", "Phone", "Email",
                          "InstructorAddressID",
                          "InstructorEmergencyContact1ID", "InstructorEmergencyContact2ID", "CertificateIDs")
VALUES ('IAMWhite', 'White', 'Goodman', 15556789, 'NeverBleedUrOwnBlood@globogym.com', 4, 4, null, '{1}');

CREATE TABLE IF NOT EXISTS "Certificates"
(
    "CertificateID"   SERIAL PRIMARY KEY NOT NULL,
    "CertificateName" text               not null
);

INSERT INTO "Certificates"("CertificateName")
VALUES ('Competitive Eater');

CREATE TABLE IF NOT EXISTS "Admins"
(
    "AdminID"        SERIAL PRIMARY KEY NOT NULL,
    "AdminUsername"  text               NOT NULL,
    "AdminFirstName" text               NOT NULL,
    "AdminLastName"  text               NOT NULL
);

CREATE TABLE IF NOT EXISTS "Payment"
(
    "PaymentID"             SERIAL PRIMARY KEY NOT NULL,
    "MemberID"              integer            NOT NULL,
    "PaymentSchedule"       text               NOT NULL,
    "PaymentMethod"         text               NOT NULL,
    "LastTransaction"       timestamp          NOT NULL,
    "LastTransactionAmount" float4             not null
);

INSERT INTO "Payment"("MemberID", "PaymentSchedule", "PaymentMethod", "LastTransaction", "LastTransactionAmount")
VALUES (1, 'Monthly', 'Cash/money', now() - INTERVAL '3 DAY', 40000.00),
       (2, 'Annual', 'Check', now() - INTERVAL '10 DAY', 99.99),
       (3, 'Daily', 'Visa', now() - INTERVAL '4 DAY', 17.56);

-- VIEWS for GloboGym Schema
CREATE VIEW "vw_MemberList"
AS
(
SELECT DISTINCT ON (m."MemberID") m."MemberID",
                                  m."MemberUsername",
                                  m."MemberFirstName",
                                  m."MemberLastName",
                                  a."AddressLine1",
                                  a."AddressLine2",
                                  a."City",
                                  a."PostalCode",
                                  u."SessionName",
                                  u."Date",
                                  i."InstructorUsername"
FROM "GloboGym"."Members" m
         LEFT JOIN "GloboGym"."Address" a on m."MemberAddressID" = a."AddressID"
         LEFT JOIN (SELECT "SessionName",
                           "Date",
                           "MemberID",
                           "InstructorID"
                    FROM "GloboGym"."Usage"
                    ORDER BY "Date" DESC
                    LIMIT 1) u on m."MemberID" = u."MemberID"
         LEFT JOIN "GloboGym"."Instructors" i on u."InstructorID" = i."InstructorID"
    );

CREATE VIEW "vw_Member"
AS
(
SELECT m."MemberID",
       m."MemberUsername",
       m."MemberFirstName",
       m."MemberLastName",
       a."AddressLine1",
       a."AddressLine2",
       a."City",
       a."PostalCode",
       a."Country",
       m."MemberMobilePhone",
       u."SessionName",
       u."Date",
       i."InstructorUsername",
       p."LastTransaction",
       p."PaymentSchedule",
       p."LastTransactionAmount",
       ec."EmergencyContactFirstName",
       ec."EmergencyContactLastName",
       eca."AddressLine1" as "EmergencyContactAddressLine1",
       eca."AddressLine2" as "EmergencyContactAddressLine2",
       eca."City"         as "EmergencyContactCity",
       eca."PostalCode"   as "EmergencyContactPostalCode",
       eca."State"        as "EmergencyContactState",
       eca."Country"      as "EmergencyContactCountry",
       ec."EmergencyContactPhone",
       ec."EmergencyContactEmail",
       ec."MemberRelationship"
FROM "GloboGym"."Members" m
         LEFT JOIN "GloboGym"."Address" a on m."MemberAddressID" = a."AddressID"
         LEFT JOIN (SELECT "SessionName", "Date", "MemberID", "InstructorID"
                    FROM "GloboGym"."Usage"
                    ORDER BY "Date" DESC
                    LIMIT 5) u on m."MemberID" = u."MemberID"
         LEFT JOIN "GloboGym"."Instructors" i on u."InstructorID" = i."InstructorID"
         LEFT JOIN "GloboGym"."EmergencyContacts" ec on m."MemberID" = ec."MemberInstructorID"
         LEFT JOIN "GloboGym"."Address" eca on ec."EmergencyContactAddressId" = eca."AddressID"
         LEFT JOIN (SELECT "LastTransaction", "LastTransactionAmount", "PaymentSchedule", "MemberID"
                    FROM "GloboGym"."Payment"
                    LIMit 1) p on m."MemberID" = p."MemberID"
        LIMIT 1
    );

CREATE VIEW "vw_InstructorList"
AS
(
SELECT DISTINCT ON (i."InstructorID") i."InstructorID",
                                      i."InstructorUsername",
                                      i."InstructorFirstName",
                                      i."InstructorLastName",
                                      i."Email",
                                      i."Phone",
                                      a."AddressLine1",
                                      a."AddressLine2",
                                      a."City",
                                      a."State",
                                      a."PostalCode",
                                      a."Country",
                                      ec."EmergencyContactFirstName",
                                      ec."EmergencyContactLastName",
                                      ec."EmergencyContactPhone",
                                      ec."EmergencyContactEmail",
                                      ec."MemberRelationship"
FROM "GloboGym"."Instructors" i
         LEFT JOIN "GloboGym"."Address" a on i."InstructorAddressID" = a."AddressID"
         LEFT JOIN "GloboGym"."EmergencyContacts" ec on i."InstructorID" = ec."MemberInstructorID"
);

-- SETTINGS SCHEMA

CREATE SCHEMA IF NOT EXISTS settings;

SET SCHEMA 'settings';
CREATE TABLE IF NOT EXISTS "UserSettings"
(
    "SettingID"    SERIAL PRIMARY KEY NOT NULL,
    "SettingName"  text               NOT NULL,
    "SettingValue" text               NOT NULL DEFAULT 'Dark'
);

INSERT INTO settings."UserSettings"("SettingID", "SettingName")
VALUES (1, 'Theme')

EOSQL