drop table if exists nation cascade;
drop table if exists relation_diplo cascade;
drop table if exists navires cascade;
drop table if exists ports cascade;
drop table if exists voyage cascade;
drop table if exists produits cascade;
drop table if exists cargaison cascade;
drop table if exists "etape transitoire" cascade;



create table nation
(
    nom       char(20),
    id_nation serial
        constraint nation_pk
            primary key
);

create table relation_diplo
(
    nation_id1 integer
        constraint n1
            references nation,
    nation_id2 integer
        constraint n2
            references nation,
    relation   varchar(50),
    debut      date
);


create table navires
(
    id_navire   serial
        constraint navires_pk
            primary key,
    categorie   varchar(20),
    typet       integer,
    volume      integer,
    distancemax integer,
    passagermax integer,
    nation_id   integer
        constraint navires_nation_id_nation_fk
            references nation
);

create table ports
(
    id_port      serial
        constraint ports_pk
            primary key,
    nom          varchar(50),
    localisation varchar(50),
    taille       integer,
    typet        integer,
    nation_id    integer not null
        constraint nid
            references nation
);

create table voyage
(
    id_voyage        serial
        constraint voyage_pk
            primary key,
    id_provenance    integer
        constraint port_provenance
            references ports,
    id_destination   integer
        constraint port_destination
            references ports,
    distance         integer,
    navire_id        integer
        constraint voyage_navires_id_navire_fk
            references navires,
    intercontinental boolean,
    debut            date,
    fin              date,
    voyageur         integer,
    constraint intercontiental
        check (((intercontinental = true) AND (distance >= 1000)) OR (intercontinental <> true))
);

create table produits
(
    id        serial
        constraint produits_pk
            primary key,
    nom       varchar(50),
    perisable boolean not null,
    prix      integer,
    poids     integer
);

create table cargaison
(
    id_cargaison integer not null,
    produit_id   integer not null,
    quantité     integer,
    voyage_id    integer
        constraint cargaison_voyage_id_voyage_fk
            references voyage,
    etape        integer
);

create table "etape transitoire"
(
    port_id             integer
        constraint "etape transitoire_ports_id_port_fk"
            references ports,
    voyage_id           integer
        constraint "etape transitoire_voyage_id_voyage_fk"
            references voyage,
    ordre               integer,
    changement_passager integer
);



