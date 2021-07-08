/*  Author: Danny Lillard
 *  Date: 6/8/2021
 *  Desc: Database cleaning for the nashville housing dataset.
 */

--select statement to check work as we go.
SELECT * FROM nashville_housing 
WHERE id = 3299;

--------------------------------------------------------------
--converting string date to a real date.
--This could have been done in the load file.

UPDATE nashville_housing
SET sale_date = STR_TO_DATE(sale_date, "%M %d, %Y");


--------------------------------------------------------------
--Populate property address data.

UPDATE nashville_housing a
JOIN nashville_housing b
    ON a.parcel_id = b.parcel_id
    AND a.id <> b.id
SET a.property_address = b.property_address
WHERE a.property_address = '';
--------------------------------------------------------------
--Breaking up property address into:
--Address, city

ALTER TABLE nashville_housing
ADD COLUMN property_city VARCHAR(30) AFTER property_address;

UPDATE nashville_housing
SET property_city = 
SUBSTRING(property_address, LOCATE(',', property_address)+1);

UPDATE nashville_housing
SET property_city =
SUBSTRING(property_city, 2);

UPDATE nashville_housing
SET property_address = SUBSTRING(property_address, 1, 
LOCATE(',', property_address)-1);
------------------------------------------------------------
--breaking up owner info.
--Address, city, state

ALTER TABLE nashville_housing
ADD COLUMN owner_city VARCHAR(30) AFTER owner_address;
ALTER TABLE nashville_housing
ADD COLUMN owner_state VARCHAR(3) AFTER owner_city;

UPDATE nashville_housing
SET owner_state = 
SUBSTRING_INDEX(SUBSTRING_INDEX(owner_address,',',3),',',-1);

UPDATE nashville_housing
SET owner_city = 
SUBSTRING_INDEX(SUBSTRING_INDEX(owner_address,',',2),',',-1);

UPDATE nashville_housing
SET owner_address = 
SUBSTRING_INDEX(SUBSTRING_INDEX(owner_address,',',1),',',-1);


-----------------------------------------------------------
--changing Yes/No to Y/N from sold_as_vacant

SELECT DISTINCT sold_as_vacant
FROM nashville_housing;

UPDATE nashville_housing
SET sold_as_vacant = 'No'
WHERE sold_as_vacant = 'N';

UPDATE nashville_housing
SET sold_as_vacant = 'Yes'
WHERE sold_as_vacant = 'Y';

-----------------------------------------------------
--Taking out the extra space in the property and owner address.
--Right now an address is like this"123  John Drive" where there are 
--two spaces between the numbers and the street name.

--Finds all like this
SELECT * 
FROM nashville_housing
WHERE property_address LIKE "%  %";
SELECT * 
FROM nashville_housing
WHERE owner_address LIKE "%  %";

--attempt to edit one property address.
UPDATE nashville_housing
SET property_address = REPLACE(property_address, '  ', ' ')
WHERE id = 3299;

--editing the rest.
UPDATE nashville_housing
SET property_address = REPLACE(property_address, '  ', ' ');
UPDATE nashville_housing
SET owner_address = REPLACE(owner_address, '  ', ' ');

SELECT * FROM nashville_housing
WHERE parcel_id = '007 00 0 125.00';


----------------------------------------------------------------
--There are many rows where all values for bedroom, full bath, 
--and half_baths are 0, we should delete these
--as they can interfere with the model.
--We are also deleting all unused land here as well.

DELETE FROM nashville_housing
WHERE 
bedrooms = 0 AND full_bath = 0 AND half_bath = 0;
