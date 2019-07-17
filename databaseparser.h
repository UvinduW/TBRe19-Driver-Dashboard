#ifndef DATABASEPARSER_H
#define DATABASEPARSER_H

#include <string>
#include <vector>

//https://thispointer.com/how-to-read-data-from-a-csv-file-in-c/

class DatabaseParser
{
public:
    DatabaseParser(std::string filename, std::string delm = ",");

    std::string fileName;
    std::string delimeter;

    // Function to fetch data from CSV
    std::vector<std::vector<std::string> > getData();

};

#endif // DATABASEPARSER_H
