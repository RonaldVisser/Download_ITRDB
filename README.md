# Download all tree-ring data from the ITRDB

This repository consists of a script that enables an easy download of all tree-ring data (measurements and chronologies) from the ITRDB (<https://www.ncei.noaa.gov/products/paleoclimatology/tree-ring>), from: <https://www.ncei.noaa.gov/pub/data/paleo/treering>.

Just clone or download this repository to create a local copy of the ITRDB, just in case the data is not available anymore. Just run [download_ITRDB.R](download_ITRDB.R) To update downloaded data, just run the script again. It will check which files are locally available (based on their file name, not the content) and only files that are not available locally will be downloaded.
