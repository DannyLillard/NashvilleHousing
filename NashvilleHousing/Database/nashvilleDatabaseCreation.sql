/*  Author: Danny Lillard
 *  Date: 6/7/2021
 *  Desc: Database description for the nashville housing dataset.
 */

CREATE TABLE nashville_housing(
    id INT UNIQUE PRIMARY KEY NOT NULL,
    parcel_id VARCHAR(17),
    land_use VARCHAR(60),
    property_address VARCHAR(45),
    --putting sale date as string to change it later.
    sale_date VARCHAR(20),
    sale_price INT,
    legal_reference VARCHAR(17),
    sold_as_vacant VARCHAR(3),
    owner_name VARCHAR(70),
    owner_address VARCHAR(50),
    acreage DECIMAL(6,2),
    tax_district VARCHAR(30),
    land_value INT,
    building_value INT,
    total_value INT,
    year_built INT,
    bedrooms INT,
    full_bath INT,
    half_bath INT
);