CREATE TABLE IF NOT EXISTS JobPostings (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    CompanyName TEXT,
    JobTitle TEXT,
    JobDescription TEXT,
    DangerLevel INTEGER,
    PostedDate TEXT,
    ExpireDate TEXT
);
