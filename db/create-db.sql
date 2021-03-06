DROP DATABASE IF EXISTS halp;
CREATE DATABASE halp;

\c halp;

DROP TABLE IF EXISTS dishInMenu;
DROP TABLE IF EXISTS purchase;
DROP TABLE IF EXISTS bookLoan;
DROP TABLE IF EXISTS menuChoice;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS patientOrder;
DROP TABLE IF EXISTS bookCopy;
DROP TABLE IF EXISTS itemCopy;
DROP TABLE IF EXISTS item;
DROP TABLE IF EXISTS employee;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS book;
DROP TABLE IF EXISTS dish;

DROP TYPE IF EXISTS role;
DROP TYPE IF EXISTS dishType;

CREATE TYPE role AS ENUM ('book', 'kiosk', 'food', 'assistant', 'admin');
CREATE TYPE dishType AS ENUM ('first', 'second', 'dessert');

CREATE TABLE employee (
  username VARCHAR PRIMARY KEY,
  password VARCHAR NOT NULL,
  role role NOT NULL
);

CREATE TABLE patient (
  username VARCHAR PRIMARY KEY,
  password VARCHAR NOT NULL,
  name VARCHAR NOT NULL,
  lastname VARCHAR NOT NULL,
  description VARCHAR,
  birthdate DATE NOT NULL,
  room VARCHAR NOT NULL
);

CREATE TABLE book (
  ID SERIAL PRIMARY KEY,
  title VARCHAR NOT NULL,
  author VARCHAR,
  description VARCHAR NOT NULL,
  image VARCHAR NOT NULL
);

CREATE TABLE dish (
  ID SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  description VARCHAR NOT NULL,
  image VARCHAR NOT NULL,
  type dishType NOT NULL
);

CREATE TABLE menu (
  ID SERIAL PRIMARY KEY,
  menuDate TIMESTAMP NOT NULL,
  UNIQUE (menuDate)
);

CREATE TABLE item (
  ID SERIAL PRIMARY KEY,
  name VARCHAR NOT NULL,
  description VARCHAR NOT NULL,
  image VARCHAR NOT NULL,
  price INTEGER NOT NULL
);

CREATE TABLE patientOrder (
  ID SERIAL PRIMARY KEY,
  orderDate TIMESTAMP NOT NULL,
  idPatient VARCHAR REFERENCES patient(username) ON UPDATE CASCADE ON DELETE CASCADE,
  completed BOOLEAN NOT NULL
);

CREATE TABLE bookCopy (
  referenceNumber SERIAL PRIMARY KEY,
  idBook INTEGER REFERENCES book(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  reserved BOOLEAN NOT NULL
);

CREATE TABLE itemCopy (
  referenceNumber VARCHAR PRIMARY KEY,
  idItem INTEGER REFERENCES item(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bookLoan (
  ID INTEGER PRIMARY KEY REFERENCES patientOrder(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  referenceNumber INTEGER  REFERENCES bookCopy(referenceNumber) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE purchase (
  ID INTEGER PRIMARY KEY REFERENCES patientOrder(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  referenceNumber VARCHAR REFERENCES itemCopy(referenceNumber) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE menuChoice (
  ID INTEGER PRIMARY KEY REFERENCES patientOrder(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  idFirst INTEGER REFERENCES dish(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  idSecond INTEGER REFERENCES dish(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  idDessert INTEGER REFERENCES dish(ID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE dishInMenu (
  idDish INTEGER REFERENCES dish(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  idMenu INTEGER REFERENCES menu(ID) ON UPDATE CASCADE ON DELETE CASCADE,
  PRIMARY KEY(idDish, idMenu)
);
