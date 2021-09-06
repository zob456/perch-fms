-- MESSAGES SCHEMA

CREATE SCHEMA IF NOT EXISTS PlanetFitness;

SET SCHEMA 'PlanetFitness';
CREATE TABLE IF NOT EXISTS "Members"
(
    "MemberID"                  SERIAL PRIMARY KEY NOT NULL,
    "MemberFirstName"           text               NOT NULL,
    "MemberLastName"            text               NOT NULL,
    "MemberEmail"               text               NOT NULL,
    "MemberMobilePhone"         integer            NOT NULL,
    "MemberEmergencyContact1ID" integer            NOT NULL,
    "MemberPaymentID"           integer            NOT NULL,
    "MemberUsageID"             integer            NOT NULL
);

CREATE TABLE IF NOT EXISTS "Channels"
(
    "ChannelID"   SERIAL PRIMARY KEY NOT NULL,
    "ProviderIDs" integer[]          NOT NULL,
    "PatientID"   integer            NOT NULL,
    "AdvocateIDs" integer[]
);

SET SCHEMA 'messages';
CREATE TABLE IF NOT EXISTS "Users"
(
    "UserID"        SERIAL PRIMARY KEY NOT NULL,
    "UserName"      text               NOT NULL,
    "UserRoleID"    integer            NOT NULL,
    -- UserRoleId maps to the roles table to pull the RoleName
    "UserFirstName" text               NOT NULL,
    "UserLastName"  text               NOT NULL
);

-- SETTINGS SCHEMA

CREATE SCHEMA IF NOT EXISTS settings;

SET SCHEMA 'settings';
CREATE TABLE IF NOT EXISTS "Roles"
(
    "RoleID"   SERIAL PRIMARY KEY NOT NULL,
    "TypeID"   integer            NOT NULL,
    "RoleName" text               NOT NULL
);

SET SCHEMA 'settings';
CREATE TABLE IF NOT EXISTS "Types"
(
    "TypeID"   SERIAL PRIMARY KEY NOT NULL,
    "TypeName" text               NOT NULL
);

INSERT INTO settings."Roles" ("TypeID", "RoleName")
VALUES (1, 'Provider'),
       (2, 'Patient'),
       (3, 'Doctor'),
       (4, 'Nurse'),
       (5, 'Office Manager'),
       (6, 'Advocate');

INSERT INTO settings."Types"("TypeID", "TypeName")
VALUES (1, 'Provider'),
       (2, 'Patient'),
       (3, 'Text'),
       (4, 'File');