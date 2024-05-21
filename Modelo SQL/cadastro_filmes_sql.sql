create table filme (
 id serial primary key,
 nome varchar(70),
 autor varchar(45),
 tipo varchar(30),
 tempo time,
 resumo varchar(500),
 idioma varchar(30),
 idiomalegenda varchar(30)
);

create table espectadores (
 id serial primary key,
 nome varchar(45),
 idade numeric(3),
 sexo varchar(20),
 CEP numeric(20),
 email varchar(50),
 estiloPreferido varchar(40),
 idioma varchar(30)
);

create table filme_espectadores(
 id serial primary key,
 comentario varchar(500),
 notaGeral numeric(2),
 notaAudio numeric(2),
 notaImagem numeric(2),
 notaAtuacao numeric(2),
 notaElenco numeric(2),
 recomenda bool,
 filme_id integer,
 espectadores_id integer,
 FOREIGN KEY (filme_id) REFERENCES filme (id),
 FOREIGN KEY (espectadores_id) REFERENCES espectadores (id)
);