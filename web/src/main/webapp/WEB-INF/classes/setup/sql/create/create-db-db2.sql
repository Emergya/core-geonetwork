-- ======================================================================
-- ===   Sql Script for Database : Geonet
-- ===
-- === Build : 153
-- ======================================================================

CREATE TABLE Relations
  (
    id         int not null,
    relatedId  int not null,
    primary key(id,relatedId)
  );

-- ======================================================================

CREATE TABLE Categories
  (
    id    int            not null,
    name  varchar(255)   not null,
    primary key(id),
    unique(name)
  );

-- ======================================================================

CREATE TABLE CustomElementSet
  (
    xpath  varchar(1000)  not null
  );

-- ======================================================================

CREATE TABLE Settings
  (
    name      varchar(512)    not null,
    value     CLOB(1G),
    datatype   int,
    position   int,
    primary key(name)
  );
  
CREATE TABLE HarvesterSettings
  (
    id        int            not null,
    parentId  int,
    name      varchar(64)    not null,
    value     CLOB(1G),
    primary key(id)
  );

-- ======================================================================

CREATE TABLE Languages
  (
    id        varchar(5)   not null,
    name      varchar(32)  not null,
    isInspire char(1)      default 'n',
    isDefault char(1)      default 'n',

    primary key(id)
  );

-- ======================================================================

CREATE TABLE Sources
  (
    uuid     varchar(250)   not null,
    name     varchar(250),
    isLocal  char(1)        default 'y',
    primary key(uuid)
  );

-- ======================================================================

CREATE TABLE IsoLanguages
  (
    id        int          not null,
    code      varchar(3)   not null,
    shortcode varchar(2),
    primary key(id),
    unique(code)
  );

-- ======================================================================

CREATE TABLE IsoLanguagesDes
  (
    idDes   int           not null,
    langId  varchar(5)    not null,
    label   varchar(96)   not null,
    primary key(idDes,langId)
  );

-- ======================================================================

CREATE TABLE Regions
  (
    id     int     not null,
    north  float   not null,
    south  float   not null,
    west   float   not null,
    east   float   not null,
    primary key(id)
  );

-- ======================================================================

CREATE TABLE RegionsDes
  (
    idDes   int           not null,
    langId  varchar(5)    not null,
    label   varchar(96)   not null,
    primary key(idDes,langId)
  );

-- ======================================================================

CREATE TABLE Users
  (
    id            int           not null,
    username      varchar(256)  not null,
    password      varchar(120)  not null,
    surname       varchar(32),
    name          varchar(32),
    profile       varchar(32)   not null,
    address       varchar(128),
    city          varchar(128),
    state         varchar(32),
    zip           varchar(16),
    country       varchar(128),
    email         varchar(128),
    organisation  varchar(128),
    kind          varchar(16),
    security      varchar(128)  default '',
    authtype      varchar(32),
    primary key(id),
    unique(username)
  );

-- ======================================================================

CREATE TABLE Operations
  (
    id        int           not null,
    name      varchar(32)   not null,
    reserved  char(1)       default 'n' not null,
    primary key(id)
  );

-- ======================================================================

CREATE TABLE OperationsDes
  (
    idDes   int           not null,
    langId  varchar(5)    not null,
    label   varchar(96)   not null,
    primary key(idDes,langId)
  );

-- ======================================================================

CREATE TABLE Requests
  (
    id             int             not null,
    requestDate    varchar(30),
    ip             varchar(128),
    query          CLOB(4K),
    hits           int,
    lang           varchar(16),
    sortBy         varchar(128),
    spatialFilter  CLOB(4K),
    type           CLOB(4K),
    simple         int             default 1,
    autogenerated  int             default 0,
    service        varchar(128),
    primary key(id)
  );

CREATE INDEX RequestsNDX1 ON Requests(requestDate);
CREATE INDEX RequestsNDX2 ON Requests(ip);
CREATE INDEX RequestsNDX3 ON Requests(hits);
CREATE INDEX RequestsNDX4 ON Requests(lang);

-- ======================================================================

CREATE TABLE Params
  (
    id          int           not null,
    requestId   int,
    queryType   varchar(128),
    termField   varchar(128),
    termText    varchar(128),
    similarity  float,
    lowerText   varchar(128),
    upperText   varchar(128),
    inclusive   char(1),
    primary key(id),
    foreign key(requestId) references Requests(id)
  );

CREATE INDEX ParamsNDX1 ON Params(requestId);
CREATE INDEX ParamsNDX2 ON Params(queryType);
CREATE INDEX ParamsNDX3 ON Params(termField);
CREATE INDEX ParamsNDX4 ON Params(termText);

-- ======================================================================

CREATE TABLE HarvestHistory
  (
    id             int           not null,
    harvestDate    varchar(30),
    elapsedTime    int,
    harvesterUuid  varchar(250),
    harvesterName  varchar(128),
    harvesterType  varchar(128),
    deleted        char(1)       default 'n' not null,
    info           CLOB(1G),
    params         CLOB(1G),

    primary key(id)

  );

CREATE INDEX HarvestHistoryNDX1 ON HarvestHistory(harvestDate);

-- ======================================================================

CREATE TABLE Groups
  (
    id           int            not null,
    name         varchar(32)    not null,
    description  varchar(255),
    email        varchar(128),
    referrer     int,
    primary key(id),
    unique(name)
  );

-- ======================================================================

CREATE TABLE GroupsDes
  (
    idDes   int           not null,
    langId  varchar(5)    not null,
    label   varchar(96)   not null,
    primary key(idDes,langId)
  );

-- ======================================================================

CREATE TABLE UserGroups
  (
    userId   int          not null,
    groupId  int          not null,
    profile  varchar(32)  not null,
    primary key(userId,groupId,profile)
  );

-- ======================================================================

CREATE TABLE CategoriesDes
  (
    idDes   int            not null,
    langId  varchar(5)     not null,
    label   varchar(255)   not null,
    primary key(idDes,langId)
  );

-- ======================================================================

CREATE TABLE Metadata
  (
    id           int            not null,
    uuid         varchar(250)   not null,
    schemaId     varchar(32)    not null,
    isTemplate   char(1)        default 'n' not null,
    isHarvested  char(1)        default 'n' not null,
    createDate   varchar(30)    not null,
    changeDate   varchar(30)    not null,
    data         CLOB(1G)       not null,
    source       varchar(250)   not null,
    title        varchar(255),
    root         varchar(255),
    harvestUuid  varchar(250)   default null,
    owner        int            not null,
    doctype      varchar(255),
    groupOwner   int            default null,
    harvestUri   varchar(512)   default null,
    rating       int            default 0 not null,
    popularity   int            default 0 not null,
    displayorder int,
    primary key(id),
    unique(uuid)
  );

-- ======================================================================

CREATE TABLE Validation 
  (
    metadataId   int          not null,
    valType      varchar(40)  not null,
    status       int,
    tested       int,
    failed       int,
    valDate      varchar(30),
    
    primary key(metadataId, valType)
);

-- ======================================================================

CREATE TABLE MetadataCateg
  (
    metadataId  int not null,
    categoryId  int not null,
    primary key(metadataId,categoryId)
  );

-- ======================================================================

CREATE TABLE StatusValues
  (
    id        int           not null,
    name      varchar(32)   not null,
    reserved  char(1)       default 'n' not null,
    displayorder int,
    primary key(id)
  );

-- ======================================================================

CREATE TABLE StatusValuesDes
  (
    idDes   int           not null,
    langId  varchar(5)    not null,
    label   varchar(96)   not null,
    primary key(idDes,langId)
  );

-- ======================================================================

CREATE TABLE MetadataStatus
  (
    metadataId      int            not null,
    statusId        int            default 0 not null,
    userId          int            not null,
    changeDate      varchar(30)    not null,
    changeMessage   varchar(2048)  not null,
    primary key(metadataId,statusId,userId,changeDate)
  );

-- ======================================================================

CREATE TABLE OperationAllowed
  (
    groupId      int not null,
    metadataId   int not null,
    operationId  int not null,
    primary key(groupId,metadataId,operationId)
  );

CREATE INDEX OperationAllowedNDX1 ON OperationAllowed(metadataId);

-- ======================================================================

CREATE TABLE MetadataRating
  (
    metadataId  int           not null,
    ipAddress   varchar(32)   not null,
    rating      int           not null,
    primary key(metadataId,ipAddress)
  );

-- ======================================================================

CREATE TABLE MetadataNotifiers
  (
    id         int            not null,
    name       varchar(32)    not null,
    url        varchar(255)   not null,
    enabled    char(1)        default 'n' not null,
    username   varchar(32),
    password   varchar(32),

    primary key(id)
  );

-- ======================================================================

CREATE TABLE MetadataNotifications
  (
    metadataId         int            not null,
    notifierId         int            not null,
    notified           char(1)        default 'n' not null,
    metadataUuid       varchar(250)   not null,
    action             char(1)        not null,
    errormsg           CLOB(1G),
    primary key(metadataId,notifierId)
  );

-- ======================================================================

CREATE TABLE CswServerCapabilitiesInfo
  (
    idField   int           not null,
    langId    varchar(5)    not null,
    field     varchar(32)   not null,
    label     CLOB(1G),

    primary key(idField)
  );

-- ======================================================================

CREATE TABLE Thesaurus
  (
    id           varchar(250)  not null,
    activated    varchar(1),
    primary key(id)
  );
  

CREATE TABLE Services
  (
  
    id         int,
    name       varchar(64)   not null,
    class       varchar(1048)   not null,
    description       varchar(1048),
        
    primary key(id)
  );
  

CREATE TABLE ServiceParameters
  (
    id         int,
    service     int,
    name       varchar(64)   not null,
    value       varchar(1048)   not null,
    
    primary key(id)
  );


-- CREATE INDEX MetadataNDX1 ON Metadata(uuid);
CREATE INDEX MetadataNDX2 ON Metadata(source);
CREATE INDEX MetadataNDX3 ON Metadata(owner);

ALTER TABLE ServiceParameters ADD FOREIGN KEY (service) REFERENCES services (id);
ALTER TABLE CategoriesDes ADD FOREIGN KEY (idDes) REFERENCES Categories (id);
ALTER TABLE CategoriesDes ADD FOREIGN KEY (langId) REFERENCES Languages (id);
ALTER TABLE Groups ADD FOREIGN KEY (referrer) REFERENCES Users (id);
ALTER TABLE GroupsDes ADD FOREIGN KEY (langId) REFERENCES Languages (id);
ALTER TABLE GroupsDes ADD FOREIGN KEY (idDes) REFERENCES Groups (id);
ALTER TABLE IsoLanguagesDes ADD FOREIGN KEY (langId) REFERENCES Languages (id);
ALTER TABLE IsoLanguagesDes ADD FOREIGN KEY (idDes) REFERENCES IsoLanguages (id);
ALTER TABLE Metadata ADD FOREIGN KEY (owner) REFERENCES Users (id);
ALTER TABLE Metadata ADD FOREIGN KEY (groupOwner) REFERENCES Groups (id);
ALTER TABLE Validation ADD FOREIGN KEY (metadataId) REFERENCES Metadata (id);
ALTER TABLE MetadataCateg ADD FOREIGN KEY (categoryId) REFERENCES Categories (id);
ALTER TABLE MetadataCateg ADD FOREIGN KEY (metadataId) REFERENCES Metadata (id);
ALTER TABLE MetadataRating ADD FOREIGN KEY (metadataId) REFERENCES Metadata (id);
ALTER TABLE MetadataStatus ADD FOREIGN KEY (metadataId) REFERENCES Metadata (id);
ALTER TABLE MetadataStatus ADD FOREIGN KEY (statusId) REFERENCES StatusValues (id);
ALTER TABLE MetadataStatus ADD FOREIGN KEY (userId) REFERENCES Users (id);
ALTER TABLE StatusValuesDes ADD FOREIGN KEY (idDes) REFERENCES StatusValues (id);
ALTER TABLE StatusValuesDes ADD FOREIGN KEY (langId) REFERENCES Languages (id);
ALTER TABLE OperationAllowed ADD FOREIGN KEY (operationId) REFERENCES Operations (id);
ALTER TABLE OperationAllowed ADD FOREIGN KEY (groupId) REFERENCES Groups (id);
ALTER TABLE OperationAllowed ADD FOREIGN KEY (metadataId) REFERENCES Metadata (id);
ALTER TABLE OperationsDes ADD FOREIGN KEY (langId) REFERENCES Languages (id);
ALTER TABLE OperationsDes ADD FOREIGN KEY (idDes) REFERENCES Operations (id);
ALTER TABLE RegionsDes ADD FOREIGN KEY (langId) REFERENCES Languages (id);
ALTER TABLE RegionsDes ADD FOREIGN KEY (idDes) REFERENCES Regions (id);
ALTER TABLE HarvesterSettings ADD FOREIGN KEY (parentId) REFERENCES HarvesterSettings (id);
ALTER TABLE UserGroups ADD FOREIGN KEY (userId) REFERENCES Users (id);
ALTER TABLE UserGroups ADD FOREIGN KEY (groupId) REFERENCES Groups (id);
ALTER TABLE MetadataNotifications ADD FOREIGN KEY (notifierId) REFERENCES MetadataNotifiers(id);
ALTER TABLE CswServerCapabilitiesInfo ADD FOREIGN KEY (langId) REFERENCES Languages (id);
