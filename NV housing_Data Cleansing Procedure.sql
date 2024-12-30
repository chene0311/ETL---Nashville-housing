
-- Data Cleansing Procedure for Nashville Housing

CREATE PROCEDURE CleanNashvilleHousing
AS
BEGIN

-- Changes SaleDate to a standard DATE format
UPDATE Nashville_Housing
SET SaleDate = CONVERT (DATE, SaleDate, 101);

-- Updates SaleYear
UPDATE Nashville_Housing
SET SaleYear = YEAR(SaleDate);

-- Splits PropertyAddress into StreetName and City
SELECT
    LEFT(PropertyAddress, CHARINDEX(',', PropertyAddress) - 1) AS StreetName,
    LTRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress))) AS City
FROM Nashville_Housing;

-- Update StreetName and City

UPDATE Nashville_Housing
SET StreetName = LEFT(PropertyAddress, CHARINDEX(',', PropertyAddress) - 1),
	City = LTRIM(SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1, LEN(PropertyAddress)));

-- Removes NULL values from the PropertyAddress column
SELECT PropertyAddress
FROM Nashville_Housing
WHERE PropertyAddress IS NULL;

DELETE FROM Nashville_Housing
WHERE PropertyAddress IS NULL;

END;

-- Call CleanNashvilleHousing Procedure
EXEC CleanNashvilleHousing;