/*  Author: Danny Lillard
 *  Date: 6/8/2021
 *  Desc: Command to populate database for nashville housing data.
 */

LOAD DATA LOCAL INFILE 'D:\\Documents\\Programming\\DAProjects\\NashvilleHousing\\Database\\nashville_housing.csv' 
INTO TABLE nashville_housing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(   id,
    parcel_id,
    land_use,
    property_address,
    sale_date,
    sale_price,
    legal_reference,
    sold_as_vacant,
    owner_name,
    owner_address,
    acreage,
    tax_district,
    land_value,
    building_value,
    total_value,
    year_built,
    bedrooms,
    full_bath,
    half_bath);