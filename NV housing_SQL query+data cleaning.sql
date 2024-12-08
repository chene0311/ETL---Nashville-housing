
-- Check if the dataset has been successfully imported
SELECT TOP 10 * 
FROM Nashville_Housing;

-- < DATA CLEANING> --
-- Changes SaleDate to a standard DATE format
UPDATE Nashville_Housing
SET SaleDate = CONVERT (DATE, SaleDate, 101);

-- Adds a new column SaleYear
ALTER TABLE Nashville_Housing
ADD SaleYear INT;

UPDATE Nashville_Housing
SET SaleYear = YEAR(SaleDate);

-- Splits PropertyAddress into StreetName and City
SELECT
    LEFT(PropertyAddress, CHARINDEX(',', PropertyAddress) - 1) AS StreetName,
    LTRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))) AS City
FROM Nashville_Housing;

-- Adds new columns for StreetName and City
ALTER TABLE Nashville_Housing
ADD StreetName VARCHAR(255),
	City VARCHAR(255);

UPDATE Nashville_Housing
SET StreetName = LEFT(PropertyAddress, CHARINDEX(',', PropertyAddress) - 1),
	City = LTRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)));

-- Removes NULL values from the PropertyAddress column
SELECT PropertyAddress
FROM Nashville_Housing
WHERE PropertyAddress IS NULL;

DELETE FROM Nashville_Housing
WHERE PropertyAddress IS NULL;


