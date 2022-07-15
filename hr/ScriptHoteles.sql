--creación tablas usuarios--

drop table if exists TROLE_SERVER_PERMISSION;
DROP table if exists TUSER_ROLE;
drop table if exists employee;
drop table if exists employee_type;
DROP table if exists TUSER;
DROP table if exists TROLE;
drop table if exists TSERVER_PERMISSION;
drop table if exists TREQUEST_STATISTICS;
drop table if exists TSETTING;
drop table if exists TUSER_PREFERENCE;
drop table if exists TI18N;
drop table if exists TI18N_VALUE;




CREATE TABLE PUBLIC.TUSER(
USER_ VARCHAR(50) NOT NULL PRIMARY KEY,
PASSWORD VARCHAR(50),NAME VARCHAR(50),
SURNAME VARCHAR(50),
EMAIL VARCHAR(50),
NIF VARCHAR(50),
USERBLOCKED TIMESTAMP,
LASTPASSWORDUPDATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FIRSTLOGIN BOOLEAN DEFAULT TRUE);

CREATE  TABLE PUBLIC.TROLE(
ID_ROLENAME INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
ROLENAME VARCHAR(255),
XMLCLIENTPERMISSION VARCHAR(10485760));

CREATE TABLE PUBLIC.TUSER_ROLE(
ID_USER_ROLE INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
ID_ROLENAME INTEGER,
USER_ VARCHAR(50),
CONSTRAINT FK_TUSER FOREIGN KEY(USER_) REFERENCES PUBLIC.TUSER(USER_),
CONSTRAINT FK_TROLE FOREIGN KEY(ID_ROLENAME) REFERENCES PUBLIC.TROLE(ID_ROLENAME));

CREATE  TABLE PUBLIC.TSERVER_PERMISSION(
ID_SERVER_PERMISSION INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
PERMISSION_NAME VARCHAR(10485760));

CREATE TABLE PUBLIC.TREQUEST_STATISTICS(
ID_REQUEST_STATISTICS INTEGER NOT NULL PRIMARY KEY,
SERVICE_NAME VARCHAR(255),
METHOD_NAME VARCHAR(50),
USER_NAME VARCHAR(50),
EXECUTION_DATE DATE,
EXECUTION_TIME INTEGER,
METHOD_PARAMS VARCHAR(5000),
SERVICE_EXCEPTION VARCHAR(5000));

CREATE TABLE TSETTING(
ID_SETTING INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
SETTING_KEY VARCHAR(10485760),
SETTING_VALUE VARCHAR(10485760),
SETTING_COMMENT VARCHAR(10485760));

CREATE TABLE PUBLIC.TUSER_PREFERENCE(
ID_USER_PREFERENCE INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
PREFERENCE_NAME VARCHAR(150),
USER_LOGIN VARCHAR(150),
PREFERENCE_VALUE VARCHAR(10485760));

CREATE  TABLE PUBLIC.TI18N(
ID_I18N INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
CLASS_NAME VARCHAR(150),
I18N_DESCRIPTION VARCHAR(250));

CREATE  TABLE PUBLIC.TI18N_VALUE(
ID_I18N_VALUE INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 34) NOT NULL PRIMARY KEY,
ID_I18N INTEGER NOT NULL,
"KEY" VARCHAR(250),
ES_ES VARCHAR(10485760),
EN_US VARCHAR(10485760),
GL_ES VARCHAR(10485760));

CREATE  TABLE PUBLIC.TROLE_SERVER_PERMISSION(
ID_ROLE_SERVER_PERMISSION INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
ID_ROLENAME INTEGER,ID_SERVER_PERMISSION INTEGER,
CONSTRAINT FK_TROLE_SERVER_PERMISSION FOREIGN KEY(ID_ROLENAME) REFERENCES PUBLIC.TROLE(ID_ROLENAME),
CONSTRAINT FK_TSERVER_PERMISSION FOREIGN KEY(ID_SERVER_PERMISSION) REFERENCES PUBLIC.TSERVER_PERMISSION(ID_SERVER_PERMISSION));

INSERT INTO TUSER VALUES('god','password','name','surname',NULL,'44460713B',NULL,NULL,NULL);
INSERT INTO TROLE VALUES(0,'admin','<?xml version="1.0" encoding="UTF-8"?><security></security>');
INSERT INTO TUSER_ROLE(id_rolename,user_) VALUES(0,'god');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.jee.common.services.user.IUserInformationService/getUserInformation');

INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IUserService/userQuery');

INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingInsert');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingUpdate');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingDelete');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingFreeQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingOcupiedQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingByType');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingFreeByTypeQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingDeleteById');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingcheckintodayQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingUpdateById');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IBookingService/bookingSearchByClient');

INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IClientService/clientQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IClientService/clientInsert');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IClientService/clientUpdate');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IClientService/clientDelete');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IClientService/clientsInDateQuery');

INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeTypeService/employeeTypeQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeTypeService/employeeTypeInsert');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeTypeService/employeeTypeUpdate');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeTypeService/employeeTypeDelete');

INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IHotelService/hotelQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IHotelService/hotelInsert');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IHotelService/hotelUpdate');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IHotelService/hotelDelete');

INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomService/roomQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomService/roomInsert');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomService/roomUpdate');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomService/roomDelete');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomService/roomUpdateStatus');


INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomTypeService/roomTypeQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomTypeService/roomTypeInsert');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomTypeService/roomTypeUpdate');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IRoomTypeService/roomTypeDelete');

INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeService/employeeQuery');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeService/employeeInsert');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeService/employeeUpdate');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeService/employeeDelete');
INSERT INTO TSERVER_PERMISSION(permission_name) VALUES('com.ontimize.hr.api.core.service.IEmployeeService/employeeCreateUser');


INSERT INTO TSETTING VALUES(0,'mail_host','smtp.gmail.com','Host del servidor');
INSERT INTO TSETTING VALUES(1,'mail_port','587','Puerto del servidor de email');
INSERT INTO TSETTING VALUES(2,'mail_protocol','smtp','Protocolo de env\u005cu00edo de mails');
INSERT INTO TSETTING VALUES(3,'mail_user','mi.mail@example.com','Usuario para el env\u005cu00edo de mails');
INSERT INTO TSETTING VALUES(4,'mail_password','mis_credenciales','Password del servidor de mail');
INSERT INTO TSETTING VALUES(5,'mail_encoding','UTF-8','Codificaci\u005cu00f3n de mails');
INSERT INTO TSETTING VALUES(6,'mail_properties','mail.smtp.auth:true;mail.smtp.starttls.enable:true;','Propiedades de mails');
INSERT INTO TSETTING VALUES(7,'report_folder','C:/applications/ontimize-boot-app/reports','Carpeta de las plantillas de report');
INSERT INTO TUSER_PREFERENCE VALUES(0,'user_preference','demo','Iw0KI1R1ZSBNYXkgMTYgMTI6NTc6MDYgQ0VTVCAyMDE3DQpkZW1vX2FwcF9zdGF0dXNfYmFyX3Zpc2libGU9eWVzDQpkZW1vX2FkanVzdF90cmVlX3NwYWNlPXRydWUNCmRlbW9fYXBwX3dpbmRvd19zdGF0ZT0wDQpkZW1vX3RhYmxlX2NvbmZfc29ydF9maWx0ZXJfZm9ybUN1c3RvbWVyLnhtbF9DdXN0b21lclNlcnZpY2UuY3VzdG9tZXJfVEVTVD1udWxsO251bGw7U1VSTkFNRVw9OThcOjF8SURcPTc1XDoyfE5BTUVcPTk5XDozfENVU1RPTUVSVFlQRUlEXD0wXDo0fENVU1RPTUVSSURcPTEyNVw6NXxBRERSRVNTXD0xMjNcOjZ8UEhPTkVcPTEyMVw6N3xTVEFSVERBVEVcPTEzNlw6OHxMT05HSVRVREVcPTExNlw6OXxMQVRJVFVERVw9MTEzXDoxMHxFTUFJTFw9MTcwXDoxMnw7QkFTRTY0ck8wQUJYTnlBQk5xWVhaaExuVjBhV3d1U0dGemFIUmhZbXhsRTdzUEpTRks1TGdEQUFKR0FBcHNiMkZrUm1GamRHOXlTUUFKZEdoeVpYTm9iMnhrZUhBL1FBQUFBQUFBQ0hjSUFBQUFDd0FBQUFCNA0KZGVtb190YWJsZV9jb25mX3NvcnRfZmlsdGVyX2NvbmZpZ3VyYXRpb25zX2Zvcm1DdXN0b21lci54bWxfQ3VzdG9tZXJTZXJ2aWNlLmN1c3RvbWVyPVRFU1QNCmRlbW9fdGFibGVfY29udHJvbF9wYW5lbF9mb3JtQWNjb3VudHMtZGV0YWlsLnhtbF9Nb3ZlbWVudFNlcnZpY2UubW92ZW1lbnQ9Z3JvdXB0YWJsZWtleTtkZWZhdWx0Y2hhcnRidXR0b247ZXhjZWxleHBvcnRidXR0b247c3Vtcm93YnV0dG9uO2NhbGN1bGVkY29sc2J1dHRvbjtwcmludGluZ2J1dHRvbjtmaWx0ZXJzYXZlYnV0dG9uO3Zpc2libGVjb2xzYnV0dG9uO2h0bWxleHBvcnRidXR0b247Y29weWJ1dHRvbjtncm91cHRhYmxla2V5O2luc2VydGJ1dHRvbjtyZWZyZXNoYnV0dG9uDQpkZW1vX2Zvcm1CcmFuY2hlcy1kZXRhaWwueG1sPTg4MDs1MDU7LTExNTA7MzY5DQpkZW1vX2RldGFpbF9kaWFsb2dfc2l6ZV9wb3NpdGlvbl9mb3JtQ3VzdG9tZXIueG1sX0N1c3RvbWVyU2VydmljZS5jdXN0b21lcj03NDk7MzUwOy0xOTA1OzM5MQ0KZGVtb19hcHBfdG9vbGJhcl9sb2NhdGlvbj1Ob3J0aA0KZGVtb19hcHBfd2luZG93X3Bvc2l0aW9uPS0xNTgwOzExDQpkZW1vX2FwcF93aW5kb3dfc2l6ZT0xNTg0OzEwNDQNCmRlbW9fZm9ybUVtcGxveWVlcy1kZXRhaWwueG1sPTExMTY7NzM5OzYxMDsxOTUNCmRlbW9fZm9ybUFjY291bnRzLWRldGFpbC54bWw9OTE1OzUwMDstMTE1MDszNjkNCg==');
INSERT INTO TI18N VALUES(0,'i18n.bundle','Resource bundle in database');

INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,1);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,2);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,3);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,4);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,5);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,6);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,7);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,8);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,9);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,10);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,11);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,12);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,13);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,14);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,15);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,16);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,17);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,18);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,19);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,20);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,21);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,22);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,23);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,24);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,25);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,26);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,27);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,28);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,29);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,30);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,31);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,32);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,33);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,34);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,35);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,36);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,37);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,38);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,39);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,40);
INSERT INTO TROLE_SERVER_PERMISSION(id_rolename,id_server_permission) VALUES(0,41);

select * from trole_server_permission;
--Creación de tablas de hotel--


drop table if exists dates_season;
drop table if exists season;
drop table if exists offers;
drop table if exists booking_details;
drop table if exists details_type;
drop  table if exists booking;
drop table if exists status_booking;
drop  table if exists room;
drop table if exists room_status;
drop table if exists room_type;
drop  table if exists client;
drop table if exists employee_type;
drop table if exists hotel;

CREATE TABLE if not exists hotel(
    htl_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    htl_name varchar(100) NOT NULL,
    htl_city varchar(50),
    htl_address varchar(255),
    htl_zip_code varchar(20),
    htl_email varchar(150),
    htl_phone varchar(20),
    htl_stars integer,
    CONSTRAINT CK_hotel_htl_name CHECK (ltrim(rtrim(hotel.htl_name))<>''),
    CONSTRAINT UQ_hotel_htl_email UNIQUE (htl_email)
);


CREATE TABLE if not exists room_type(
    rtyp_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    rtyp_name varchar(20) NOT NULL,
    rtyp_bed_number integer NOT NULL,
    rtyp_base_price decimal(10,2) NOT NULL,
    CONSTRAINT CK_room_type_rtyp_name CHECK (ltrim(rtrim(room_type.rtyp_name))<>''),
    CONSTRAINT UQ_room_type_rtyp_name UNIQUE (rtyp_name)
);


CREATE TABLE if not exists client(
    cli_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    cli_name varchar(30) NOT NULL,
    cli_surname1 varchar(30) NOT NULL,
    cli_surname2 varchar(30),
    cli_identification varchar(20) not null,
    cli_phone varchar(20),
    cli_email varchar(150),
    CONSTRAINT CK_client_cli_name CHECK (ltrim(rtrim(client.cli_name))<>''),
    CONSTRAINT CK_client_cli_surname1 CHECK (ltrim(rtrim(client.cli_surname1))<>''),
    CONSTRAINT UQ_client_cli_email UNIQUE (cli_email)

);

create table if not exists room_status(
	rsts_id Integer GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
	rsts_status Varchar(50) not null,
	rsts_description varchar(100)
);


CREATE TABLE if not exists room(
   	rom_htl_id INTEGER,
	rom_number varchar(15),
    rom_typ_id integer NOT NULL,
    rom_rsts_id integer,
    rom_status_start date,
    rom_status_end date,
    CONSTRAINT CK_room_rom_number CHECK (ltrim(rtrim(room.rom_number))<>''),
    constraint pk_room primary key (rom_htl_id,rom_number),
    constraint fk_room_room_status foreign key (rom_rsts_id) references room_status(rsts_id)
);

ALTER TABLE room ADD CONSTRAINT fk_type_room FOREIGN KEY(rom_typ_id) REFERENCES room_type(rtyp_id);
ALTER TABLE room ADD CONSTRAINT fk_hotel_room FOREIGN KEY(rom_htl_id) REFERENCES hotel(htl_id);

CREATE TABLE if not exists status_booking(
    sta_bok_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    sta_bok_code varchar(2) not null,
    sta_bok_description varchar(200),
    CONSTRAINT uq_code_status UNIQUE (sta_bok_code)
);

CREATE TABLE if not exists booking(
    bok_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    bok_cli_id integer NOT NULL,
    bok_htl_id INTEGER NOT NULL,
	bok_rom_number varchar(15)NOT NULL,
    bok_entry_date date NOT NULL,
    bok_departure_date date,
    bok_comments varchar(255),
    bok_created_by_user varchar(255),
    bok_created_date timestamp default current_timestamp,
    bok_modified_date timestamp,
    bok_status_code varchar(2) not null DEFAULT 'A',
    bok_final_billing DECIMAL(10,2),
    CONSTRAINT fk_client_booking FOREIGN KEY(bok_cli_id) REFERENCES client(cli_id),
    CONSTRAINT fk_room_booking FOREIGN KEY(bok_rom_number,bok_htl_id) REFERENCES room(rom_number,rom_htl_id),
    CONSTRAINT fk_status_code FOREIGN KEY (bok_status_code) REFERENCES status_booking(sta_bok_code)
);


INSERT INTO status_booking (sta_bok_code,sta_bok_description) VALUES ('A','ACTIVE');
INSERT INTO status_booking (STA_BOK_CODE, STA_BOK_DESCRIPTION) VALUES ('F','FINISHED');
INSERT INTO status_booking (sta_bok_code, sta_bok_description) VALUES ('C','CANCELLED');


create table if not exists employee_type(
	etyp_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
	etyp_name varchar(50) not null,
	etyp_desc varchar(255),
    etyp_role_id integer,
	constraint uq_etyp_name UNIQUE (etyp_name),
    constraint fk_employee_type_trole FOREIGN KEY(etyp_role_id) references trole(id_rolename)
);

create table if not exists employee(
	emp_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
	emp_etyp_id INTEGER,
	emp_name varchar(30) not null,
	emp_surname1 varchar(30) not null,
	emp_surname2 varchar(30),
    emp_birth_date date,
    emp_address varchar(150),
    emp_bank_account varchar(40) not null,
	emp_identification varchar(20) not null,
	emp_email varchar(150),
	emp_phone varchar(20) not null,
	emp_htl_id INTEGER,
	emp_created_date timestamp default current_timestamp,
	emp_usr_user varchar(50),

	constraint uq_emp_identification unique (emp_identification),
    constraint uq_emp_usr_user unique(emp_usr_user),
	constraint fk_employee_type_employee foreign key (emp_etyp_id) references employee_type(etyp_id),
	constraint fk_employee_hotel foreign key (emp_htl_id) references hotel(htl_id),
	constraint fk_employee_user foreign key (emp_usr_user) references tuser(user_)
);

INSERT INTO hotel (htl_name,htl_city,htl_address,htl_zip_code,htl_email,htl_phone,htl_stars) VALUES('Exceptions Hotel Las Vegas','Las vegas','3778 Las Vegas Blvd','NV 89109','lasvegas@exceptionshoteles.com','877.386.5497',5);
INSERT INTO hotel (htl_name,htl_city,htl_address,htl_zip_code,htl_email,htl_phone,htl_stars) VALUES('Exceptions Hotel Vigo','Vigo','Avda Castelao 67','36208','vigo@exceptionshoteles.com','986 50 48 67',2);
INSERT INTO hotel (htl_name,htl_city,htl_address,htl_zip_code,htl_email,htl_phone,htl_stars) VALUES('Exceptions Hotel CoruÃ±a','CoruÃ±a','C\ Riazor 20','52831','corunha@exceptionshoteles.com','983 96 45 12',3);

INSERT INTO room_type(rtyp_name,rtyp_bed_number,rtyp_base_price) VALUES('doble',2,200);
INSERT INTO room_type(rtyp_name,rtyp_bed_number,rtyp_base_price) VALUES('simple',1,120);
INSERT INTO room_type(rtyp_name,rtyp_bed_number,rtyp_base_price) VALUES('suite',1,350);


INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'101',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'102',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'103',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'104',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'105',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'106',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'107',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'108',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'109',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'110',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'201',1);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'202',1);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'203',1);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'1001',3);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'1002',3);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'1003',3);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (1,'1004',3);

INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (2,'101',1);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (2,'102',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (2,'103',3);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (2,'1001',1);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (2,'1002',2);
INSERT INTO room(rom_htl_id,rom_number,rom_typ_id) VALUES (2,'1003',3);

insert into room_status(rsts_status,rsts_description) values ('mantenimiento','habitacion cerrada por mantenimiento');
insert into room_status(rsts_status,rsts_description) values ('reforma','habitacion cerrada por reformas');

insert  into client (cli_name,cli_surname1,cli_surname2,cli_identification,cli_phone,cli_email) values ('CARLOS', 'LOPEZ','LOPEZ','33445566T','344565789','carlos@micorreo.com');
insert  into client (cli_name,cli_surname1,cli_surname2,cli_identification,cli_phone,cli_email) values ('JOSE', 'PÃREZ','MARTINEZ','76545454Y','667788990','jp@mail.net');
insert  into client (cli_name,cli_surname1,cli_surname2,cli_identification,cli_phone,cli_email) values ('JUAN', 'JUAREZ','LOPEZ','3444455556P','22334433','juan@mail.co.uk');

insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,1,'101','2022-06-25','2022-06-30','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,1,'102','2022-06-27','2022-07-02','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,1,'103','2022-07-03','2022-07-04','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,1,'104','2022-07-03','2022-07-07','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,1,'105','2022-06-28','2022-07-07','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,1,'106','2022-07-05','2022-07-07','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (2,1,'106','2022-07-05','2022-07-07','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,1,'103','2022-07-13','2022-07-15','comments');

insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,2,'101','2022-06-25','2022-07-28','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,2,'102','2022-06-15','2022-07-15','comments');
insert into booking (bok_cli_id,bok_htl_id,bok_rom_number,bok_entry_date,bok_departure_date,bok_comments) values (1,2,'103','2022-06-29','2022-07-2','comments');

insert into trole(rolename,xmlclientpermission) values('recepcionista','<?xml version="1.0" encoding="UTF-8"?><security></security>');
insert into trole(rolename,xmlclientpermission) values('botones','<?xml version="1.0" encoding="UTF-8"?><security></security>');

insert into tuser (user_,password,name,surname,email,nif) values('juan','password','juan','Perico','juan-perioc@examlpe.com','11223344J');
insert into tuser (user_,password,name,surname,email,nif) values('Mario','password','Mario','Perico','Mario-perioc@examlpe.com','1122334455J');

insert into employee_type (etyp_name,etyp_desc,etyp_role_id) values('Recepcionista','descripción',1);
insert into employee_type (etyp_name,etyp_desc) values('Limpieza','descripción');

insert into employee(emp_etyp_id,emp_name,emp_surname1,emp_surname2,emp_bank_account, emp_identification,emp_email,emp_phone,emp_htl_id,emp_usr_user)
values('1','Juan','Perico','Palotes','ES 92 5555 6666 7777 5555','11223344J','juan-perico@Yahoo.es','666555444','1','juan');



insert into tuser_role(id_rolename,user_) values(1,'juan');
insert into tuser_role(id_rolename,user_) values(2,'Mario');

insert into trole_server_permission(id_rolename,id_server_permission) values(1,14);

insert into tuser_role(id_rolename,user_) values(1,'Mario');


-- PRECIOS

create table if not exists season(
    sea_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    sea_name varchar(30),
    sea_multiplier integer
);

create table if not exists dates_season(
    dts_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    dts_htl_id integer not null,
    dts_start_date date not null,
    dts_end_date date,
    dts_sea_id integer not null,
    dts_comments varchar(200),
    CONSTRAINT fk_htl_season FOREIGN KEY(dts_htl_id) REFERENCES hotel(htl_id),
    CONSTRAINT fk_season_id_dates FOREIGN KEY (dts_sea_id) REFERENCES season(sea_id)
);

create table if not exists offers(
    ofe_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    ofe_day date not null,
    ofe_htl_id integer not null,
    ofe_rom_typ_id integer not null,
    ofe_night_price decimal(10,2) NOT NULL,
    CONSTRAINT fk_htl_offer FOREIGN KEY(ofe_htl_id) REFERENCES hotel(htl_id),
    CONSTRAINT fk_rom_typ_offer FOREIGN KEY (ofe_rom_typ_id) REFERENCES room_type(rtyp_id)
);

insert into season(sea_name, sea_multiplier) values ('LOW',1);
insert into season(sea_name, sea_multiplier) values ('HIGH',1.5);

-- semana santa
insert into dates_season (dts_htl_id, dts_start_date, dts_end_date, dts_sea_id, dts_comments) values
                        (2,'2022-04-10','2022-04-17',2,'Holy Week hotel Vigo');
-- navidades
insert into dates_season(dts_htl_id, dts_start_date, dts_end_date, dts_sea_id, dts_comments) values
                        (2,'2022-12-24','2023-01-6',2,'Christmas hotel Vigo');

-- verano
insert into dates_season(dts_htl_id, dts_start_date, dts_end_date, dts_sea_id, dts_comments) values
                        (2,'2022-07-01','2022-08-31',2,'Summer hotel Vigo');

-- san valentin
insert into dates_season(dts_htl_id, dts_start_date, dts_sea_id, dts_comments) values
                        (2,'2022-02-14',2,'Valentine''s Day hotel Vigo');

--inserto oferta dia aleatorio, 25 de julio, hotel vigo(2) en tipo doble(1), suele valer 200 la pongo a 150
insert into offers (ofe_day, ofe_htl_id, ofe_rom_typ_id, ofe_night_price) values
                    ('2022-07-25',2,1,150);


create table if not exists details_type(
    det_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    det_code varchar(5) not null,
    det_description varchar(200),
    CONSTRAINT uq_code_det UNIQUE (det_code)
);

create table if not exists booking_details(
    bok_det_id INTEGER GENERATED BY DEFAULT AS IDENTITY(START WITH 1) NOT NULL PRIMARY KEY,
    bok_det_bok_id INTEGER NOT NULL,
    bok_det_type INTEGER NOT NULL,
    bok_det_price decimal (10,2) not null,
    bok_det_date DATE not null,
    bok_det_paid BOOLEAN NOT NULL,
    CONSTRAINT fk_bok_id FOREIGN KEY (bok_det_bok_id) REFERENCES booking(bok_id),
    CONSTRAINT fk_details_type FOREIGN KEY (bok_det_type) REFERENCES details_type(det_id)
);

-- inserto tipo de gastos
insert into details_type(det_code, det_description) values ('NIGHT','Price room night');
insert into details_type(det_code, det_description) values ('LNDRY','Laundry service');
insert into details_type(det_code, det_description) values ('BRKFS','Breakfast');
insert into details_type(det_code, det_description) values ('MNBAR','Minibar');



-- inserto ejemplo bok_details
insert into booking_details(bok_det_bok_id, bok_det_type, bok_det_date ,bok_det_price,bok_det_paid) values
                            (1,2,'2022-06-27',25,false);

